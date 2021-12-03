:: tsnag
::
:: S(i, l) = l[i]
::
:: |=  [i=@ l=(list @)]
:: ^-  @
:: ?:  =(i 0)
::   -.l
:: $(i (sub i 1), l +.l)

|=  in=[@ (list @)]
?:  =(-:in 0)
  +<:in
$(in [(dec -:in) (+>:in)])
