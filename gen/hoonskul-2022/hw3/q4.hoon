:: hw4/q4.hoon
:: solutions to %hw4 q4 (hoon school 2022-2 cohort)
|=  c=@ud
^-  @ud
|^  (buzz c)
++  buzz
  |=  c=@ud
  ^-  @ud
  =/  i  1
  |-
  ?:  (gth i c)
    c
  ~&  i
  ?:  =((mod i 5) 0)
    ~&  "buzz"
    $(i +(i))
  $(i +(i))
--
