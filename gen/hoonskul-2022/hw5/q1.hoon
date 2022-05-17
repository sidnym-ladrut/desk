:: hw5/q1.hoon
:: solutions to %hw5 q1 (hoon school 2022-2 cohort)
|=  i=@ud
^-  @ud
|^  (decrement i)
++  decrement
  |=  i=@ud
  ^-  @ud
  ?:  =(i 0)  :: underflow error
    !!
  =/  j  0
  |-
  ?:  =(+(j) i)
    j
  $(j +(j))
--
