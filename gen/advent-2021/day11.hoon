:: advent of code 2021 day 11
:: https://adventofcode.com/2021/day/11
::
/*  puzzle-input  %txt  /lib/advent-2021/day11/txt

:-  %say
|=  *
=<
:-  %noun  (day11-solve-2 puzzle-input)

|%
+$  day11-omatrix  [(list @ud) @ud @ud]
::
++  day11-cart
  |*  [a=(list *) b=(list *)]
  =>  .(a ^.(homo a), b ^.(homo b))
  =/  ai=_a  a
  =/  bi=_b  b
  =/  l=(list [_?>(?=(^ a) i.a) _?>(?=(^ b) i.b)])  ~
  |-
  ^+  l
  ?~  ai
    (flop l)
  ?~  bi
    $(ai t.ai, bi b)
  $(bi t.bi, l [[i.ai i.bi] l])
++  day11-enum
  |*  a=(list *)
  =>  .(a ^.(homo a))
  =/  i=@ud  0
  =/  l=(list [_?>(?=(^ a) i.a) @ud])  ~
  |-
  ^+  l
  ?~  a
    (flop l)
  $(a t.a, i +(i), l [[i.a i] l])
::
++  day11-om
  |_  [l=(list @ud) w=@ud h=@ud]
  ::
  ++  step
    |-
    ^-  [@ud day11-omatrix]
    =/  f=@ud  0
    =.  l  (turn l |=(i=@ud +(i)))
    |-
    ^-  [@ud day11-omatrix]
    =+  p=(skim (day11-enum l) |=([v=@ud i=@ud] (gte v 10)))
    ?:  =(p ~)
      [f [l w h]]
    %=  $
      f  (add f (lent p))
      l  (roll p |:([[v=0 i=0] a=l] -:(~(flid . [a w h]) i)))
    ==
  ++  flal
    |-
    ^-  ?
    (levy l |=(i=@ud =(i 0)))
  ::
  ++  flid
    |=  i=@ud
    ^-  day11-omatrix
    ?:  (lth (snag i l) 10)  !!
    =/  ajids=(set @ud)  (silt (ajid i))
    :_  :_  h  w
    %+  turn  (day11-enum (snap l i 0))
      |=  [v=@ud i=@ud]
      ^-  @ud
      :: v += v != 0 and i in ajids
      %+  add  v
      `@ud`?!(&(?!(=(v 0)) (~(has in ajids) i)))
  ++  ajxy
    |=  [x=@ud y=@ud]
    ^-  (list [@ud @ud])
    =+  [sx=(sun:si x) sy=(sun:si y)]
    :: list of valid candidate adjacencies as [@ud @ud] (not [@sd @sd])
    %-  turn
      :_  |=([ix=@sd iy=@sd] [(moon ix) (moon iy)])
      :: list of valid candidate adjacencies between [0 w]x[0 h]
      %-  skim
        :_  |=(ic=[@sd @sd] &((xyok ic) ?!(=(ic [sx sy]))))
        :: list of candidate adjacencies [x+/-1 y+/-1]
        %+  turn
          (day11-cart ~[-1 --0 --1] ~[-1 --0 --1])
          |=([ix=@sd iy=@sd] [(sum:si sx ix) (sum:si sy iy)])
  ++  ajid
    |=  i=@ud
    ^-  (list @ud)
    =+  xy=(idxy i)
    (turn (ajxy xy) xyid)
  ::
  ++  idxy
    |=  i=@ud
    ^-  [@ud @ud]
    :-  (mod i w)
    (div i w)
  ::
  ++  xyid
    |=  [x=@ud y=@ud]
    ^-  @ud
    (add x (mul y w))
  ::
  ++  xyok
    |=  [x=@sd y=@sd]
    ^-  ?
    ?&
      |(=((cmp:si x --0) --0) =((cmp:si x -1) --1))  :: x >= 0
      |(=((cmp:si y --0) --0) =((cmp:si y -1) --1))  :: y >= 0
      =((cmp:si x (sun:si w)) -1)                    :: x < w
      =((cmp:si y (sun:si h)) -1)                    :: y < h
    ==
  ::
  ++  moon
    |=  i=@sd
    ^-  @ud
    +:(old:si i)
  --
::
++  day11-parse
  :: given: a matrix of dumbo octopus energy levels from 0-9 (as @tas)
  :: return: a matrix of dumbo octopus energy levels 0-9 (as @ud)
  |=  input=wain   :: (list @t)
  ^-  day11-omatrix
  ?~  input  !!
  =-  [(zing ilist) (lent (trip i.input)) (lent input)]
    ^=  ilist
    %+  turn  input
    |=(i=@t (rash i (star dit)))
::
++  day11-solve-1
  :: given: a matrix of dumbo octopus energy levels from 0-9
  :: return: the number of dumbo octopus flashes after 100 steps
  |=  input=wain   :: (list @t)
  ^-  @ud
  =+  matrx=(day11-parse input)
  =<  -:.
  %+  roll  (gulf 1 100)
    |:  [i=0 [af=0 am=matrx]]
    =^  i   am   ~(step day11-om am)
    [(add af i) am]
::
++  day11-solve-2
  :: given: a matrix of dumbo octopus energy levels from 0-9
  :: return: the first step during which all octopi flash at once
  |=  input=wain   :: (list @t)
  ^-  @ud
  =+  matrx=(day11-parse input)
  =/  i=@ud  0
  |-
  ?:  ~(flal day11-om matrx)
    i
  %=  $
    i      +(i)
    matrx  =<(+:. ~(step day11-om matrx))
  ==
--
