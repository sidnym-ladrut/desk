:: hw7.hoon
::
:: solutions to %hw7 (hoon school 2022-2 cohort)
::
:: question 1: tape of hex color value to hex value
:: verbose solution:
:: :: |=  t=tape
:: :: ^-  @ux
:: :: :: verify structure of tape
:: :: ?>  &(=((snag 0 t) '#') =((lent t) 7))
:: :: :: construct hex value from lowercase tape
:: :: =.  t  (cass t)
:: :: =.  t  (slag 1 t)
:: :: =/  h=@ux  0x0
:: :: |-
:: :: ?~  t
:: ::   h
:: :: %=  $
:: ::   t  t.t
:: ::   h  %+  con
:: ::     (lsh [2 1] h)
:: ::     ?:  &((gte i.t '0') (lte i.t '9'))
:: ::       (sub i.t '0')
:: ::     ?:  &((gte i.t 'a') (lte i.t 'f'))
:: ::       (add 10 (sub i.t 'a'))
:: ::     !!
:: :: ==
:: :: terse solution:
:: |=  t=tape
:: ^-  @ux
:: ?>  &(=((snag 0 t) '#') =((lent t) 7))
:: =<  +>
:: %-  de:base16:mimes:html
:: (crip (slag 1 t))
:: question 2: rewriting the `+sub` arm
:: |=  [a=@ b=@]
:: |^  (sub a b)
:: ++  sub
::   |=  [a=@ b=@]
::   ^-  @
::   ?.  !=(0 b)  a
::   $(a (dec a), b (dec b))
:: --
:: question 3: role of the `@q` aura
:: `@q` directly translates bytes to Urbit's phonemic bases (e.g.
:: 65.536 is 0x1.0000, which is ~nec (0x01, suffix), ~doz (0x00,
:: prefix), ~zod (0x00, suffix)).
:: question 4: ?+ switch statement
:: |=  i=@tas
:: ^-  (unit @ud)
:: ?+  i  ~
::   %one    [~ 1]
::   %two    [~ 2]
::   %three  [~ 3]
::   %four   [~ 4]
::   %five   [~ 5]
:: ==
:: question 5: gate sample currying
:: (curr gth 10)
:: question 6: floating point reel/roll
:: cool (not working) answer:
:: (curr (bake roll ,[(list @rs) _=>(~ |=([@rs @rs] @rs))]) add:rs)
:: boring (working) answer:
|=  l=(list @rs)
^-  @rs
(roll l add:rs)
:: question 7: implement factorial w/ ;:
:: :(mul 1 2 3 4 5)
