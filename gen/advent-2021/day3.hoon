:: advent of code 2021 day 3
:: https://adventofcode.com/2021/day/3
::
/*  puzzle-input  %txt  /lib/advent-2021/day3/txt

:-  %say
|=  *
=<
:-  %noun  (day3-solve-2 puzzle-input)

|%
++  day3-zip
  |*  [a=(list *) b=(list *)]
  ?~  a  ~
  ?~  b  ~
  [[i.a i.b] $(a t.a, b t.b)]
++  day3-lis-to-num
  |=  ilis=(list bean)
  ^-  @ud
  =.  ilis  (flop ilis)
  =/  fitr=@ud  0
  =/  fbin=@ub  0b0
  |-  ^-  @ud
  ?~  ilis
    `@ud`fbin
  %=  $
    ilis  t.ilis
    fitr  +(fitr)
    fbin  (con fbin (lsh [0 fitr] `@ub`i.ilis))
  ==
++  day3-parse
  |=  ilin=@t
  ^-  (list bean)
  %+  rash  ilin
  |-
  ;~  plug
    ;~  pose
      (cold %.y (just '0'))
      (cold %.n (just '1'))
    ==
    ;~  pose
      (knee *(list bean) |.(^$))
      (easy ~)
    ==
  ==
++  day3-digit-freq
  |=  ilst=wain
  ^-  (list [@ud @ud])
  =/  fcnt=(list [@ud @ud])  (reap 12 [0 0])  :: per-binpos binary counts; [#0s #1s]
  |-  ^-  (list [@ud @ud])
  ?~  ilst
    fcnt
  =+  fcur=(day3-parse i.ilst)
  :: fxnt = map(zip(fcnt, fcur), lambda (z, o), c: (z + c == True, z + c == False)
  %=  $
    ilst  t.ilst
    fcnt
    %+  turn
      (day3-zip fcnt fcur)
    |=([[z=@ud o=@ud] a=?] [(add z `@ud`=(a %.n)) (add o `@ud`=(a %.y))])
  ==
++  day3-digit-freq-2
  |=  ilst=(list (list bean))
  ^-  (list [@ud @ud])
  =/  fcnt=(list [@ud @ud])  (reap 12 [0 0])  :: per-binpos binary counts; [#0s #1s]
  |-  ^-  (list [@ud @ud])
  ?~  ilst
    fcnt
  =+  fcur=i.ilst
  :: fxnt = map(zip(fcnt, fcur), lambda (z, o), c: (z + c == True, z + c == False)
  %=  $
    ilst  t.ilst
    fcnt
    %+  turn
      (day3-zip fcnt fcur)
    |=([[z=@ud o=@ud] a=?] [(add z `@ud`=(a %.n)) (add o `@ud`=(a %.y))])
  ==
++  day3-gamma-rate
  |=  icnt=(list [@ud @ud])
  ^-  (list bean)
  (turn icnt |=([z=@ud o=@ud] (gth z o)))
++  day3-epsilon-rate
  |=  icnt=(list [@ud @ud])
  ^-  (list bean)
  (turn icnt |=([z=@ud o=@ud] (lte z o)))
++  day3-solve-1
  |=  ilst=wain
  ^-  @ud
  =+  ffrq=(day3-digit-freq ilst)
  %+  mul
    (day3-lis-to-num (day3-gamma-rate ffrq))
  (day3-lis-to-num (day3-epsilon-rate ffrq))
++  day3-oxygen-rate
  |=  ilst=(list (list bean))
  ^-  @ud
  =+  iitr=0
  |-  ^-  @ud
  ?~  ilst
    0
  ?~  t.ilst
    (day3-lis-to-num i.ilst)
  =+  ffrq=(day3-digit-freq-2 ilst)
  =+  fgam=(day3-gamma-rate ffrq)
  %=  $
    iitr  +(iitr)
    ilst  %+  skim
        `(list (list bean))`ilst
      |=(i=(list bean) =((snag iitr i) (snag iitr fgam)))
  ==
++  day3-co2-rate
  |=  ilst=(list (list bean))
  ^-  @ud
  =+  iitr=0
  |-  ^-  @ud
  ?~  ilst
    0
  ?~  t.ilst
    (day3-lis-to-num i.ilst)
  =+  ffrq=(day3-digit-freq-2 ilst)
  =+  feps=(day3-epsilon-rate ffrq)
  %=  $
    iitr  +(iitr)
    ilst  %+  skim
        `(list (list bean))`ilst
      |=(i=(list bean) =((snag iitr i) (snag iitr feps)))
  ==
++  day3-solve-2
  |=  ilst=wain
  ^-  @ud
  =/  flst=(list (list bean))  (turn ilst day3-parse)
  (mul (day3-oxygen-rate flst) (day3-co2-rate flst))
--
