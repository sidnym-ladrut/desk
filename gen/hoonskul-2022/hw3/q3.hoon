:: hw3/q3.hoon
:: solutions to %hw3 q3 (hoon school 2022-2 cohort)
|=  c=@ud
^-  @ud
|^  (fizz c)
++  fizz
  |=  c=@ud
  ^-  @ud
  =/  i  1
  |-
  ?:  (gth i c)
    c
  ~&  i
  ?:  =((mod i 3) 0)
    ~&  "fizz"
    $(i +(i))
  $(i +(i))
--
