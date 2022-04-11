:: hw4.hoon
::
:: solutions to %hw4 (hoon school 2022-2 cohort)
::
:: question 2: convert list to tape
:: dojo> `tape``(list @)`~[114 97 105 110 98 111 119 32 115 104 101 114 98 101 116]
:: "rainbow sherbet"
:: question 3: 7-element list
:: |=  l=$:(@ud @ud @ud @ud @ud @ud @ud ~)
:: ^-  @ud
:: |^  (weekly-reagent l)
:: ++  weekly-reagent
::   |=  l=$:(@ud @ud @ud @ud @ud @ud @ud ~)
::   ^-  @ud
::   =/  i  `(list @ud)`l
::   =/  s  0
::   |-
::   ?~  i
::     s
::   $(i t.i, s (add s i.i))
:: --
:: question 4: fizzbuzz's revenge
:: |=  c=@ud
:: |^  (fizzbuzz c)
:: ++  fizzbuzz
::   |=  c=@ud
::   %-  turn
::   :-  (gulf 1 c)
::   |=  i=@ud
::   ?:  =((mod i 3) 0)
::     ?:  =((mod i 5) 0)
::       "fizzbuzz"
::     "fizz"
::   ?:  =((mod i 5) 0)
::     "buzz"
::   i
:: --
:: question 5: text.hoon library
::
:: text.hoon
::
:: text processing library, which includes these functions:
:: - +split-tape: splits a tape by spaces
::   (e.g. "hey there" -> ~["hey" "there"])
:: - +count-elements: counts the number of characters in a tape
::   (e.g. "hey there" -> 9)
::
:: |=  t=tape
:: =<  [(count-elements t) (split-tape t)]
:: |%
:: ++  split-tape
::   |=  ex=tape
::   ^-  (list tape)
::   =/  index  0
::   =/  result  *(list tape)
::   |-  ^-  (list tape)
::   ?:  =(index (lent ex))
::     (weld result ~[`tape`ex])
::   ?:  =((snag index ex) ' ')
::     $(index 0, ex `tape`(slag +(index) ex), result (weld result ~[`tape`(scag index ex)]))
::   $(index +(index))
:: ++  count-elements
::   |=  ex=tape
::   ^-  @ud
::   =/  s  0
::   |-
::   ?~  ex
::     s
::   $(ex t.ex, s +(s))
:: --
:: question 6: text.hoon generator
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
