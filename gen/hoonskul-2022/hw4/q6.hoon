:: hw4/q6.hoon
:: solutions to %hw4 q6 (hoon school 2022-2 cohort)
::
:: text-user.hoon
::
:: uses the 'text.hoon' library to calculate the number of words in a
:: given tape (i.e. the number of entries separated by *1* space)
::
|=  i=tape
^-  @ud
=+  ^=  text
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
=/  j  (zing (split-tape.text i))
?:  =((count-elements.text i) 0)
  0
(add 1 (sub (count-elements.text i) (count-elements.text j)))
