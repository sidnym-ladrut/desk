:: hw4/q3.hoon
:: solutions to %hw4 q3 (hoon school 2022-2 cohort)
|=  l=$:(@ud @ud @ud @ud @ud @ud @ud ~)
^-  @ud
|^  (weekly-reagent l)
++  weekly-reagent
  |=  l=$:(@ud @ud @ud @ud @ud @ud @ud ~)
  ^-  @ud
  =/  i  `(list @ud)`l
  =/  s  0
  |-
  ?~  i
    s
  $(i t.i, s (add s i.i))
--
