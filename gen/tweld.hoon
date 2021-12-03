:: tweld
::
:: W(L1, L2) = L1 + L2
::

|=  l=[(list @) (list @)]
=/  lf=(list @)  ~
=/  la=(list @)  -:l
=/  lb=(list @)  +:l
|-
^-  (list @)
?~  la
  ?~  lb
    (flop lf)
  :: FIXME: Issue is that types are wrong for list; the list
  :: type is defined as [@ (list @)], but we need to append, but
  :: this turns the typing into [(list @) @].
  $(l [~ t.lb], lf [i.lb lf], la ~, lb t.lb)
$(l [t.la lb], lf [i.la lf], la t.la, lb lb)
