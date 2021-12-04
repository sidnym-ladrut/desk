!:
:-  %say
|=  [* [msg=tape steps=@ud ~] ~]
=<
=.  msg  (cass msg)
:-  %noun  [(shift msg steps) (unshift msg steps)]

|%
++  alpha  "abcdefghijklmnopqrstuvwxyz"
++  punct  "~`'!@#$%^|&*;:<>()[]+-=,./? " :: issues w/ " and }
++  shift
  |=  [message=tape shift-steps=@ud]
  ^-  tape
  (operate message (encoder shift-steps))
++  unshift
  |=  [message=tape shift-steps=@ud]
  ^-  tape
  (operate message (decoder shift-steps))
++  encoder
  |=  [steps=@ud]
  ^-  (map @t @t)
  =/  alpha-shift=tape  (rotation alpha steps)
  =/  punct-shift=tape  (rotation punct steps)
  (~(uni by (map-maker alpha alpha-shift)) (map-maker punct punct-shift))
++  decoder
  |=  [steps=@ud]
  ^-  (map @t @t)
  =/  alpha-shift=tape  (rotation alpha steps)
  =/  punct-shift=tape  (rotation punct steps)
  (~(uni by (map-maker alpha-shift alpha)) (map-maker punct-shift punct))
++  operate
  |=  [message=tape shift-map=(map @t @t)]
  ^-  tape
  %+  turn  message
  |=  a=@t
  (~(got by shift-map) a)
++  space-adder
  |=  [key-position=tape value-result=tape]
  ^-  (map @t @t)
  (~(put by (map-maker key-position value-result)) ' ' ' ')
++  map-maker
  |=  [key-position=tape value-result=tape]
  ^-  (map @t @t)
  =|  chart=(map @t @t)
  ?.  =((lent key-position) (lent value-result))
  ~|  %uneven-lengths  !!
  |-
  ?:  |(?=(~ key-position) ?=(~ value-result))
  chart
  $(chart (~(put by chart) i.key-position i.value-result), key-position t.key-position, value-result t.value-result)
++  rotation
  |=  [my-alphabet=tape my-steps=@ud]
  =/  length=@ud  (lent my-alphabet)
  =+  (trim (mod my-steps length) my-alphabet)
  (weld q p)
--
