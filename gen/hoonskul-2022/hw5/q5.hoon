:: hw5/q5.hoon
:: solutions to %hw5 q5 (hoon school 2022-2 cohort)
|=  [a=@ud b=@ud]
=<  [(~(add . a) b) (~(sub . a) b) (~(mul . a) b) (~(div . a) b)]
|_  v=@ud
++  add
  |=  i=@ud
  ^-  @ud
  %-  ^add
  [i v]
++  sub
  |=  i=@ud
  ^-  @ud
  %-  ^sub
  [i v]
++  mul
  |=  i=@ud
  ^-  @ud
  %-  ^mul
  [i v]
++  div
  |=  i=@ud
  ^-  @ud
  %-  ^div
  [i v]
--
