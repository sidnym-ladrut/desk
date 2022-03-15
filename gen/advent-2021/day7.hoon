:: advent of code 2021 day 7
:: https://adventofcode.com/2021/day/7
::
/*  puzzle-input  %txt  /lib/advent-2021/day7/txt

:-  %say
|=  *
=<
:-  %noun  (day7-solve-2 puzzle-input)

|%
++  day7-parse
  :: given: list of 1 item, which is comma-separated list of crab positions
  :: return: list of crab positions as list of @ud
  |=  input=wain   :: (list @t)
  ^-  (list @ud)
  ?~  input  ~
  %+  rash  i.input
  (more com dem)
++  day7-calc-naive-cost
  :: given: list of crab positions and a potential move position
  :: return: the total linear cost of moving every crab to the position
  |=  [crabs=(list @ud) pcand=@ud]
  ^-  @ud
  =-  (roll crabs calc-cost)
  ^=  calc-cost
    |=  [nval=@ud aval=@ud]
    ^-  @ud
    %+  add  aval
    (sub (max nval pcand) (min nval pcand))
++  day7-calc-crab-cost
  :: given: list of crab positions and a potential move position
  :: return: the total crab (accumulated) cost of moving every crab to
  ::   the position
  |=  [crabs=(list @ud) pcand=@ud]
  ^-  @ud
  =-  (roll crabs calc-cost)
  ^=  calc-cost
    |=  [nval=@ud aval=@ud]
    ^-  @ud
    =+  dist=(sub (max nval pcand) (min nval pcand))
    %+  add  aval
    (div (mul dist +(dist)) 2)
++  day7-solve-1
  :: given: a comma-separated list of crab positions
  :: return: the crab position that minimizes total crab movement cost,
  ::   as measured naively (distance=cost)
  |=  input=wain   :: (list @t)
  ^-  [@ud @ud]
  =+  crabs=(day7-parse input)
  =+  crmax=(roll crabs max)
  =+  crmin=(roll crabs min)
  :: NOTE: Because I thought the prompt was asking for it, this solution
  :: accidentally also includes the position with the smallest cost.
  =-  +.cspin
  ^=  cspin
  %^  spin  (gulf crmin crmax)  [crmin ~(out fe 5)]
    |=  [cnext=@ud accum=[@ud @ud]]
    ^-  [@ud [@ud @ud]]
    =+  ccost=(day7-calc-naive-cost crabs cnext)
    :-  cnext
    ?:((lte +.accum ccost) accum [cnext ccost])
::
++  day7-solve-2
  :: given: a comma-separated list of crab positions
  :: return: the crab position that minimizes total crab movement cost,
  ::   as measured by crab standards (distance=sum over i of distance)
  |=  input=wain   :: (list @t)
  ^-  @ud
  =+  crabs=(day7-parse input)
  =+  crmax=(roll crabs max)
  =+  crmin=(roll crabs min)
  %+  roll  (gulf crmin crmax)
  |:([nval=0 aval=~(out fe 5)] (min aval (day7-calc-crab-cost crabs nval)))
--
