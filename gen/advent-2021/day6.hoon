:: advent of code 2021 day 6
:: https://adventofcode.com/2021/day/6
::
/*  puzzle-input  %txt  /lib/advent-2021/day6/txt

:-  %say
|=  *
=<
:-  %noun  (day6-solve-2 puzzle-input)

|%
+$  day6-fishs  (list @udJ)
::
++  day6-parse
  :: given: list of 1 item, which is comma-separated list of fish timers
  :: return: list of fish timers as list of @udJ
  |=  input=wain   :: (list @t)
  ^-  day6-fishs
  ?~  input  ~
  %+  rash  i.input
  (more com dem)
::
++  day6-simulate
  :: given: list of fish timers as a list of @udJ
  :: return: a new list of fish timers as @udJ after simulating 1 day
  |=  sfish=day6-fishs
  ^-  day6-fishs
  :: algorithm:
  :: - count the number of 0s; add that many 9s to end of list
  :: - replace all 0s with 7s (reset 0 timers)
  :: - subtract 1 from every item in the list (9->8, 7->6)
  =/  ffish=day6-fishs  sfish
  =+  fncnt=(roll ffish |=([n=@udJ a=@udJ] (add a `@udJ`?!(=(n 0)))))
  =.  ffish  (weld ffish (reap fncnt 9))
  =.  ffish  (turn ffish |=(f=@udJ ?:(=(f 0) 7 f)))
  =.  ffish  (turn ffish |=(f=@udJ (sub f 1)))
  ffish
::
++  day6-calculate
  :: given: list of fish timers as a list of @udJ and # days to simulate
  :: return: the total number of fish after the # of simulated days
  ::
  ::           +- 1                               if (a >= d)
  :: f(a, d) = |
  ::           +- f(6, d-(a+1)) + f(8, d-(a+1))      else
  |=  [sfish=day6-fishs ndays=@udJ]
  ^-  @udJ
  =-  (roll sfish |=([n=@udJ a=@udJ] (add a (calc-spawn n ndays))))
  ^=  calc-spawn
    |=  [fiage=@udJ ndays=@udJ]
    ^-  @udJ
    ~+  :: important! causes this function to be memoized
    ?:  (gte fiage ndays)  1
    =+  sdays=(sub ndays (add fiage 1))
    %+  add
      $(fiage 6, ndays sdays)
      $(fiage 8, ndays sdays)
::
++  day6-solve-1
  :: given: array of fish timers as comma-separated list
  :: return: the number of fish existing after 80 simulated days
  |=  input=wain   :: (list @t)
  ^-  @udJ
  =+  sfish=(day6-parse input)
  :: TODO: there's probably a smart functional way to do this iteration,
  :: but I couldn't find any simple solutions w/ the Hoon built-ins
  =/  ndays=@udJ  0
  =-  (lent ffish)
  ^=  ffish
    |-  ^-  day6-fishs
    ?:  =(ndays 80)  sfish
    $(ndays +(ndays), sfish (day6-simulate sfish))
::
++  day6-solve-2
  :: given: array of fish timers as comma-separated list
  :: return: the number of fish existing after 256 simulated days
  |=  input=wain   :: (list @t)
  ^-  @udJ
  =+  sfish=(day6-parse input)
  (day6-calculate sfish 256)
--
