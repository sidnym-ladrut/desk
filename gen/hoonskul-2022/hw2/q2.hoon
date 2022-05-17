:: hw2/q2.hoon
:: solutions to %hw2 q2 (hoon school 2022-2 cohort)
:-  %say
|=  *
:-  %noun
|^
%-  factorial  10
++  factorial
  |=  i=@ud
  ^-  @ud
  (roll (gulf 1 i) mul)
--
