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
|=  [* [n=@ud ~] ~]
:-  %noun
^-  tape
?:  =(n 0)  !!
?:  =(n 1)  "1"
%+  roll  (gulf 2 n)
|:  [n=0 t="1"]
%-  zing
%+  scan  t
%-  plus
%+  cook
|=(i=(list @t) [`@t`(add '0' (lent i)) (snag 0 i) ~])
:: Only need {1, 2, 3} by Conway's "One-Day Theorem"; see:
:: https://web.archive.org/web/20061224154744/http://www.uam.es/personal_pdi/ciencias/omartin/Biochem.PDF
;~  pose
  (plus (just '1'))
  (plus (just '2'))
  (plus (just '3'))
==
