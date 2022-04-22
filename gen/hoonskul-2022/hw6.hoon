:: hw6.hoon
::
:: solutions to %hw6 (hoon school 2022-2 cohort)
::
:: question 1: shakespeare chars->plays map
:: |=  *
:: `(map @t @t)`(my `(list [@t @t])`~[['Othello' 'Othello'] ['Desdemona' 'Othello'] ['Macbeth' 'Macbeth'] ['Lady Macbeth' 'Macbeth'] ['Yorick' 'Hamlet']])
:: question 2: extended caesar cipher
:: !:
:: |=  [msg=tape steps=@ud]
:: =<
:: =.  msg  (cass msg)
:: :-  (shift msg steps)
::     (unshift msg steps)
:: ::
:: |%
:: ++  alpha  "abcdefghijklmnopqrstuvwxyz.,;:'\""
:: ::  Shift a message to the right.
:: ::
:: ++  shift
::   |=  [message=tape steps=@ud]
::   ^-  tape
::   (operate message (encoder steps))
:: ::  Shift a message to the left.
:: ::
:: ++  unshift
::   |=  [message=tape steps=@ud]
::   ^-  tape
::   (operate message (decoder steps))
:: ::  Rotate forwards into encryption.
:: ::
:: ++  encoder
::   |=  [steps=@ud]
::   ^-  (map @t @t)
::   =/  value-tape=tape  (rotation alpha steps)
::   (space-adder alpha value-tape)
:: ::  Rotate backwards out of encryption.
:: ::
:: ++  decoder
::   |=  [steps=@ud]
::   ^-  (map @t @t)
::   =/  value-tape=tape  (rotation alpha steps)
::   (space-adder value-tape alpha)
:: ::  Apply the map of decrypted->encrypted letters to the message.
:: ::
:: ++  operate
::   |=  [message=tape shift-map=(map @t @t)]
::   ^-  tape
::   %+  turn  message
::   |=  a=@t
::   (~(got by shift-map) a)
:: ::  Handle spaces in the message.
:: ::
:: ++  space-adder
::   |=  [key-position=tape value-result=tape]
::   ^-  (map @t @t)
::   (~(put by (map-maker key-position value-result)) ' ' ' ')
:: ::  Produce a map from each letter to its encrypted value.
:: ::
:: ++  map-maker
::   |=  [key-position=tape value-result=tape]
::   ^-  (map @t @t)
::   =|  chart=(map @t @t)
::   ?.  =((lent key-position) (lent value-result))
::   ~|  %uneven-lengths  !!
::   |-
::   ?:  |(?=(~ key-position) ?=(~ value-result))
::   chart
::   $(chart (~(put by chart) i.key-position i.value-result), key-position t.key-position, value-result t.value-result)
:: ::  Cycle an alphabet around, e.g. from
:: ::  'ABCDEFGHIJKLMNOPQRSTUVWXYZ' to 'BCDEFGHIJKLMNOPQRSTUVWXYZA'
:: ::
:: ++  rotation
::   |=  [my-alphabet=tape my-steps=@ud]
::   =/  length=@ud  (lent my-alphabet)
::   =+  (trim (mod my-steps length) my-alphabet)
::   (weld q p)
:: --
:: question 3: produce all possible unshifted tapes
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
