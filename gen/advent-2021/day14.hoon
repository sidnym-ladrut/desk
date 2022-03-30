:: advent of code 2021 day 14
:: https://adventofcode.com/2021/day/14
::
/*  puzzle-input  %txt  /lib/advent-2021/day14/txt

:-  %say
|=  *
=<
:-  %noun  (day14-solve-2 puzzle-input)

|%
+$  day14-ptype  [(list @tD) (map [@t @t] @t)]
::
++  day14-pairs  :: stepwise list pairs; zip(l[1:], l[::-1])
  |*  a=(list *)
  =>  .(a ^.(homo a))
  =/  i=_a  a
  =/  l=(list [_?>(?=(^ a) i.a) _?>(?=(^ a) i.a)])  ~
  |-
  ^+  l
  ?~  i
    !!
  ?~  t.i
    (flop l)
  $(i t.i, l [[i.i i.t.i] l])
::
++  day14-split  :: split istream by seperator
  |=  [input=(list @t) schar=@t]
  ^-  (list (list @t))
  %-  flop
  %+  roll  input
  |:  [n='' ac=`(list @t)`~ aa=`(list (list @t))`~]
  ^-  [(list @t) (list (list @t))]
  ?:  =(n schar)
    [~ [(flop ac) aa]]
  [[n ac] aa]
::
++  day14-halve  :: slice input list in half
  |*  a=(list *)
  =>  .(a ^.(homo a))
  =/  i=@udJ  0
  =/  h=@udJ  (div (lent a) 2)
  =/  l1=_a  ~
  =/  l2=_a  ~
  |-
  ^+  [l1 l2]
  ?~  a
    [(flop l1) (flop l2)]
  ?:  (lth i h)
    $(i +(i), a t.a, l1 [i.a l1])
  $(i +(i), a t.a, l2 [i.a l2])
::
++  day14-mfreq  :: map list items to frequencies
  |*  l=(list *)
  =>  .(l ^.(homo l))
  %+  roll  l
  |:  [n=*_?>(?=(^ l) i.l) a=(malt `(list [_?>(?=(^ l) i.l) @udJ])`~)]
  ^+  a
  ?.  (~(has by a) n)
    (~(put by a) n 1)
  (~(jab by a) n |=(i=@udJ +(i)))
::
++  day14-step1
  |=  [polym=(list @tD) rules=(map [@t @t] @t)]
  ^-  day14-ptype
  :_  rules
  %-  snoc
  :_  (rear polym)
  %+  roll  (day14-pairs polym)
  |=([n=[@tD @tD] a=(list @tD)] (weld a ~[-.n (~(got by rules) n)]))
::
++  day14-step2
  :: NOTE: Solution taken from Python solution here:
  :: https://www.reddit.com/r/adventofcode/comments/rfzq6f/2021_day_14_solutions/hoib78w/
  |=  [polym=(list @tD) rules=(map [@t @t] @t) steps=@udJ]
  ^-  (map @tD @udJ)
  =+  cfreq=(day14-mfreq polym)
  =+  pfreq=(day14-mfreq (day14-pairs polym))
  =-  ac.-:.
  %+  roll  (gulf 1 steps)
  |:  [n=0 ac=cfreq ap=pfreq]
  ^+  [cfreq pfreq]
  %+  roll  ~(tap by ap)
  |:  [[k=['' ''] v=0] aic=cfreq aip=*_pfreq]
  ^+  [cfreq pfreq]
  =+  i=(~(got by rules) k)
  :-
    ?.  (~(has by aic) i)
      (~(put by aic) i v)
    (~(jab by aic) i |=(j=@udJ (add j v)))
    =+  ^=  aiip
      ?.  (~(has by aip) [-.k i])
        (~(put by aip) [-.k i] v)
      (~(jab by aip) [-.k i] |=(j=@udJ (add j v)))
    ?.  (~(has by aiip) [i +.k])
      (~(put by aiip) [i +.k] v)
    (~(jab by aiip) [i +.k] |=(j=@udJ (add j v)))
::
++  day14-stepx
  :: NOTE: This was a failed attempt to optimize the naive 'day14-step1'
  :: solution, which fails due to memory overflow (memoizing lists of
  :: >1B characters is not a good solution, particularly in Hoon).
  |=  [polym=(list @tD) rules=(map [@t @t] @t) steps=@udJ]
  ^-  day14-ptype
  :_  rules
  =-  (roll (gulf 1 steps) |:([n=0 a=polym] (fstep a)))
  ^=  fstep
  |=  l=(list @tD)
  ^-  (list @tD)
  ~+  :: important! causes this function to be memoized
  ?:  =((lent l) 2)
    =+  i1=(snag 0 l)
    =+  i2=(snag 1 l)
    [i1 (~(got by rules) [i1 i2]) i2 ~]
  =+  ls=(day14-halve l)
  =+  l1=$(l (snoc -.ls (snag 0 +.ls)))
  =+  l2=$(l +.ls)
  (weld (snip l1) l2)
::
++  day14-parse
  :: given: a polymer template followed by a set of replacement rules
  :: return: the polymer template and replacement rules as data structures
  |=  input=(list @t)
  ^-  day14-ptype
  =+  isplt=(day14-split input '')
  :-  (trip (snag 0 (snag 0 isplt)))
  %-  malt
  %+  turn  (snag 1 isplt)
  |=  l=@t
  ^-  [[@t @t] @t]
  =+  d=(rash l ;~((glue (jest ' -> ')) (star alf) (star alf)))
  :_  (crip +.d)
  [(snag 0 -.d) (snag 1 -.d)]
::
++  day14-solve-1
  :: given: a polymer template followed by a set of replacement rules
  :: return: (most common char - least common char) after 10 replacement steps
  |=  input=(list @t)
  ^-  @udJ
  =+  prdat=(day14-parse input)
  =+  rrdat=(roll (gulf 1 10) |:([n=0 a=prdat] (day14-step1 a)))
  =-  %+  sub
    (roll fqvls |:([n=0 a=0] (max n a)))
    (roll fqvls |:([n=0 a=~(out fe 8)] (min n a)))
  ^=  fqvls  ~(val by (day14-mfreq -.rrdat))
::
++  day14-solve-2
  :: given: a polymer template followed by a set of replacement rules
  :: return:  (most common char - least common char) after 40 replacement steps
  |=  input=(list @t)
  ^-  @udJ
  =+  prdat=(day14-parse input)
  =+  fqvls=~(val by (day14-step2 -.prdat +.prdat 40))
  %+  sub
    (roll fqvls |:([n=0 a=0] (max n a)))
    (roll fqvls |:([n=0 a=~(out fe 8)] (min n a)))
--
