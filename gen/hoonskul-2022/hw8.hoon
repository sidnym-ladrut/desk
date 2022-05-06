:: hw8.hoon
::
:: solutions to %hw8 (hoon school 2022-2 cohort)
::
:: question 1: arithmetic parsing algorithm
:: |=  math=tape
:: |^  (scan math expr)
:: ++  factor
::   %+  knee  *@ud
::   |.  ~+
::   ;~  pose
::     dem
::     (ifix [pal par] expr)
::   ==
:: ++  expo
::   %+  knee  *@ud
::   |.  ~+
::   ;~  pose
::     ((slug |:([a=0 b=1] (pow a b))) ket ;~(pose factor expo))
::     factor
::   ==
:: ++  term
::   %+  knee  *@ud
::   |.  ~+
::   ;~  pose
::     ((slug mul) tar ;~(pose expo term))
::     expo
::   ==
:: ++  expr
::   %+  knee  *@ud
::   |.  ~+
::   ;~  pose
::     ((slug add) lus ;~(pose term expr))
::     term
::   ==
:: --
:: question 2: Gleichniszahlenreihe
:-  %say
|=  [* [t=tape ~] ~]
:-  %noun
^-  tape
%-  roll
:_  |=([n=tape a=tape] (weld a n))
^-  (list tape)
%+  scan  t
%-  plus
%+  cook
|=(i=(list @t) [`@t`(add '0' (lent i)) (snag 0 i) ~])
;~  pose
  (plus (just '0'))
  (plus (just '1'))
  (plus (just '2'))
  (plus (just '3'))
  (plus (just '4'))
  (plus (just '5'))
  (plus (just '6'))
  (plus (just '7'))
  (plus (just '8'))
  (plus (just '9'))
==
