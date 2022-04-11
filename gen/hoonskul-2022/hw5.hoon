:: hw5.hoon
::
:: solutions to %hw5 (hoon school 2022-2 cohort)
::
:: question 1: decrement gate
:: |=  i=@ud
:: ^-  @ud
:: |^  (decrement i)
:: ++  decrement
::   |=  i=@ud
::   ^-  @ud
::   ?:  =(i 0)  :: underflow error
::     !!
::   =/  j  0
::   |-
::   ?:  =(+(j) i)
::     j
::   $(j +(j))
:: --
:: question 2: primes gate
:: |=  n=@ud
:: ^-  (list @ud)
:: |^  (primes n)
:: ++  primes
::   |=  n=@ud
::   ^-  (list @ud)
::   =/  l=(list @ud)  ~
::   =/  k=@ud         1
::   |-
::   ?:  (gte k n)
::     (flop l)
::   %=  $
::     k  +(k)
::     l  [(sub (add (pow k 2) n) k) l]
::   ==
:: --
:: question 3: compiled battery
:: dojo> =a |=(a=@ud (add 1 a))
:: dojo> -:a
:: [8 [9 36 0 8.191] 9 2 10 [6 [7 [0 3] 1 1] 0 14] 0 2]
:: question 4: factorial gate
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
:: question 5: calc door
:: |=  [a=@ud b=@ud]
:: =<  [(~(add . a) b) (~(sub . a) b) (~(mul . a) b) (~(div . a) b)]
:: |_  v=@ud
:: ++  add
::   |=  i=@ud
::   ^-  @ud
::   %-  ^add
::   [v i]
:: ++  sub
::   |=  i=@ud
::   ^-  @ud
::   %-  ^sub
::   [v i]
:: ++  mul
::   |=  i=@ud
::   ^-  @ud
::   %-  ^mul
::   [v i]
:: ++  div
::   |=  i=@ud
::   ^-  @ud
::   %-  ^div
::   [v i]
:: --
