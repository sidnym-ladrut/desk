:: advent of code 2021 day 8
:: https://adventofcode.com/2021/day/8
::
/*  puzzle-input  %txt  /lib/advent-2021/day8/txt

:-  %say
|=  *
=<
:-  %noun  (day8-solve-2 puzzle-input)

|%
+$  day8-signal   ?(%a %b %c %d %e %f %g)
+$  day8-pattern  (set day8-signal)
+$  day8-display  [digits=(list day8-pattern) output=(list day8-pattern)]
::
++  day8-head
  |*  a=(list *)
  ?~  a  !!
  i.a
++  day8-parse
  :: given: a list of signal patterns for a display and the display values
  :: return: a list of 'day8-display' types with each entry
  ::   corresponding to an input display/display value pair
  |=  input=wain   :: (list @t)
  ^-  (list day8-display)
  =-  (turn input parse-pattern)
  ^=  parse-pattern
    |=  input=@t
    ^-  day8-display
    :: NOTE: Greedy parse on spaces causes one extra empty digit display
    :: to be listed, which is removed with 'snip'.
    =-  :-
      digits=(turn (snip -.raw-display) silt)
      outputs=(turn +.raw-display silt)
    ^=  raw-display
      =-  %+  rash  input
        ;~  (glue (jest '| '))
          (more ace (star sigchar))
          (more ace (star sigchar))
        ==
      ^=  sigchar
        ;~  pose
          (cold %a (jest %a))
          (cold %b (jest %b))
          (cold %c (jest %c))
          (cold %d (jest %d))
          (cold %e (jest %e))
          (cold %f (jest %f))
          (cold %g (jest %g))
        ==
::
++  day8-display-output
  |=  input=day8-display
  ^-  @ud
  =+  pfind=|=(a=$-(day8-pattern ?) (day8-head (skim digits.input a)))
  =+  ptone=(pfind |=(i=day8-pattern =(~(wyt in i) 2)))
  =+  ptfor=(pfind |=(i=day8-pattern =(~(wyt in i) 4)))
  =-  +>.dspin
  =-  ^=  dspin
    %^  spin  (flop output.input)  [0 0]  :: [index accum]
      |=  [n=day8-pattern a=[@ud @ud]]
      ^-  [day8-pattern [@ud @ud]]
      :-  n
      :-  +(-.a)
      (add +.a (mul (pow 10 -.a) (~(got by pvmap) n)))
  ^=  pvmap
    %-  my
    :~
      :_  1  ptone
      :_  4  ptfor
      :_  7  (pfind |=(i=day8-pattern =(~(wyt in i) 3)))
      :_  8  (pfind |=(i=day8-pattern =(~(wyt in i) 7)))
      :_  3
        %-  pfind
          |=  i=day8-pattern
          ?&
            =(~(wyt in i) 5)
            =(~(wyt in (~(int in i) ptone)) 2)
          ==
      :_  6
        %-  pfind
          |=  i=day8-pattern
          ?&
            =(~(wyt in i) 6)
            =(~(wyt in (~(int in i) ptone)) 1)
          ==
      :_  2
        %-  pfind
          |=  i=day8-pattern
          ?&
            =(~(wyt in i) 5)
            =(~(wyt in (~(int in i) ptone)) 1)
            =(~(wyt in (~(int in i) ptfor)) 2)
          ==
      :_  5
        %-  pfind
          |=  i=day8-pattern
          ?&
            =(~(wyt in i) 5)
            =(~(wyt in (~(int in i) ptone)) 1)
            =(~(wyt in (~(int in i) ptfor)) 3)
          ==
      :_  9
        %-  pfind
          |=  i=day8-pattern
          ?&
            =(~(wyt in i) 6)
            =(~(wyt in (~(int in i) ptone)) 2)
            =(~(wyt in (~(int in i) ptfor)) 4)
          ==
      :_  0
        %-  pfind
          |=  i=day8-pattern
          ?&
            =(~(wyt in i) 6)
            =(~(wyt in (~(int in i) ptone)) 2)
            =(~(wyt in (~(int in i) ptfor)) 3)
          ==
    ==
::
++  day8-solve-1
  :: given: a list of signal patterns for a display and the display values
  :: return: the number of times the unique digits (1, 4, 7, 8) appear
  |=  input=wain   :: (list @t)
  ^-  @ud
  =+  disps=(day8-parse input)
  %+  roll  disps
    |=  [disp=day8-display acum=@ud]
    ^-  @ud
    %+  add  acum
      %+  roll  output.disp
        |=  [n=day8-pattern a=@ud]
        ^-  @ud
        %+  add  a
        ?+  ~(wyt in n)  0
          %2  1 :: 1
          %3  1 :: 7
          %4  1 :: 4
          %7  1 :: 8
        ==
::
++  day8-solve-2
  :: given: a list of signal patterns for a display and the display values
  :: return: the total sum of all values across all displays
  |=  input=wain   :: (list @t)
  ^-  @ud
  =+  disps=(day8-parse input)
  %+  roll
    (turn disps day8-display-output)
    add
--
