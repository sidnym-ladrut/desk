::  tictactoe.hoon
::
::  This code contains the 'tictactoe' multi-arm core, which simulates
::  a tic-tac-toe board.
!:
:-  %say
|=  *
:-  %noun
=<

=~
board
init
:: X winner
(make-move [3 3 %ex])
(make-move [3 2 %oh])
(make-move [2 2 %ex])
(make-move [1 1 %oh])
(make-move [1 3 %ex])
(make-move [2 3 %oh])
(make-move [3 1 %ex])
get-winner
::
:: O winner
:: (make-move [1 2 %ex])
:: (make-move [1 1 %oh])
:: (make-move [1 3 %ex])
:: (make-move [2 1 %oh])
:: (make-move [2 3 %ex])
:: (make-move [3 1 %oh])
:: get-winner

:: to-string
==

|%
+$  team  ?(%ex %oh)
+$  tile  ?(%ex %oh %no)
++  board
  |_  [w=@ud h=@ud last=team tiles=(list tile)]
  ++  init
    .(w 3, h 3, last %oh, tiles (reap (mul 3 3) %no))
  ++  make-move
    |=  [x=@ud y=@ud next=team]
    ?:  =(last next)  +>.$
    +>.$(last next, tiles (snap tiles (get-tile-id [x y]) `tile`next))
  ++  get-winner
    |-  ^-  tile
    =/  i=@ud  0
    |-  ^-  tile
    ?:  =(i (mul w h))
      %no
    =+  xy=(get-id-tile i)
    :: crosses at (x, y)
    =+  csxy=(get-crosses xy)
    :: tiles at (x, y)
    =/  tsxy=(list (list tile))  (turn csxy |=(cxy=(list [@ud @ud]) (turn cxy get-tile)))
    |-  ^-  tile
    ?~  tsxy  ^$(i +(i))
    :: in order to make the 'roll' work, we need to use molds on the
    :: default parameter values to indicate all possible values; just
    :: using '%oh' or '%.y' doesn't properly communicate all possible
    :: values that can be used the fill the parameters (i.e. 'tile' and
    :: 'bean', respectively)
    ?:  (roll i.tsxy |:([a=`tile`%no b=`bean`%.y] &(=(-.i.tsxy a) b)))
      -.i.tsxy
    $(tsxy t.tsxy)
  ++  to-string
    |-  ^-  tape
    =/  y=@ud   1
    =/  t=tape  ""
    |-  ^-  tape
    =/  x=@ud    1
    =/  s=tape  ""
    ?:  =(y +(h))  t
    %=  $
      y  +(y)
      t
      |-  ^-  tape
      ?:  =(x +(w))  (weld (weld t (flop s)) "|")
      =/  n=tile  (get-tile [x y])
      %=  $
        x  +(x)
        s  :_  s
          ?-  n
            %ex  'X'
            %oh  'O'
            %no  '~'
          ==
      ==
    ==
  ++  get-crosses
    |=  [x=@ud y=@ud]
    ^-  (list (list [@ud @ud]))
    =/  cands=(list (list [@ud @ud]))  :~
        ~[[(sub x 0) (sub y 1)] [(add x 0) (add y 0)] [(add x 0) (add y 1)]]
        ~[[(sub x 1) (add y 0)] [(add x 0) (add y 0)] [(add x 1) (add y 0)]]
        ~[[(sub x 1) (sub y 1)] [(add x 0) (add y 0)] [(add x 1) (add y 1)]]
        ~[[(sub x 1) (add y 1)] [(add x 0) (add y 0)] [(add x 1) (sub y 1)]]
      ==
    (skim cands |=(c=(list [@ud @ud]) (roll c |:([ci=`[@ud @ud]`[0 0] cb=`bean`%.y] &((is-tile-valid ci) cb)))))
  ++  get-tile
    |=  [x=@ud y=@ud]
    ^-  tile
    (snag (get-tile-id [x y]) tiles)
  ++  get-tile-id
    |=  [x=@ud y=@ud]
    ^-  @ud
    (add (sub x 1) (mul 3 (sub y 1)))
  ++  get-id-tile
    |=  i=@ud
    ^-  [@ud @ud]
    [(add 1 (mod i 3)) (add 1 (div i 3))]
  ++  is-tile-valid
    |=  [x=@ud y=@ud]
    ^-  bean
    &((gte x 1) (gte y 1) (lte x 3) (lte y 3))
  --
--
