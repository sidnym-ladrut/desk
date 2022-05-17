:: hw7/q2.hoon
:: solutions to %hw7 q2 (hoon school 2022-2 cohort)
|=  [a=@ b=@]
|^  (sub a b)
++  sub
  |=  [a=@ b=@]
  ^-  @
  ?.  !=(0 b)  a
  $(a (dec a), b (dec b))
--
