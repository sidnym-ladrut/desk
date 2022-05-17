:: hw2/q16.hoon
:: solutions to %hw2 q16 (hoon school 2022-2 cohort)
::
:: calculator.hoon
::
:: implements a simple calculator supporting +, -, *, /
::
|=  [a=@ud b=@ud c=?(%mul %sub %add %div)]
^-  @ud
?:  .=  c  %mul
  (mul a b)
?:  .=  c  %sub
  (sub a b)
?:  .=  c  %add
  (add a b)
(div a b)
