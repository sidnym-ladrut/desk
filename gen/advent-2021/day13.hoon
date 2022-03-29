:: advent of code 2021 day 13
:: https://adventofcode.com/2021/day/13
::
/*  puzzle-input  %txt  /lib/advent-2021/day13/txt

:-  %say
|=  *
=<
:-  %noun  (day13-solve-2 puzzle-input)

|%
+$  day13-ftype  ?(%up %left)
+$  day13-finst  [day13-ftype @ud]
+$  day13-coord  [@ud @ud]
::
++  day13-in2ci  :: instruction-to-coordindex (i.e. [major minor])
  |=  [f=day13-finst c=day13-coord]
  ^-  [@ud @ud]
  ?-  -.f
    %up    [+.c -.c]
    %left  [-.c +.c]
  ==
::
++  day13-dm  :: dot-matrix
  |_  l=(list day13-coord)
  ::
  ++  fold
    |=  f=day13-finst
    ^-  (list day13-coord)
    ::  slis:=[untransformed-coords to-transform-coords]
    =+  slis=(skid l |=(i=day13-coord (lth -:(day13-in2ci f i) +.f)))
    =-  ~(tap in (silt (weld p.-.slis pslis)))
    ::  fold all coords in +.slis; discard out of [0, +.f) range
    ^=  pslis
    %-  turn  :_  |=(i=[@sd @sd] [+:(old:si -.i) +:(old:si +.i)])
    %-  skim  :_  |=(i=[@sd @sd] (xyok -.i +.i f))
    %+  turn  q.+.slis
    |=  i=[@ud @ud]
    ^-  [@sd @sd]
    =+  a=(sun:si +.f)
    =+  c=(day13-in2ci f i)
    =+  d=[(dif:si a (dif:si (sun:si -.c) a)) (sun:si +.c)]
    ?-  -.f
      %up    [+.d -.d]
      %left  [-.d +.d]
    ==
  ::
  ++  draw
    |-
    ^-  (list @t)
    =+  mx=(roll l |:([n=[0 0] a=0] (max -.n a)))
    =+  my=(roll l |:([n=[0 0] a=0] (max +.n a)))
    =+  sl=(silt l)
    %+  turn  (gulf 0 my)
    |=  y=@ud
    ^-  @t
    %-  crip
    %+  turn  (gulf 0 mx)
    |=  x=@ud
    ^-  @t
    ?:  (~(has in sl) [x y])
      '#'
    '.'
  ::
  ++  xyok
    |=  [x=@sd y=@sd f=day13-finst]
    ^-  ?
    =+  v=(sun:si -:(day13-in2ci f [+:(old:si x) +:(old:si y)]))
    ?&
      |(=((cmp:si x --0) --0) =((cmp:si x -1) --1))  :: x >= 0
      |(=((cmp:si y --0) --0) =((cmp:si y -1) --1))  :: y >= 0
      =((cmp:si v (sun:si +.f)) -1)                  :: {x|y} < {w|h}
    ==
  --
::
++  day13-parse
  :: given: a set of dot coordinates followed by fold instructions (as @t)
  :: return: dot coordinates and fold instructions (as internal data types)
  |=  input=wain   :: (list @t)
  ^-  [(list day13-coord) (list day13-finst)]
  :: split list at empty line; parse separately
  =+  ^=  ipair
    =<  +:.
    %+  roll  input
    |:  [n='' ab=`bean`%.n ap=[`(list @t)`~ `(list @t)`~]]
    ^-  [? (list @t) (list @t)]
    ?:  =(n '')
      [%.y ap]
    [ab ?:(ab [-.ap [n +.ap]] [[n -.ap] +.ap])]
  :: parse the two parts of the input into a pair
  :-
    :: part 1: dot matrix coordinates, from "x,y" to `[x y]`
    %+  turn  (flop -.ipair)
      |=  i=@t
      ^-  day13-coord
      (rash i ;~((glue com) dem dem))
    :: part 2: dot matrix folds from "fold along {x|y}=v" to `[%up v]`
    %+  turn  (flop +.ipair)
      |=  i=@t
      ^-  day13-finst
      %+  rash  i
        ;~  pfix
          (jest 'fold along ')
          ;~  plug
            ;~  pose
              (cold %up (just 'y'))
              (cold %left (just 'x'))
            ==
            ;~(pfix (just '=') dem)
          ==
        ==
::
++  day13-solve-1
  :: given: a set of dot coordinates followed by fold instructions
  :: return: the number of dots that are visible after the first fold
  |=  input=wain   :: (list @t)
  ^-  @ud
  =+  ipair=(day13-parse input)
  =+  fold1=(~(fold day13-dm -.ipair) ?~(+.ipair !! i.+.ipair))
  (lent fold1)
::
++  day13-solve-2
  :: given: a set of dot coordinates followed by fold instructions
  :: return: the dot coordinate matrix after all folds are complete
  |=  input=wain   :: (list @t)
  ^-  (list @t)
  =+  ipair=(day13-parse input)
  %~  draw  day13-dm
  %+  roll  +.ipair
  |:([n=*day13-finst a=-.ipair] (~(fold day13-dm a) n))
--
