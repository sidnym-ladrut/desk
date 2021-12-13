:: advent of code 2021 day 4
:: https://adventofcode.com/2021/day/4
::
/*  puzzle-input  %txt  /lib/advent-2021/day4/txt

:-  %say
|=  *
=<
:-  %noun  (day4-solve-2 puzzle-input)

|%
+$  day4-board
  $:
    tiles=(list (list @ud))  :: (y, x)
    marks=(list (list bean)) :: (y, x)
  ==
::
++  day4-board-mark
  |=  input=[day4-board @ud]
  ^-  day4-board
  =+  board=-.input
  =+  value=+.input
  =+  tiles-flat=(zing tiles.board)
  =+  mark-index=(find [value]~ tiles-flat)
  ?@  mark-index
    board
  =+  by=(div +.mark-index 5)
  =+  bx=(mod +.mark-index 5)
  =+  ymarks=`(list bean)`(snag by marks.board)
  board(marks (snap marks.board by (snap ymarks bx `bean`%.y)))
::
++  day4-board-winner
  |=  input=day4-board
  ^-  bean
  =/  horizontals=(list bean)
    =+  tmarks=marks.input
    =/  thorizontals=(list bean)  ~
    |-  ^-  (list bean)
    ?~  tmarks
      thorizontals
    =+  nhorizontal=(levy i.tmarks |=(i=bean i))
    %=  $
      tmarks  t.tmarks
      thorizontals  [nhorizontal thorizontals]
    ==
  =/  verticals=(list bean)
    =+  tx=0
    =/  tverticals=(list bean)  ~
    |-  ^-  (list bean)
    ?:  =(tx 5)
      tverticals
    =/  nverticals=(list bean)
      =/  tnverticals=(list bean)  ~
      =+  tmarks=marks.input
      |-  ^-  (list bean)
      ?~  tmarks
        tnverticals
      %=  $
        tmarks  t.tmarks
        tnverticals  [(snag tx i.tmarks) tnverticals]
      ==
    =+  nvertical=(levy nverticals |=(i=bean i))
    %=  $
      tx  +(tx)
      tverticals  [nvertical tverticals]
    ==
  :: =/  diagonals=(list bean)
  ::   =+  ti=0
  ::   =/  tdiagonals=(list bean)  ~
  ::   |-  ^-  (list bean)
  ::   ?:  =(ti 2)
  ::     tdiagonals
  ::   =+  tmarks=?:(=(ti 1) (flop marks.input) marks.input)
  ::   =/  ndiagonals=(list bean)
  ::     =/  tndiagonals=(list bean)  ~
  ::     =+  tx=0
  ::     |-  ^-  (list bean)
  ::     ?~  tmarks
  ::       tndiagonals
  ::     %=  $
  ::       tmarks  t.tmarks
  ::       tx  +(tx)
  ::       tndiagonals  [(snag tx i.tmarks) tndiagonals]
  ::     ==
  ::   =+  ndiagonal=(levy ndiagonals |=(i=bean i))
  ::   %=  $
  ::     ti  +(ti)
  ::     tdiagonals  [ndiagonal tdiagonals]
  ::   ==
  =+  win-lists=(weld horizontals verticals)
  (lien win-lists |=(i=bean i))
::
++  day4-board-score
  |=  input=day4-board
  ^-  @ud
  =+  score=0
  =+  ytiles=tiles.input
  =+  ymarks=marks.input
  |-  ^-  @ud
  ?~  ytiles
    score
  ?~  ymarks
    score
  =+  xtiles=i.ytiles
  =+  xmarks=i.ymarks
  =+  xscore=0
  %=  $
    ytiles  t.ytiles
    ymarks  t.ymarks
    score   %+  add  score
      |-  ^-  @ud
      ?~  xtiles
        xscore
      ?~  xmarks
        xscore
      %=  $
        xtiles  t.xtiles
        xmarks  t.xmarks
        xscore  (add xscore ?:(!i.xmarks i.xtiles 0))
      ==
  ==
::
++  day4-parse
  |=  input=(list @t)
  ^-  [(list @ud) (list day4-board)]
  =+  ^=  chomp-rand
    |=  input=(list @t)
    ^-  [(list @ud) (list @t)]
    ?~  input
      [~ ~]
    :_  t.input
    %+  rash  i.input
    (more com dem)
  =+  ^=  chomp-board
    |=  input=(list @t)
    ^-  [day4-board (list @t)]
    =/  ci=@ud  0
    =/  ctiles=(list (list @ud))  ~
    |-  ^-  [day4-board (list @t)]
    ?~  input
      [[tiles=(flop ctiles) marks=(reap 5 (reap 5 %.n))] input]
    ?:  =(ci 0)
      $(ci +(ci), input t.input)
    ?:  =(ci 6)
      [[tiles=(flop ctiles) marks=(reap 5 (reap 5 %.n))] input]
    :: modified input to add 0 in front of single-digit numbers
    :: TODO: exercise; write a parser for non-padded numbers
    =+  itiles=(rash i.input (more ace dem))
    $(ci +(ci), input t.input, ctiles [itiles ctiles])
  =^  rand   input  (chomp-rand input)
  =/  tboards=(list day4-board)  ~
  =+  ^=  boards
    |-  ^-  (list day4-board)
    ?~  input
      tboards
    :: the following can't be used easily because 'chomp-board'
    :: gives a '(list @t)' and in this branch 'input' is '(lest @t)'
    :: =^  board  input  (chomp-board input)
    =+  result=(chomp-board input)
    $(input +.result, tboards [-.result tboards])
  [rand (flop boards)]
::
++  day4-solve-1
  |=  input=(list @t)
  ^-  @ud
  =+  parse-input=(day4-parse input)
  =+  rand=-.parse-input
  =+  boards=+.parse-input
  |-  ^-  @ud
  ?~  rand
    !!
  =.  boards  (turn boards |=(i=day4-board (day4-board-mark [i i.rand])))
  =+  winners=(skim boards day4-board-winner)
  ?~  winners
    $(rand t.rand)
  (mul (day4-board-score i.winners) i.rand)
::
++  day4-solve-2
  |=  input=(list @t)
  ^-  @ud
  =+  parse-input=(day4-parse input)
  =+  rand=-.parse-input
  =+  boards=+.parse-input
  =+  worst-board=*day4-board
  =+  worst-number=*@ud
  |-  ^-  @ud
  ?~  rand
    ~&  worst-board
    ~&  worst-number
    (mul (day4-board-score worst-board) worst-number)
  =.  boards  (turn boards |=(i=day4-board (day4-board-mark [i i.rand])))
  =+  winners=(skim boards day4-board-winner)
  ?~  winners
    $(rand t.rand)
  %=  $
    rand  t.rand
    boards  (skim boards |=(i=day4-board ?@((find [i]~ winners) %.y %.n)))
    worst-board  i.winners
    worst-number  i.rand
  ==
--
