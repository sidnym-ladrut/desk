:: hw3/q7.hoon
:: solutions to %hw3 q7 (hoon school 2022-2 cohort)
::
:: calculator.hoon
::
:: implements a simple calculator supporting +, -, *, /
::
|=  [a=@ud b=@ud c=?(%mul %sub %add %div)]
^-  @ud
=<
?:  =(c %add)
  (add-num a b)
?:  =(c %sub)
  (sub-num a b)
?:  =(c %mul)
  (mul-num a b)
(div-num a b)
|%
++  add-num
  |=  [a=@ud b=@ud]
  ^-  @ud
  (add a b)
++  sub-num
  |=  [a=@ud b=@ud]
  ^-  @ud
  (sub a b)
++  mul-num
  |=  [a=@ud b=@ud]
  ^-  @ud
  (mul a b)
++  div-num
  |=  [a=@ud b=@ud]
  ^-  @ud
  (div a b)
--
