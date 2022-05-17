:: hw3/q1.hoon
:: solutions to %hw3 q1 (hoon school 2022-2 cohort)
|=  w=@ud
^-  @ud
|^  (corrected-weight w)
++  corrected-weight
  |=  w=@ud
  ?:  (lth w 10)
    0
  w
--
