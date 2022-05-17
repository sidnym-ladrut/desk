:: hw5/q4.hoon
:: solutions to %hw5 q4 (hoon school 2022-2 cohort)
|=  n=@ud
^-  @ud
|^  (factorial n)
++  factorial
  |=  n=_1
  ^-  @ud
  =/  i=@ud  1
  =/  s=@ud  1
  |-
  ?:  (gth i n)
    s
  $(i +(i), s (mul s i))
--
