:: advent of code 2021 day 18
:: https://adventofcode.com/2021/day/18
::
/*  puzzle-input  %txt  /lib/advent-2021/day18/txt

:-  %say
|=  *
=<
:-  %noun  (day18-solve-2 puzzle-input)

|%
+$  day18-snum  :: [depth value]
    (tree [@ud @ud])
+$  day18-bamd  :: [path value low-w-rtree low-w-ltree]
    [p=(list @t) v=[@ud @ud] lr=(unit @ud) ll=(unit @ud)]
::
++  day18-noun2snum
  |=  i=noun
  ^-  day18-snum
  =+  d=0
  |-  ^-  day18-snum
  ?@  i  [[d i] ~ ~]
  [[d 0] $(i -.i, d +(d)) $(i +.i, d +(d))]
++  day18-snum2noun
  |=  i=day18-snum
  ^-  noun
  ?~  i  ~
  ?:  ?=([[@ud @ud] ~ ~] i)  +.n.i
  [$(i l.i) $(i r.i)]
::
++  day18-sn
  |_  t=day18-snum
  ::
  ++  sum                              :: 'add' trees
    |=  s=day18-snum
    ^-  day18-snum
    ?~  s  red
    ?~  t  red(t s)
    =-  red(t [[0 0] (snag 0 -) (snag 1 -)])
    %+  turn  `(list day18-snum)`~[t s]
    |=  i=day18-snum
    ^-  day18-snum
    ?~  i  i
    [[+(-.n.i) +.n.i] $(i l.i) $(i r.i)]
  ::
  ++  red                              :: 'reduce' tree
    |-
    ^-  day18-snum
    =^  didb  t  bam
    ?:  didb  $
    =^  didr  t  rip
    ?:  didr  $
    t
  ::
  ++  mag                              :: tree 'magnitude'
    |-
    ^-  @ud
    ?~  t  0
    %+  add  +.n.t
    %+  add
    (mul 3 $(t l.t))
    (mul 2 $(t r.t))
  ::
  ++  bam                              :: 'explode' the leftmost 4-deep pair
    |-
    ^-  [bean day18-snum]
    =-  ?~  bcan  [%.n t]          :: if candidate, edit tree
      =+  bdat=u.bcan
      :-  %.y
      |-
      ?~  t  !!
      ?~  p.bdat  [[-.n.t 0] ~ ~]
      :: FIXME: Figure out how to simplify trap calls (ideally using `t`).
      =?  r.t  &(!=(lr.bdat ~) =(+.lr.bdat -.n.t))
        =+  s=r.t
        |-(?~(s !! ?:(?=([[@ud @ud] ~ ~] s) s(n [-.n.s (add +.v.bdat +.n.s)]) s(l $(s l.s)))))
      =?  l.t  &(!=(ll.bdat ~) =(+.ll.bdat -.n.t))
        =+  s=l.t
        |-(?~(s !! ?:(?=([[@ud @ud] ~ ~] s) s(n [-.n.s (add -.v.bdat +.n.s)]) s(r $(s r.s)))))
      :: FIXME: Would rather mutate bdat before call, but Hoon compiler
      :: gets angry because of '?~  p.bdat' check above.
      ?:  =(i.p.bdat 'l')
        t(l $(t l.t, bdat bdat(p t.p.bdat)))
      t(r $(t r.t, bdat bdat(p t.p.bdat)))
    ^=  bcan                       :: find 'bam' candidate
    %.  [t ~]
    |=  [i=day18-snum p=(list @t)]
    ^-  (unit day18-bamd)
    ?~  i  ~
    ?:  &(?=([[@ud @ud] ~ ~] l.i) ?=([[@ud @ud] ~ ~] r.i))
      ?.  =(-.n.i 4)  ~
      `[(flop p) [+.n.l.i +.n.r.i] ~ ~]
    =+  lcan=$(i l.i, p ['l' p])
    ?^  lcan
      =+  ldat=u.lcan
      ?.  &(!=(r.i ~) |(=(lr.ldat ~) (gth -.n.i +.lr.ldat)))  lcan
      `ldat(lr `-.n.i)
    =+  rcan=$(i r.i, p ['r' p])
    ?^  rcan
      =+  rdat=u.rcan
      ?.  &(!=(l.i ~) |(=(ll.rdat ~) (gth -.n.i +.ll.rdat)))  rcan
      `rdat(ll `-.n.i)
    ~
  ++  rip                              :: 'split' the leftmost >=10 value
    |-
    ^-  [bean day18-snum]
    ?~  t  [%.n t]
    ?:  &(=(l.t ~) =(r.t ~))
      ?:  (lth +.n.t 10)  [%.n t]
      =+  [d=-.n.t v=+.n.t]
      :-  %.y
      :+  [d 0]
      [[+(d) (div v 2)] ~ ~]
      [[+(d) (add (mod v 2) (div v 2))] ~ ~]
    =^  lrip  l.t  $(t l.t)
    ?:  lrip  [%.y t]
    =^  rrip  r.t  $(t r.t)
    ?:  rrip  [%.y t]
    [%.n t]
  --
::
++  day18-parse
  :: given: a list of cords where each entry represents a snail number (noun)
  :: return: the list of snail numbers as an internal data type (tree)
  |=  input=(list @t)
  ^-  (list day18-snum)
  %+  turn  input
  |=  line=@t
  ^-  day18-snum
  %-  day18-noun2snum
  .*  0  %-  make  %-  crip
  %+  rash  line
  %-  plus
  ;~  pose
    (cook |=(i=@t ' ') (just ','))
    next
  ==
::
++  day18-solve-1
  :: given: a list of cords where each entry represents a snail number (noun)
  :: return: the magnitude of the sum of all snail numbers in the input
  |=  input=(list @t)
  ^-  @ud
  %~  mag  day18-sn
  %+  roll  (day18-parse input)
  |=  [n=day18-snum a=day18-snum]
  (~(sum day18-sn a) n)
::
++  day18-solve-2
  :: given: a list of cords where each entry represents a snail number (noun)
  :: return: the largest magnitude from adding any two of the given snail numbers
  |=  input=(list @t)
  ^-  @ud
  =+  snums=(day18-parse input)
  =-  +.-
  %+  roll  snums
  |:  [ni=*day18-snum [ar=snums av=0]]
  ?~  ar  `av
  :-  t.ar
  %+  max  av
  %+  roll  t.ar
  |=  [nj=day18-snum av=@ud]
  %+  max  av
  %+  max
  ~(mag day18-sn (~(sum day18-sn ni) nj))
  ~(mag day18-sn (~(sum day18-sn nj) ni))
--
