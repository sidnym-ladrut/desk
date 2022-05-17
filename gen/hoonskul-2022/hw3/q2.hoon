:: hw3/q2.hoon
:: solutions to %hw3 q2 (hoon school 2022-2 cohort)
:-  %say
|=  *
:-  %noun
^-  @ud
=/  d  1
=/  s  0
|-
?:  (gth d 7)
  s
$(d +(d), s (add s (mul d d)))
