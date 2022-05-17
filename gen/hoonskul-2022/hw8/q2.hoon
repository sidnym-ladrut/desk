:: hw8/q2.hoon
:: solutions to %hw8 q2 (hoon school 2022-2 cohort)
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
