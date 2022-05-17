:: hw8/q1.hoon
:: solutions to %hw8 q1 (hoon school 2022-2 cohort)
|=  math=tape
|^  (scan math expr)
++  factor
  %+  knee  *@ud
  |.  ~+
  ;~  pose
    dem
    (ifix [pal par] expr)
  ==
++  expo
  %+  knee  *@ud
  |.  ~+
  ;~  pose
    ((slug |:([a=0 b=1] (pow a b))) ket ;~(pose factor expo))
    factor
  ==
++  term
  %+  knee  *@ud
  |.  ~+
  ;~  pose
    ((slug mul) tar ;~(pose expo term))
    expo
  ==
++  expr
  %+  knee  *@ud
  |.  ~+
  ;~  pose
    ((slug add) lus ;~(pose term expr))
    term
  ==
--
