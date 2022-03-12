:: advent of code 2021 day 5
:: https://adventofcode.com/2021/day/5
::
/*  puzzle-input  %txt  /lib/advent-2021/day5/txt

:-  %say
|=  *
=<
:-  %noun  (day5-solve-2 puzzle-input)

|%
+$  day5-board   (list (list @ud))             :: (y, x); @ is # vents
+$  day5-coord   [x=@ud y=@ud]
+$  day5-vent    [o=day5-coord f=day5-coord]   :: xo,yo -> xf,yf
+$  day5-coords  (list day5-coord)             :: [xo,yo;x1,yo...xf,yo]
::
++  day5-zip
  |*  [a=(list *) b=(list *)]
  ?~  a  ~
  ?~  b  ~
  [[i.a i.b] $(a t.a, b t.b)]
::
++  day5-parse
  :: given: xo,yo -> xf,yf ...
  :: return: ~[[o=[x=xo y=yo] f=[x=xf y=yf]] ...]
  |=  input=wain  :: (list @t)
  ^-  (list day5-vent)
  =-  (turn input parse-vent)
  ^=  parse-vent
    |=  input=@t
    ^-  day5-vent
    =-  :-
      o=[x=-<.raw-vent y=->.raw-vent]
      f=[x=+<.raw-vent y=+>.raw-vent]
    ^=  raw-vent
      %+  rash  input
      ;~  (glue (jest ' -> '))
        ;~((glue com) dem dem)
        ;~((glue com) dem dem)
      ==
::
++  day5-vent-coords
  :: given: [o=[x=xo y=yo] f=[x=xf y=yf]], diags?
  :: return: ~[[x=xo y=yo] [x=xo+1 y=yo] ... [x=xf y=yo]] (+ diagonals)
  |=  [vent=day5-vent diag=bean]
  ^-  day5-coords
  =+  xmin=(min x.o.vent x.f.vent)
  =+  xmax=(max x.o.vent x.f.vent)
  =+  ymin=(min y.o.vent y.f.vent)
  =+  ymax=(max y.o.vent y.f.vent)
  ?:  =(xmin xmax) :: vertical
    (turn (gulf ymin ymax) |=(vcur=@ [x=xmin y=vcur]))
  ?:  =(ymin ymax) :: horizontal
    (turn (gulf xmin xmax) |=(vcur=@ [x=vcur y=ymin]))
  ?:  &(diag =((sub ymax ymin) (sub xmax xmin))) :: diagonal
    %+  day5-zip  (gulf xmin xmax)
      ?:  =((lth x.o.vent x.f.vent) (lth y.o.vent y.f.vent))
        (gulf ymin ymax)
      (flop (gulf ymin ymax))
  ~
::
++  day5-vent-board
  :: given: all vent coordinates ~[[x=xo y=yo] [x=xo+1 y=yo] ... [x=xf y=yo]]
  :: return: board b where (snag x (snag y b)) is # vents at (x, y)
  |=  cords=day5-coords
  ^-  day5-board
  =/  board=day5-board  (reap 1.000 (reap 1.000 0))   :: manual; could be auto
  |-  ^-  day5-board
  ?~  cords
    board
  =+  ncord=i.cords
  =+  ybord=(snag y.ncord board)
  =+  ncval=(snag x.ncord ybord)                      :: b[y][x]
  =+  nline=(snap ybord x.ncord +(ncval))             :: b[y][x]++
  $(cords t.cords, board (snap board y.ncord nline))  :: b'[y] = b[y]
::
++  day5-solve
  :: given: input as vent specs "%d,%d -> %d,%d", and problem id as int
  :: return: the number of points where at least two straight vents overlap
  ::   (problem id determines what types of vents are included)
  |=  [input=wain ident=@ud]   :: (list @t)
  ^-  @ud
  =+  idiag==(ident 2)
  =+  vents=(day5-parse input)
  =+  cords=(zing (turn vents |=(v=day5-vent (day5-vent-coords v idiag))))
  =+  board=(day5-vent-board cords)
  %+  roll  board
    |=  [ybord=(list @ud) accum=@ud]
    ^-  @ud
    %+  add  accum
    (roll ybord |=([n=@ud a=@ud] (add a `@ud`(lth n 2))))
::
++  day5-solve-1
  :: given: input as vent specs "%d,%d -> %d,%d"
  :: return: the number of points where at least two straight vents overlap
  |=  input=wain   :: (list @t)
  ^-  @ud
  (day5-solve input 1)
::
++  day5-solve-2
  :: given: input as vent specs "%d,%d -> %d,%d"
  :: return: the number of points where at least two straight/diagonal vents overlap
  |=  input=wain   :: (list @t)
  ^-  @ud
  (day5-solve input 2)
--
