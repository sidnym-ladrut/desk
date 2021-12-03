::  bank.hoon
::
::  Bank example from Hoon School 1.8.1
:-  %say
|=  *
:-  %noun
=<

=~
new-account
(deposit 100)
(deposit 100)
(withdraw 50)
balance
==

|%
++  new-account
  :: TODO: how to default initialize 'balance'?
  |_  balance=@ud
  ++  deposit
    |=  amount=@ud
    +>.$(balance (add balance amount))
  ++  withdraw
    |=  amount=@ud
    +>.$(balance (sub balance amount))
  --
--
