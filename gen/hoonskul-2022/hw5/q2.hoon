:: hw5/q2.hoon
:: solutions to %hw5 q2 (hoon school 2022-2 cohort)
|=  n=@ud
^-  (list @ud)
|^  (primes n)
++  primes
  |=  n=@ud
  ^-  (list @ud)
  =/  l=(list @ud)  ~
  =/  k=@ud         1
  |-
  ?:  (gte k n)
    (flop l)
  %=  $
    k  +(k)
    l  [(sub (add (pow k 2) n) k) l]
  ==
--
