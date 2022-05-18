:: hw9/q2.hoon
:: solutions to %hw9 q2 (hoon school 2022-2 cohort)
/+  *test
/=  math-door  /gen/hoonskul-2022/hw5/q5
|%
:: NOTE: 'math-door' is a generator (gate) that takes any argument and
:: produces the door for %hw5 q5; implemented this way to keep all homework
:: in the 'gen/hoonskul-2022' directory.
++  on  (math-door %~)
++  test-add
  ;:  weld
  %+  expect-eq
    !>  5
    !>  (~(add on 5) 0)
  %+  expect-eq
    !>  10
    !>  (~(add on 5) 5)
  %+  expect-eq
    !>  25
    !>  (~(add on 5) 20)
  ==
++  test-sub
  ;:  weld
  %+  expect-eq
    !>  15
    !>  (~(sub on 5) 20)
  %+  expect-eq
    !>  0
    !>  (~(sub on 5) 5)
  %-  expect-fail
    |.  (~(sub on 5) 0)
  ==
++  test-mul
  ;:  weld
  %+  expect-eq
    !>  0
    !>  (~(mul on 5) 0)
  %+  expect-eq
    !>  5
    !>  (~(mul on 5) 1)
  %+  expect-eq
    !>  25
    !>  (~(mul on 5) 5)
  %+  expect-eq
    !>  100
    !>  (~(mul on 5) 20)
  ==
++  test-div
  ;:  weld
  %+  expect-eq
    !>  0
    !>  (~(div on 5) 0)
  %+  expect-eq
    !>  0
    !>  (~(div on 5) 1)
  %+  expect-eq
    !>  1
    !>  (~(div on 5) 5)
  %+  expect-eq
    !>  4
    !>  (~(div on 5) 20)
  %-  expect-fail
    |.  (~(div on 0) 5)
  ==
--
