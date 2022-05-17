:: hw4/q4.hoon
:: solutions to %hw4 q4 (hoon school 2022-2 cohort)
|=  c=@ud
|^  (fizzbuzz c)
++  fizzbuzz
  |=  c=@ud
  %-  turn
  :-  (gulf 1 c)
  |=  i=@ud
  ?:  =((mod i 3) 0)
    ?:  =((mod i 5) 0)
      "fizzbuzz"
    "fizz"
  ?:  =((mod i 5) 0)
    "buzz"
  i
--
