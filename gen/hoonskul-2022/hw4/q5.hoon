:: hw4/q5.hoon
:: solutions to %hw4 q5 (hoon school 2022-2 cohort)
::
:: text processing library, which includes these functions:
:: - +split-tape: splits a tape by spaces
::   (e.g. "hey there" -> ~["hey" "there"])
:: - +count-elements: counts the number of characters in a tape
::   (e.g. "hey there" -> 9)
::
|=  t=tape
=<  [(count-elements t) (split-tape t)]
|%
++  split-tape
  |=  ex=tape
  ^-  (list tape)
  =/  index  0
  =/  result  *(list tape)
  |-  ^-  (list tape)
  ?:  =(index (lent ex))
    (weld result ~[`tape`ex])
  ?:  =((snag index ex) ' ')
    $(index 0, ex `tape`(slag +(index) ex), result (weld result ~[`tape`(scag index ex)]))
  $(index +(index))
++  count-elements
  |=  ex=tape
  ^-  @ud
  =/  s  0
  |-
  ?~  ex
    s
  $(ex t.ex, s +(s))
--
