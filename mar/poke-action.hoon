:: NOTE: While this mark is trivially simple, it is necessary to
:: properly encode/decode data sent across Ames. Ames will send all data
:: as nouns, so a cage with a mark will enable this data to be properly
:: decoded on the remote end of a poke/subscribe.
/-  poke
|_  =action:poke
++  grab
  |%
  ++  noun  action:poke
  --
++  grow
  |%
  ++  noun  action
  --
++  grad  %noun
--
