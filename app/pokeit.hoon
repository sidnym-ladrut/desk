/-  poke
/+  default-agent, dbug
|%
+$  versioned-state
  $%  state-0
  ==
+$  state-0  [%0 ~]
+$  card  card:agent:gall
--
%-  agent:dbug
=|  state-0
=*  state  -
^-  agent:gall
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this %.n) bowl)
::
++  on-init
  ^-  (quip card _this)
  `this
::
++  on-save
  ^-  vase
  !>(state)
::
++  on-load
  |=  old-state=vase
  ^-  (quip card _this)
  =/  old  !<(versioned-state old-state)
  ?-  -.old
    %0  `this(state old)
  ==
::
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  ?+    mark  (on-poke:def mark vase)
      %noun
    =/  action  !<(?([%inc @p] [%dec @p] [%mul @p] [%rst @p]) vase)
    :_  this
    ?-    -.action
        %inc
      :~  [%pass /inc %agent [+.action %pokeme] %poke %poke-action !>(%inc)]
          [%pass /inc %agent [+.action %pokeme] %poke %poke-action !>(%inc)]
      ==
    ::
        %dec
      :~  [%pass /dec %agent [+.action %pokeme] %poke %poke-action !>(%dec)]
          [%pass /dec %agent [+.action %pokeme] %poke %poke-action !>(%dec)]
      ==
    ::
        %mul
      :~  [%pass /mul %agent [+.action %pokeme] %poke %poke-action !>(%mul)]
          [%pass /mul %agent [+.action %pokeme] %poke %poke-action !>(%mul)]
      ==
    ::
        %rst
      :~  [%pass /rst %agent [+.action %pokeme] %poke %poke-action !>(%rst)]
      ==
    ==
  ==
::
++  on-watch  on-watch:def
++  on-leave  on-leave:def
++  on-peek   on-peek:def
::
++  on-agent
  |=  [=wire =sign:agent:gall]
  ^-  (quip card _this)
  ?+    wire  (on-agent:def wire sign)
      [%inc ~]
    ?.  ?=(%poke-ack -.sign)
      (on-agent:def wire sign)
    %-  (slog leaf+"%pokeit: Increment poke {<?~(p.sign 'succeeded' 'failed')>}!" ~)
    `this
  ::
      [%dec ~]
    ?.  ?=(%poke-ack -.sign)
      (on-agent:def wire sign)
    %-  (slog leaf+"%pokeit: Decrement poke {<?~(p.sign 'succeeded' 'failed')>}!" ~)
    `this
  ::
      [%mul ~]
    ?.  ?=(%poke-ack -.sign)
      (on-agent:def wire sign)
    %-  (slog leaf+"%pokeit: Multiply poke {<?~(p.sign 'succeeded' 'failed')>}!" ~)
    `this
  ::
      [%rst ~]
    ?.  ?=(%poke-ack -.sign)
      (on-agent:def wire sign)
    %-  (slog leaf+"%pokeit: Reset poke {<?~(p.sign 'succeeded' 'failed')>}!" ~)
    `this
  ==
::
++  on-arvo   on-arvo:def
++  on-fail   on-fail:def
--
