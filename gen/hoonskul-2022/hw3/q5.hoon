:: hw3/q5.hoon
:: solutions to %hw3 q5 (hoon school 2022-2 cohort)
|=  c=@ud
^-  @ud
|^  (fizzbuzz c)
++  fizzbuzz
  |=  c=@ud
  ^-  @ud
  =/  i  1
  |-
  ?:  (gth i c)
    c
  ~&  i
  ?:  =((mod i 3) 0)
    ~&  "fizz"
    ?:  =((mod i 5) 0)
      ~&  "buzz"
      $(i +(i))
    $(i +(i))
  ?:  =((mod i 5) 0)
    ~&  "buzz"
    $(i +(i))
  $(i +(i))
--
