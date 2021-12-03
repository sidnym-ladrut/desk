:: tlent
::
:: tlent(l) = len(l)
::
|=  l=(list @)
=/  len=@ud  0
|-
^-  @ud
?~  l
  len
$(l t.l, len (add len 1))
