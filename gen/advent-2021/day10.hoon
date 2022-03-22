:: advent of code 2021 day 10
:: https://adventofcode.com/2021/day/10
::
/*  puzzle-input  %txt  /lib/advent-2021/day10/txt

:-  %say
|=  *
=<
:-  %noun  (day10-solve-2 puzzle-input)

|%
+$  day10-cchar  ?(%pal %par %kel %ker %sel %ser %gal %gar %nul)
+$  day10-cpair  [day10-cchar day10-cchar]
+$  day10-chunk  (list day10-cpair)
::
++  day10-head
  |*  a=(list *)
  ?~  a  !!
  i.a
::
++  day10-ctype
  |=  i=day10-cchar
  ^-  @tas
  (crip (scag 2 (trip i)))
++  day10-cpnul
  |=  i=day10-cpair
  ^-  bean
  =(+.i %nul)
++  day10-cpbad
  |=  i=day10-cpair
  ^-  bean
  ?&
    ?!  (day10-cpnul i)
    ?!  =((day10-ctype -.i) (day10-ctype +.i))
  ==
::
++  day10-ch
  |_  l=day10-chunk
  :: the value of the first illegal character in a corrupt line
  ++  sscore
    |-
    ^-  @ud
    ?:  ?!  corrupt
      0
    =+  fpbad=(day10-head (skim l day10-cpbad))
    ?+  +.fpbad  0
      %par  3
      %ser  57
      %ker  1.197
      %gar  25.137
    ==
  :: the value of the autocomplete sequence in an uncorrupted line
  ++  ascore
    |-
    ^-  @ud
    ?:  corrupt
      0
    %+  roll  (flop (skim l day10-cpnul))
      |=  [n=day10-cpair a=@ud]
      ^-  @ud
      %+  add  (mul 5 a)
        ?+  (day10-ctype -.n)  0
          %pa  1
          %se  2
          %ke  3
          %ga  4
        ==
  :: chunk with 1+ incorrect pairings (e.g. <})?
  ++  corrupt
    |-
    ^-  bean
    (lien l day10-cpbad)
  --
::
++  day10-parse
  :: given: a list of tapes containing matched characters (e.g. (){}[])
  :: return: a list of chunks (one per tape) with parsed results in order
  |=  input=wain   :: (list @t)
  ^-  (list day10-chunk)
  %+  turn  input
    :: FIXME: this is a pretty messy and should be cleaned up if possible
    |=  input=@t
    ^-  day10-chunk
    %+  rash  input
      |-  :: NOTE: the cast isn't allowed; why? ^-  day10-chunk
      ;~  (comp |=([a=day10-chunk b=day10-chunk] (weld a b)))
        ;~  (comp |=([a=[day10-cchar day10-chunk] b=day10-cchar] [[-.a b] +.a]))
          ;~  plug
            ;~  pose
              (cold %pal pal)
              (cold %sel sel)
              (cold %kel kel)
              (cold %gal gal)
            ==
            ;~  pose
              (knee *day10-chunk |.(^$))
              (easy ~)
            ==
          ==
          ;~  pose
            (cold %par par)
            (cold %ser ser)
            (cold %ker ker)
            (cold %gar gar)
            (easy %nul)
          ==
        ==
        ;~  pose
          (knee *day10-chunk |.(^$))
          (easy ~)
        ==
      ==
::
++  day10-solve-1
  :: given: a list of tapes containing matched characters (e.g. (){}[])
  :: return: the sum total "syntax score" of all "corrupted" tapes
  ::   - corrupted: 1+ incorrect pairings (open doesn't match close, e.g. {>)
  ::   - syntax score: the score of the first illegal character in a
  ::     corrupted line, with the following values
  |=  input=wain   :: (list @t)
  ^-  @ud
  =+  chnks=(day10-parse input)
  %+  roll  chnks
    |:([n=*day10-chunk a=0] (add a ~(sscore day10-ch n)))
::
++  day10-solve-2
  :: given: a list of tapes containing matched characters (e.g. (){}[])
  :: return: the middle "autocomplete score" of all uncorrupted tapes
  ::   - uncorrupted: 0 incorrect pairings (all opens match closes, e.g. ())
  ::   - autocomplete score: the score of the ordered autocomplete
  ::     characters for a chunk
  |=  input=wain   :: (list @t)
  ^-  @ud
  =+  chnks=(day10-parse input)
  =+  ichnk=(skim chnks |=(c=day10-chunk !~(corrupt day10-ch c)))
  =+  ochnk=(sort (turn ichnk |=(c=day10-chunk ~(ascore day10-ch c))) lth)
  (snag (div (lent ochnk) 2) ochnk)
--
