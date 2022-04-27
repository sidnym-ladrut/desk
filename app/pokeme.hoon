/-  poke
/+  default-agent, dbug
|%
+$  versioned-state
  $%  state-0
      state-1
  ==
+$  state-0  [%0 val=@ud]
+$  state-1  [%1 val=@ud =friends:poke]
+$  card  card:agent:gall
--
%-  agent:dbug
=|  state-1
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
    %1  `this(state old)
    %0  `this(state 1+[val.old *(set @p)])
  ==
::
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  ?>  |(=(our.bowl src.bowl) (~(has in friends) src.bowl))
  ?+    mark  (on-poke:def mark vase)
      %poke-action
    =/  action  !<(action:poke vase)
    ?-    action
        %inc
      `this(val +(val))
    ::
        %dec
      ?:  =(0 val)
        ~|  "Can't decrement - already zero!"
        !!
      `this(val (dec val))
    ::
        %mul
      `this(val (mul val val))
    ::
        %rst
      `this(val 0)
    ::
        [%perm @p]
      ?>  =(our.bowl src.bowl)
      `this(friends (~(put in friends) +.action))
    ::
        [%kick @p]
      ?>  =(our.bowl src.bowl)
      `this(friends (~(del in friends) +.action))
    ==
  ==
::
++  on-watch  on-watch:def
++  on-leave  on-leave:def
++  on-peek   on-peek:def
++  on-agent  on-agent:def
++  on-arvo   on-arvo:def
++  on-fail   on-fail:def
--
