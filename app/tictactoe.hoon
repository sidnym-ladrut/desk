:: TODO:
:: - Allow for playing the game across the network between 2 players.
:: -
/+  shoe, verb, dbug, default-agent
|%
+$  team  ?(%ex %oh)
+$  tile  ?(%ex %oh %no)
+$  state-0
  $:  %0
      w=@ud
      h=@ud
      last=team
      tiles=(list tile)
  ==
::
+$  command
  $?  [%move @ud @ud]
      [%show ~]
      [%reset ~]
  ==
+$  card  card:shoe
--
=|  state-0
=*  state  -
::
%+  verb  |
%-  agent:dbug
^-  agent:gall
%-  (agent:shoe command)
^-  (shoe:shoe command)
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this %|) bowl)
    des   ~(. (default:shoe this command) bowl)
::
++  on-init
  ^-  (quip card _this)
  :: TODO: Understand what''s going on here.
  :: tis-dot: =. [wing hoon hoon]
  :: - 0: (wing) location of the change
  :: - 1: (hoon) the new value for the wing 0
  :: - 2: (hoon) further evaluations
  :: tis-ket: =^ [skin wing hoon hoon]
  :: - 0: (skin) new name, possibly w/ new type annotation
  :: - 1: (wing) wing of replacement for tail of 2
  :: - 2: (hoon) evaluates to a pair; head becomes 0, tail becomes
  ::             value at 1
  :: - 3: (hoon) further evaluations
  :: =^  cards  state  (prep:tc ~)
  :: [cards this]
  :: TODO: Create card to set prompt on load (even trivial
  :: cards don't work here for some reason).
  [~ this(w 3, h 3, last %oh, tiles (reap (mul 3 3) %no))]
++  on-save   !>(state)
++  on-load
  |=  old=vase
  ^-  (quip card _this)
  [~ this]
::
++  on-poke   on-poke:def
++  on-watch  on-watch:def
++  on-leave  on-leave:def
++  on-peek   on-peek:def
++  on-agent  on-agent:def
++  on-arvo   on-arvo:def
++  on-fail   on-fail:def
::
++  command-parser
  |=  sole-id=@ta
  ^+  |~(nail *(like [? command]))
  %+  stag  |
  %+  knee  *command  |.  ~+
  =-  ;~(pfix mic -:.)
  ;~  pose
    ;~((glue ace) (cold %move (jest %move)) dem dem)
    ;~(plug (cold %show (jest %show)) (easy ~))
    ;~(plug (cold %reset (jest %reset)) (easy ~))
  ==
::
++  tab-list
  |=  sole-id=@ta
  ^-  (list [@t tank])
  :~
    [';move' leaf+"make move at [x y]"]
    [';show' leaf+"show the current game board"]
    [';reset' leaf+"reset the game board"]
  ==
::
++  on-command
  |=  [sole-id=@ta job=command]
  ^-  (quip card _this)
  |^  =;  [new=_this fec=(list sole-effect:shoe)]
      [[%shoe ~ [%sole [%mor (to-prompt-effect new) fec]]]~ new]
    ?-  -.job
      %move  (do-move this +.job)
      %show  (do-show this)
      %reset  (do-reset this)
    ==
  ::
    ++  do-move
      :: TODO: Clean up the implementation of this function.
      |=  [this=_this xy=[@ud @ud]]
      ^-  [_this (list sole-effect:shoe)]
      =/  next=team
      ?-  last.this
        %ex  %oh
        %oh  %ex
      ==
      =/  new=_this  (make-move [this -.xy +.xy next])
      :-  new
      ?.  =(tiles.new tiles.this)
        (to-string-effect new)
      [[%txt "({~(rend co %$ %ud -.xy)}, {~(rend co %$ %ud +.xy)}) move is invalid."] (to-string-effect new)]
    ++  do-show
      |=  this=_this
      ^-  [_this (list sole-effect:shoe)]
      :-  this
      (to-string-effect this)
    ++  do-reset
      |=  this=_this
      ^-  [_this (list sole-effect:shoe)]
      =/  new=_this  this(w 3, h 3, last %oh, tiles (reap (mul 3 3) %no))
      :-  new
      (to-string-effect new)
  ::
    ++  make-move
      |=  [this=_this x=@ud y=@ud next=team]
      ^-  _this
      =/  i=@ud   (get-tile-id [x y])
      ?:  =(last.this next)
        this
      ?.  =((snag i tiles.this) %no)
        this
      ?.  =((get-winner this) %no)
        this
      %=  this
        last   next
        tiles  (snap tiles i `tile`next)
      ==
    ++  to-string-effect
      |=  this=_this
      ^-  (list sole-effect:shoe)
      =/  rem=tape  (to-string this)
      =/  sfx=(list sole-effect:shoe)  ~
      |-  ^-  (list sole-effect:shoe)
      ?~  rem
        (flop sfx)
      %=  $
        rem  (slag 5 `tape`rem)
        sfx  [[%txt (scag 5 `tape`rem)] sfx]
      ==
    ++  to-string
      |=  this=_this
      ^-  tape
      =/  win=tile  (get-winner this)
      =/  y=@ud   1
      =/  t=tape  ""
      |-  ^-  tape
      =/  x=@ud    1
      =/  s=tape  ""
      :: TODO: 'Win:O'
      ?:  =(y +(h))
        =/  f=tape  :(weld "-----" t "-----")
        ?:  =(win %no)
          f
        ?:  =(win %ex)
          (weld f "Win:X")
        (weld f "Win:O")
      %=  $
        y  +(y)
        t
        |-  ^-  tape
        ?:  =(x +(w))  :(weld t "|" (flop s) "|")
        =/  n=tile  (get-tile [this x y])
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
    ++  to-prompt-effect
      |=  this=_this
      ^-  sole-effect:shoe
      [%pro & %talk-line (to-prompt this)]
    ++  to-prompt
      |=  this=_this
      ^-  tape
      =+  (get-winner this)
      ?.  =(- %no)
        "[~]>"
      ?-  last.this
        %ex  "[O]>"
        %oh  "[X]>"
      ==
    ++  get-winner
      |=  this=_this
      ^-  tile
      =/  i=@ud  0
      |-  ^-  tile
      ?:  =(i (mul 3 3))
        %no
      =+  xy=(get-id-tile i)
      :: crosses at (x, y)
      =+  csxy=(get-crosses this xy)
      :: tiles at (x, y)
      =+  gtc=|=([x=@ud y=@ud] (get-tile this x y))
      =/  tsxy=(list (list tile))  (turn csxy |=(cxy=(list [@ud @ud]) (turn cxy gtc)))
      |-  ^-  tile
      ?~  tsxy
        ^$(i +(i))
      ?:  (roll i.tsxy |:([a=`tile`%no b=`bean`%.y] &(=(-.i.tsxy a) b)))
        -.i.tsxy
      $(tsxy t.tsxy)
    ++  get-crosses
      |=  [this=_this x=@ud y=@ud]
      ^-  (list (list [@ud @ud]))
      =/  cands=(list (list [@ud @ud]))  :~
        ~[[(sub x 0) (sub y 1)] [(add x 0) (add y 0)] [(add x 0) (add y 1)]]
        ~[[(sub x 1) (add y 0)] [(add x 0) (add y 0)] [(add x 1) (add y 0)]]
        ~[[(sub x 1) (sub y 1)] [(add x 0) (add y 0)] [(add x 1) (add y 1)]]
        ~[[(sub x 1) (add y 1)] [(add x 0) (add y 0)] [(add x 1) (sub y 1)]]
      ==
      %+  skim  cands
        |=  cand=(list [@ud @ud])
        %+  roll  cand
          |:  [ci=`[@ud @ud]`[0 0] cb=`bean`%.y]
          &((is-tile-valid ci) cb)
    ++  get-tile
      |=  [this=_this x=@ud y=@ud]
      ^-  tile
      (snag (get-tile-id [x y]) tiles.this)
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
::
++  can-connect
  |=  sole-id=@ta
  ^-  ?
  ?|  =(~zod src.bowl)
      (team:title [our src]:bowl)
  ==
::
++  on-connect
  |=  sole-id=@ta
  ^-  (quip card _this)
  :: TODO: Correct the prompt displayed here.
  [[%shoe ~ [%sole [%pro & %talk-line "[?]>"]]]~ this]
++  on-disconnect   on-disconnect:des
--
