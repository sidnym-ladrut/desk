:: advent of code 2021 day 12
:: https://adventofcode.com/2021/day/12
::
/*  puzzle-input  %txt  /lib/advent-2021/day12/txt

:-  %say
|=  *
=<
:-  %noun  (day12-solve-2 puzzle-input)

|%
+$  day12-graph  (map @tas (set @tas))
+$  day12-ntype  ?(%big %small)
::
++  day12-la2ty
  |=  l=@tas
  ^-  day12-ntype
  ?:  =(l `@tas`(crip (cuss (trip l))))
    %big
  ?:  =(l `@tas`(crip (cass (trip l))))
    %small
  !!
::
++  day12-gr
  |_  m=day12-graph
  ::
  ++  n1path
    |-
    ^-  @ud
    =/  vlst=(list @tas)  ~[%start]
    =/  vset=(set @tas)   ~
    %-  lent
    |-
    ^-  (list (list @tas))
    =+  ncur=?~(vlst !! i.vlst)
    =+  ntyp=(day12-la2ty ncur)
    ?:  =(ncur %end)
      ~[vlst]
    ?:  &((~(has in vset) ncur) =(ntyp %small))
      ~
    =.  vset  (~(put in vset) ncur)
    %+  roll  (nadjs ncur)
      |=  [n=@tas a=(list (list @tas))]
      ^-  (list (list @tas))
      (weld a ^$(vlst [n vlst]))
  ::
  ++  n2path
    :: FIXME: This is pretty sloppy, but integrating this implementation
    :: with `n1path` to remove duplicate code would be laborious, so
    :: leaving it for now.
    |-
    ^-  @ud
    =/  vlst=(list @tas)  ~[%start]
    =/  vset=(set @tas)   ~
    =/  vsm2=?            %.n
    %-  lent
    |-
    ^-  (list (list @tas))
    =+  ncur=?~(vlst !! i.vlst)
    =+  nsml=.=((day12-la2ty ncur) %small)
    =+  nvis=(~(has in vset) ncur)
    ?:  =(ncur %end)
      ~[vlst]
    ?:  &(nvis =(ncur %start))
      ~
    ?:  &(nvis nsml vsm2)
      ~
    =.  vsm2  ?:(|(vsm2 &(nvis nsml)) %.y %.n)
    =.  vset  (~(put in vset) ncur)
    %+  roll  (nadjs ncur)
      |=  [n=@tas a=(list (list @tas))]
      ^-  (list (list @tas))
      (weld a ^$(vlst [n vlst]))
  ::
  ++  nadjs
    |=  n=@tas
    ^-  (list @tas)
    ~(tap in (~(got by m) n))
  --
::
++  day12-parse
  :: given: a list of undirected cave graph edges "ABC-def", one per line
  :: return: a graph data structure representing the cave graph
  |=  input=wain   :: (list @t)
  ^-  day12-graph  :: (map @tas (set @tas))
  :: generate map cumulatively using (list [@tas @tas]) as graph edges
  %-  roll  :_
    |:  [n=*[@tas @tas] a=*day12-graph]
    ^-  day12-graph
    %+  roll  `(list [@tas @tas])`~[[-.n +.n] [+.n -.n]]  :: [src, dst]
      |:  [m=*[@tas @tas] b=a]
      ^-  day12-graph
      ?.  (~(has by b) -.m)
        (~(put by b) -.m (silt ~[+.m]))
      (~(jab by b) -.m |=(i=(set @tas) (~(put in i) +.m)))
    :: transform (list @t) into (list [@tas @tas]) of graph edges
    %+  turn  input
      |=  i=@t
      ^-  [@tas @tas]
      =-  [`@tas`(crip -.ipair) `@tas`(crip +.ipair)]
      ^=  ipair
        %+  rash  i
          ;~  (glue hep)
            (star alf)
            (star alf)
          ==
::
++  day12-solve-1
  :: given: a list of undirected cave graph edges "ABC-def", one per line
  :: return: the number of unique paths "start-end" with no small cave revisits
  |=  input=wain   :: (list @t)
  ^-  @ud
  =+  graph=(day12-parse input)
  ~(n1path day12-gr graph)
::
++  day12-solve-2
  :: given: a list of undirected cave graph edges "ABC-def", one per line
  :: return: the number of paths "start-end" with only 1 small cave revisit
  |=  input=wain   :: (list @t)
  ^-  @ud
  =+  graph=(day12-parse input)
  ~(n2path day12-gr graph)
--
