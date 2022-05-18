:: hw9/q1.hoon
:: solutions to %hw9 q1 (hoon school 2022-2 cohort)
/+  *test
/=  euler-primes  /gen/hoonskul-2022/hw5/q2
|%
++  test-bad-inputs
  ;:  weld
  %-  expect-fail
    |.  (euler-primes 0)
  %-  expect-fail
    |.  (euler-primes 1)
  ==
++  test-small-inputs
  ;:  weld
  %+  expect-eq
    !>  (limo ~[2])
    !>  (euler-primes 2)
  %+  expect-eq
    !>  (limo ~[3 5])
    !>  (euler-primes 3)
  ==
++  test-large-inputs
  ;:  weld
  %-  expect
    !>  (is-primes (euler-primes 17))
  %-  expect
    !>  (is-primes (euler-primes 41))
  ==
++  test-all-lucky-inputs
  =/  luckies=(list @ud)  ~[2 3 5 11 17 41]
  %-  expect
    !>  (levy luckies |=(n=@ud (is-primes (euler-primes n))))
++  is-primes
  :: trial division primality test
  |=  l=(list @ud)
  ^-  bean
  %+  levy  l
  |=  n=@ud
  ^-  bean
  ?:  (lte n 1)  %.n
  ?:  (lte n 3)  %.y
  %+  levy  (gulf 2 (div n 2))
  |=(i=@ud !=((mod n i) 0))
--
