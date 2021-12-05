:: advent of code 2021 day 1
:: https://adventofcode.com/2021/day/1
::
/*  puzzle-input  %txt  /lib/advent-2021/day1/txt

:-  %say
|=  *
:-  %noun

:: Part 1 Solution
:: %.  puzzle-input
:: |=  ilis=wain  ^-  @ud
:: =/  ffst=bean  %.y
:: =/  fcnt=@ud   0
:: =/  fprv=@ud   0
:: |-  ^-  @ud
:: ?~  ilis
::   fcnt
:: =+  fcur=(rash i.ilis dim:ag)
:: ?:  ffst
::   $(ilis t.ilis, ffst %.n, fcnt fcnt, fprv fcur)
:: ?:  (gth fcur fprv)
::   $(ilis t.ilis, fcnt +(fcnt), fprv fcur)
:: $(ilis t.ilis, fprv fcur)

:: Part 2 Solution
%.  puzzle-input
|=  ilis=wain  ^-  @ud
=/  fitr=@ud  0
=/  fcnt=@ud  0
=/  fprv=@ud  0
=/  fqeu=(list @ud)  ~
|-  ^-  @ud
?~  ilis
  fcnt
=+  inxt=(rash i.ilis dim:ag)
=+  fcur=(add fprv inxt)
=.  fqeu  [inxt fqeu]
?:  (lth fitr 3)
  $(ilis t.ilis, fitr +(fitr), fprv fcur)
=+  ilst=(snag 3 fqeu)
=.  fqeu  (snip fqeu)
=.  fcur  (sub fcur ilst)
?:  (gth fcur fprv)
  $(ilis t.ilis, fitr +(fitr), fcnt +(fcnt), fprv fcur)
$(ilis t.ilis, fitr +(fitr), fprv fcur)
