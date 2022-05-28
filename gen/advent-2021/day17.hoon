:: advent of code 2021 day 17
:: https://adventofcode.com/2021/day/17
::
/*  puzzle-input  %txt  /lib/advent-2021/day17/txt

:-  %say
|=  *
=<
:-  %noun  (day17-solve-2 puzzle-input)

|%
::
+$  day17-vector  [x=@sd y=@sd]
+$  day17-probe   [pos=day17-vector vel=day17-vector]
+$  day17-hitbox  [min=day17-vector max=day17-vector]
::
++  day17-floor  :: max(i, 0)
  |=  i=@sd
  ?:(=((cmp:si i --0) -1) --0 i)
++  day17-range  :: valid velocity range for hitbox
  |=  i=day17-hitbox
  ^-  day17-hitbox
  :: ?>  ?&(=((cmp:si x.spos --0) --0) =((cmp:si y.spos --0) --0))        :: spos is [0 0]
  ?>  ?&(=((cmp:si x.max.i x.min.i) --1) =((cmp:si y.max.i y.min.i) --1)) :: non-empty
  ?>  ?&(=((cmp:si x.min.i --0) (cmp:si x.max.i --0)))                    :: all +x or -x
  ?>  ?&(=((cmp:si y.min.i --0) -1) =((cmp:si y.max.i --0) -1))           :: all -y
  =+  xdir=?:((syn:si x.min.i) --1 -1)
  =+  xmin=(sun:si (min (abs:si x.min.i) (abs:si x.max.i)))
  =+  xmax=(sun:si (max (abs:si x.min.i) (abs:si x.max.i)))
  :_  :-  (pro:si xdir xmax)   :: xmax
          (pro:si -1 y.min.i)  :: ymax
      :_  y.min.i              :: ymin  (change to --0 for ymax search)
          %+  pro:si  xdir     :: xmin
          =+  v=--1
          |-  ^-  @sd
          =+  w=(fra:si (pro:si (sum:si v --1) v) --2)
          ?:  !=((cmp:si w xmin) -1)  v
          $(v (sum:si v --1))
::
++  day17-pb
  |_  p=day17-probe
  ::
  ++  maxy
    |=  hbox=day17-hitbox
    ^-  (unit @sd)
    =/  i=@ud  0
    =/  my=@sd    y.pos.p
    =/  hit=bean  %.n
    |-  ^-  (unit @sd)
    ?.  (isok hbox)  ?.(hit ~ `my)
    =?  my  =((cmp:si y.pos.p my) --1)  y.pos.p
    $(p step, i +(i), hit ?|(hit (isin hbox)))
  ::
  ++  step
    |-
    ^-  day17-probe
    :-  :-  (sum:si x.pos.p x.vel.p)
            (sum:si y.pos.p y.vel.p)
        :_  (sum:si y.vel.p -1)
            (day17-floor (sum:si x.vel.p ?:((syn:si x.vel.p) -1 --1)))
  ::
  ++  isin
    |=  hbox=day17-hitbox
    ^-  bean
    ?&  !=((cmp:si x.pos.p x.min.hbox) -1)  :: x.pos.p >= x.min.hbox
        !=((cmp:si x.pos.p x.max.hbox) --1) :: x.pos.p <= x.max.hbox
        !=((cmp:si y.pos.p y.min.hbox) -1)  :: y.pos.p >= y.min.hbox
        !=((cmp:si y.pos.p y.max.hbox) --1) :: y.pos.p <= y.max.hbox
    ==
  ::
  ++  isok
    :: the probe still has a chance of intersecting w/ hbox
    |=  hbox=day17-hitbox
    ^-  bean
    :: ~&  "y.pos.p >= y.min.hbox?: {<!=((cmp:si y.pos.p y.min.hbox) -1)>}"
    :: ~&  "x.pos.p >= 0?: {<!=((cmp:si x.pos.p --0) -1)>}"
    :: ~&  "x.pos.p <= x.max.hbox: {<!=((cmp:si x.pos.p x.max.hbox) --1)>}"
    ?&  !=((cmp:si y.pos.p y.min.hbox) -1)      :: y.pos.p >= y.min.hbox
      ?:  (syn:si x.vel.p)
        ?&  !=((cmp:si x.pos.p --0) -1)           :: +x.v? x.pos.p >= 0
            !=((cmp:si x.pos.p x.max.hbox) --1)   :: +x.v? x.pos.p <= x.max.hbox
        ==
      ?&  !=((cmp:si x.pos.p x.min.hbox) -1)  :: -x.v? x.pos.p >= x.min.hbox
          !=((cmp:si x.pos.p --0) --1)        :: -x.v? x.pos.p <= 0
      ==
    ==
  --
::
++  day17-parse
  :: given: a list of one cord containing the target area spec
  :: return: the target area spec as a 'day17-hitbox'
  |=  input=(list @t)
  ^-  day17-hitbox
  =+  scok=|=([s=bean n=@ud] =+(v=?:(s --1 -1) `@sd`(pro:si v (sun:si n))))
  =+  sdem=(cook scok ;~(plug (cook |=(i=(unit @t) ?@(i %.y %.n)) (punt (just '-'))) dem))
  =-  [[-<.- +<.-] [->.- +>.-]]
  %+  rash  (snag 0 input)
  ;~  pfix
    (jest 'target area: ')
    ;~  plug
      (ifix [(jest 'x=') (jest ', ')] ;~(plug sdem ;~(pfix (jest '..') sdem)))
      ;~(pfix (jest 'y=') ;~(plug sdem ;~(pfix (jest '..') sdem)))
    ==
  ==
::
++  day17-solve-1
  :: given: a list of one cord containing the target area spec
  :: return: the maximum y-position for any shot starting at (0, 0) and
  ::   landing in the target area
  |=  input=(list @t)
  ^-  @ud
  =+  spos=[--0 --0]
  =+  hbox=(day17-parse input)
  =+  vbox=(day17-range hbox)
  :: NOTE: This solution is definitely overkill; b/c dimensions are
  :: independent (x can be adjusted to make any valid y work) & can
  :: just calculate max y that will make it into the target area.
  %-  abs:si
  %+  roll  (gulf 0 (abs:si (dif:si y.max.vbox y.min.vbox)))
  |:  [yi=0 ym=--0]
  =+  yv=(sum:si y.min.vbox (sun:si yi))
  =-  ?:(=((cmp:si - ym) --1) - ym)
  %+  roll  (gulf 0 (abs:si (dif:si x.max.vbox x.min.vbox)))
  |:  [xi=0 ym=--0]
  =+  xv=(sum:si x.min.vbox (sun:si xi))
  =+  xy=(~(maxy day17-pb [spos [xv yv]]) hbox)
  ?~  xy  ym
  ?:(=((cmp:si +.xy ym) --1) +.xy ym)
::
++  day17-solve-2
  :: given: a list of one cord containing the target area spec
  :: return: the total number of initial velocities that will impact the
  ::   target area during their flight
  |=  input=(list @t)
  ^-  @ud
  =+  spos=[--0 --0]
  =+  hbox=(day17-parse input)
  =+  vbox=(day17-range hbox)
  %+  roll  (gulf 0 (abs:si (dif:si y.max.vbox y.min.vbox)))
  |:  [yi=0 hits=0]
  =+  yv=(sum:si y.min.vbox (sun:si yi))
  =-  (add hits -)
  %+  roll  (gulf 0 (abs:si (dif:si x.max.vbox x.min.vbox)))
  |:  [xi=0 hits=0]
  =+  xv=(sum:si x.min.vbox (sun:si xi))
  =+  xy=(~(maxy day17-pb [spos [xv yv]]) hbox)
  (add hits ?~(xy 0 1))
--
