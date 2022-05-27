:: advent of code 2021 day 16
:: https://adventofcode.com/2021/day/16
::
/*  puzzle-input  %txt  /lib/advent-2021/day16/txt

:-  %say
|=  *
=<
:-  %noun  (day16-solve-2 puzzle-input)

|%
::  day16-pack: either atom literal or cell of [operator-id sub-packets]
+$  day16-pack  [vers=@ud pack=$@(@ud [oid=@ud subs=(list day16-pack)])]
::
++  day16-chomp  |*([a=@ l=(list *)] [(scag a l) (slag a l)])
++  day16-pack-render
  |=  p=day16-pack
  ^-  (list tape)
  =+  l=0
  |-  ^-  (list tape)
  =+  indent=(reap l ' ')
  ?@  pack.p  ~[(weld indent ~(rend co %$ %ud pack.p))]
  =+  spak=(turn subs.pack.p |=(s=day16-pack ^$(p s, l +(l))))
  =-  [(weld indent -) (zing spak)]
  ?+  oid.pack.p  !!
    %0  "+"
    %1  "*"
    %2  "min"
    %3  "max"
    %5  ">"
    %6  "<"
    %7  "="
  ==
::
++  day16-parse
  :: given: a list of 1 cord containing the BITS transmission
  :: return: a data structure representing the packets of the BITS transmission
  |=  input=(list @t)
  ^-  day16-pack
  =+  blen=(mul 4 (lent (trip (snag 0 input))))
  =/  bits=@ub  +>:(de:base16:mimes:html (snag 0 input))
  =/  bstr=(list @ub)  (flop (rip 0 bits))
  :: NOTE: This weirdness is required for front-padding input values
  :: that start with 1+ zeroes.
  =.  bstr  (weld (reap (sub blen (lent bstr)) 0b0) bstr)
  =-  -:(- bstr)
  |=  bin=(list @ub)
  ^-  [day16-pack (list @ub)]
  =+  bcat=|=(l=(list @ub) `@ub`(rep 0 (flop l)))
  :: 3-bits: version
  =^  pver  bin  (day16-chomp 3 bin)
  =+  ver=`@ud`(bcat pver)
  :: 3-bits: operator id
  =^  poid  bin  (day16-chomp 3 bin)
  =+  oid=`@ud`(bcat poid)
  :: if 4, literal
  ?:  =(oid 4)
    :: TODO: Convert to tail recursion to improve speed
    =-  [[ver `@ud`(bcat -.-)] +.-]
    |-  ^-  [(list @ub) (list @ub)]
    =^  lrun  bin  (day16-chomp 5 bin)
    =+  lrpa=(day16-chomp 1 lrun)
    ?:  =(-<.lrpa 0b0)  [+.lrpa bin]
    =+($ [(weld +.lrpa -.-) +.-])
  :: else, operator
  =^  plid  bin  (day16-chomp 1 bin)
  =+  lid=`@ud`(bcat plid)
  :: if lid=0, 15-bit total length value
  ?:  =(lid 0)
    =^  tlen  bin  (day16-chomp 15 bin)
    =+  len=`@ud`(bcat tlen)
    =|  [cur=@ud subs=(list day16-pack)]
    |-
    ?:  (gte cur len)
      [[ver oid (flop subs)] bin]
    =+  lold=(lent bin)
    =^  pnew  bin  ^$(bin bin)
    =+  lnew=(lent bin)
    $(cur (add cur (sub lold lnew)), subs [pnew subs])
  :: if lid=1, 11-bit immediate sub-packet count
  =^  plen  bin  (day16-chomp 11 bin)
  =+  len=`@ud`(bcat plen)
  =|  [cur=@ud subs=(list day16-pack)]
  |-
  ?:  (gte cur len)
    [[ver oid (flop subs)] bin]
  =^  pnew  bin  ^$(bin bin)
  $(cur +(cur), subs [pnew subs])
::
++  day16-solve-1
  :: given: a list of 1 cord containing the BITS transmission
  :: return: the sum of all packet version numbers in the transmission tree
  |=  input=(list @t)
  ^-  @ud
  =+  pack=(day16-parse input)
  |-  ^-  @ud
  %+  add  vers.pack
  ?@  pack.pack  0
  %-  roll
  :_  add
  (turn subs.pack.pack |=(s=day16-pack ^$(pack s)))
::
++  day16-solve-2
  :: given: a list of 1 cord containing the BITS transmission
  :: return: the result of evaluating the packet based on operators
  ::   (0: add, 1: mul, 2: min, 3: max, 5: gth, 6: lth, 7: .=)
  |=  input=(list @t)
  ^-  @ud
  =+  pack=(day16-parse input)
  |-  ^-  @ud
  ?@  pack.pack  pack.pack
  =+  spak=(turn subs.pack.pack |=(s=day16-pack ^$(pack s)))
  ?+  oid.pack.pack  !!
    %0  (roll spak add)
    %1  (roll spak mul)
    %2  (roll spak |:([a=~(out fe 5) b=~(out fe 5)] (min a b)))
    %3  (roll spak max)
    %5  ?:((gth (snag 0 spak) (snag 1 spak)) 1 0)
    %6  ?:((lth (snag 0 spak) (snag 1 spak)) 1 0)
    %7  ?:(=((snag 0 spak) (snag 1 spak)) 1 0)
  ==
--
