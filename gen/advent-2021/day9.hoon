:: advent of code 2021 day 9
:: https://adventofcode.com/2021/day/9
::
/*  puzzle-input  %txt  /lib/advent-2021/day9/txt

:-  %say
|=  *
=<
:-  %noun  (day9-solve-2 puzzle-input)

|%
++  day9-zip
  |*  [a=(list *) b=(list *)]
  ?~  a  ~
  ?~  b  ~
  [[i.a i.b] $(a t.a, b t.b)]
:: NOTE: Using a separate init function is how maps/sets/etc work in the
:: standard library. That strategy may not be perfectly applicable for
:: this case, but I wanted to experiment with doors.
:: NOTE: Also using signed integers in order to make off-edge calculations
:: in the `day9-board` arms.
++  day9-binit
  |=  i=(list (list @ud))
  ^-  [@sd @sd (list @sd)]
  ?~  i  !!
  :+  w=(sun:si (lent i.i))
  h=(sun:si (lent i))
  v=(turn `(list @ud)`(zing i) |=(j=@ud `@sd`(sun:si j)))
::
++  day9-board
  |_  [w=@sd h=@sd v=(list @sd)]
  ::
  :: user functions
  ::
  ++  lows
    |-
    ^-  (list [@sd @sd])
    %-  turn
      :_  idxy
      %+  skim  (turn (gulf 0 (sub size 1)) sun:si)
        |=  i=@sd
        ^-  ?
        =+  a=(snig i)
        %+  levy  (ajid i)
          |=([x=@sd y=@sd] (lth a (snag [x y])))
  ::
  ++  bsns
    |-
    ^-  (list (set [@sd @sd]))
    =+  bpnts=lows  :: NOTE: does this compute and cache result?
    %+  turn  (day9-zip bpnts (reap (lent bpnts) *(set [@sd @sd])))
      |=  [i=[@sd @sd] s=(set [@sd @sd])]
      ^-  (set [@sd @sd])
      ?:  |((~(has in s) i) =((snag i) 9))
        s
      =.  s  (~(put in s) i)
      %+  roll  (ajxy i)
        |:  [n=[--0 --0] a=s]
        ^-  (set [@sd @sd])
        (~(uni in a) ^$(i n, s a))
  ::
  ++  snag
    |=  [x=@sd y=@sd]
    ^-  @ud
    ?:  !(xyok [x y])  !!
    %-  toud
    (^snag (toud (xyid [x y])) v)
  ::
  ++  snig
    |=  i=@sd
    ^-  @ud
    ?:  !(idok i)  !!
    %-  toud
    (^snag (toud i) v)
  ::
  ++  size
    |-
    ^-  @ud
    (toud (pro:si w h))
  ::
  :: internal functions
  ::
  ++  ajxy
    |=  [x=@sd y=@sd]
    ^-  (list [@sd @sd])
    %-  skim
      :_  xyok
      ^-  (list [@sd @sd])  :~
        :-  (sum:si x --1)  (sum:si y --0)
        :-  (sum:si x -1)   (sum:si y --0)
        :-  (sum:si x --0)  (sum:si y --1)
        :-  (sum:si x --0)  (sum:si y -1)
      ==
  ::
  ++  ajid
    |=  i=@sd
    ^-  (list [@sd @sd])
    (ajxy (idxy i))
  ::
  ++  xyid
    |=  [x=@sd y=@sd]
    ^-  @sd
    (sum:si x (pro:si y w))
  ::
  ++  idxy
    |=  i=@sd
    ^-  [@sd @sd]
    :: NOTE: Very strange behavior from `dul:si`; it expects `[@sd @ud]`
    :: and then returns `@sd`.
    :-  (sun:si (dul:si i (toud w)))
    (fra:si i w)
  ::
  ++  xyok
    |=  [x=@sd y=@sd]
    ^-  ?
    ?&
      |(=((cmp:si x --0) --0) =((cmp:si x -1) --1))  :: x >= 0
      |(=((cmp:si y --0) --0) =((cmp:si y -1) --1))  :: y >= 0
      =((cmp:si x w) -1)                             :: x < w
      =((cmp:si y h) -1)                             :: y < h
    ==
  ::
  ++  idok
    |=  i=@sd
    ^-  ?
    ?&
      |(=((cmp:si i --0) --0) =((cmp:si i -1) --1))  :: i >= 0
      =((cmp:si i (pro:si w h)) -1)                  :: i < w*h
    ==
  ::
  ++  toud
    :: NOTE: This is a bit hacky, but it works for all positive values.
    |=  i=@sd
    ^-  @ud
    +:(old:si i)
  --
::
++  day9-parse
  :: given: matrix of characters indicating heights of (x, y) positions
  :: return: matrix of numbers indicating heights of (x, y) positions
  |=  input=wain   :: (list @t)
  ^-  (list (list @ud))
  %+  turn  input
  |=(i=@t (rash i (star dit)))
::
++  day9-solve-1
  :: given: matrix of characters indicating heights of (x, y) positions
  :: return: the sum of all low points within the height matrix
  |=  input=wain   :: (list @t)
  ^-  @ud
  =+  board=(day9-binit (day9-parse input))
  =+  bsnag=~(snag day9-board board)
  %+  roll  ~(lows day9-board board)
    |=([n=[@sd @sd] a=@ud] (add a +((bsnag n))))
::
++  day9-solve-2
  :: given: matrix of characters indicating heights of (x, y) positions
  :: return: the multiplication of sizes for the three largest basins
  ::   (where a basin is a connected component of non-9 values)
  |=  input=wain   :: (list @t)
  ^-  @ud
  =+  board=(day9-binit (day9-parse input))
  =+  bbsns=~(bsns day9-board board)
  :: NOTE: multiply the sizes of the three biggest basins, i.e. the
  :: first three entries on the descending list of basin sizes
  %-  roll  :_  mul
    %+  scag  3
    %-  sort  :_  gth
    (turn bbsns |=(i=(set [@sd @sd]) ~(wyt in i)))
--
