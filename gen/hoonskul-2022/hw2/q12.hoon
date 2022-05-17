:: hw2/q12.hoon
:: solutions to %hw2 q12 (hoon school 2022-2 cohort)
::
:: boxcar.hoon
::
:: implements the "boxcar function", i.e.:
::
::              +-  1    if 3 < x <= 5
:: boxcar(x) := |
::              +-  0    otherwise
::
|=  x=@ud
?:  (lte x 5)
  ?:  (gth x 3)
    1
  0
0
