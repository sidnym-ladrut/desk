:: hw6/q3.hoon
:: solutions to %hw6 q3 (hoon school 2022-2 cohort)
|=  ctape=tape
^-  (list tape)
%+  turn  (gulf 0 25)
|=  steps=@ud
^-  tape
%+  turn  ctape
|=  cchar=@tD
^-  @tD
?:  =(cchar ' ')  cchar
:: (((cchar - 'a') + steps) % 26) + 'a'
^-  @tD
%+  add  'a'
%-  mod  :_  26
%+  add  steps
(sub `@ud`cchar `@ud`'a')
