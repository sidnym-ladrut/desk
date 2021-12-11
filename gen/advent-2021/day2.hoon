:: advent of code 2021 day 2
:: https://adventofcode.com/2021/day/2
::
/*  puzzle-input  %txt  /lib/advent-2021/day2/txt

:-  %say
|=  *
=<
:-  %noun  (day2-solve-2 puzzle-input)

|%
+$  day2-move  ?(%forward %up %down)
++  day2-parse
  |=  ilin=@t
  ^-  [day2-move @ud]
  %+  rash  ilin
  ;~  pose
    ;~((glue ace) (cold %forward (jest %forward)) dem)
    ;~((glue ace) (cold %up (jest %up)) dem)
    ;~((glue ace) (cold %down (jest %down)) dem)
  ==
++  day2-solve-1
  |=  ilst=wain
  ^-  [x=@ud y=@ud]
  =/  fx=@ud  0
  =/  fy=@ud  0
  |-  ^-  [x=@ud y=@ud]
  ?~  ilst
    [x=fx y=fy]
  =+  icmd=(day2-parse i.ilst) :: e.g. [%forward 10]
  =/  [dx=@ud dy=@ud dfxn=_add]
  ?-  -.icmd
    %forward  [dx=+.icmd dy=0 dfxn=add]
    %up       [dx=0 dy=+.icmd dfxn=sub]
    %down     [dx=0 dy=+.icmd dfxn=add]
  ==
  $(ilst t.ilst, fx (dfxn fx dx), fy (dfxn fy dy))
++  day2-solve-2
  |=  ilst=wain
  ^-  [x=@ud y=@ud]
  =/  fx=@ud  0
  =/  fy=@ud  0
  =/  fa=@ud  0
  |-  ^-  [x=@ud y=@ud]
  ?~  ilst
    [x=fx y=fy]
  =+  icmd=(day2-parse i.ilst) :: e.g. [%forward 10]
  ?:  =(-.icmd %down)
    $(ilst t.ilst, fa (add fa +.icmd))
  ?:  =(-.icmd %up)
    $(ilst t.ilst, fa (sub fa +.icmd))
  $(ilst t.ilst, fx (add fx +.icmd), fy (add fy (mul fa +.icmd)))
--
