:: advent of code 2021 day 15
:: https://adventofcode.com/2021/day/15
::
/*  puzzle-input  %txt  /lib/advent-2021/day15/txt

:-  %say
|=  *
=<
:-  %noun  (day15-solve-2 puzzle-input)

|%
+$  day15-matrix  [(list @ud) @ud @ud]
::
++  day15-fidx  :: find first index
  |*  [a=(list) b=$-(* ?)]
  ^-  (unit @ud)
  =>  .(a ^.(homo a))
  =+  i=0
  |-
  ?~  a  ~
  ?:  (b i.a)  [~ i]
  $(i +(i), a t.a)
::
++  day15-zipp  :: zip two lists together
  |*  [a=(list *) b=(list *)]
  ?~  a  ~
  ?~  b  ~
  [[i.a i.b] $(a t.a, b t.b)]
::
++  day15-pile  :: list to priority queue
  |*  a=(list (pair))
  =>  .(a ^.(homo a))
  =*  t  _?>(?=(^ a) i.a)
  :: TODO: Could use heapify operations for O(n) solution.
  %+  sort  a
  |=([a=t b=t] (lth +.a +.b))
::
++  day15-pq
  =|  a=(list (pair))                            :: heap; [value priority]
  =*  node  _?>(?=(^ a) i.a)
  =*  valu  _?>(?=(^ a) -.i.a)
  =*  prio  _?>(?=(^ a) +.i.a)
  |@
  ::
  ++  apt                                        :: verify correctness
    |-
    ^-  ?
    =+  s=(lent a)
    =+  i=0
    |-
    ?:  (gte i s)  &
    =+  il=(add (mul 2 i) 1)
    =+  ir=(add (mul 2 i) 2)
    ?&
      ?:((gte il s) & ?&((lte +:(snag i a) +:(snag il a)) $(i il)))
      ?:((gte ir s) & ?&((lte +:(snag i a) +:(snag ir a)) $(i ir)))
    ==
  ::
  ++  put                                        :: insert new pair
    |*  [v=* p=*]
    ^+  a
    =.  a  (snoc a [v p])
    (hup (sub (lent a) 1))
  ::
  ++  jab                                        :: modify existing pair
    :: TODO: The fact that this runs in O(n) kills all possibility for
    :: performance gain over a raw set. Make this O(logn) by introducing
    :: an auxiliary dictionary that keeps track of node addresses for
    :: particular values (i.e. (map valu @ud)) and update all functions
    :: to properly account for this auxiliary data structure.
    |*  [v=* p=*]
    ^+  a
    =+  vi=(day15-fidx a |=(i=node =(-.i v)))
    ?@  vi  (put v p)
    =+  q=+:(snag u.vi a)
    ?:  =(p q)  a
    =.  a  (snap a u.vi [v p])
    ?:  (lth p q)  (hup u.vi)
    (hdn u.vi)
  ::
  ++  pop                                        :: remove priority item
    |-
    ^-  [node _a]
    =+  l=(lent a)
    ?:  =(l 0)  !!
    :-  (snag 0 a)
    ?:  =(l 1)  ~
    =.  a  [(rear (slag 1 a)) (snip (slag 1 a))]
    (hdn 0)
  ::
  ++  top                                        :: peek priority item
    |-
    ^-  node
    (snag 0 a)
  ::
  ++  emt                                        :: emptiness check
    |-
    ^-  ?
    =(a ~)
  ::
  ++  val                                        :: list of values
    |-
    ^-  (list valu)
    =|  b=(list valu)
    |-
    ?~  a
      (flop b)
    $(a t.a, b [-.i.a b])
  ::
  ++  hup                                        :: heapify up
    |=  i=@ud
    ^+  a
    =+  =<([vi=- pi=+] (snag i a))
    |-
    ?:  =(i 0)  a
    =+  j=(div (sub i 1) 2)
    =+  =<([vj=- pj=+] (snag j a))
    ?:  (gth pi pj)  a
    $(i j, a (snap (snap a j [vi pi]) i [vj pj]))
  ::
  ++  hdn                                        :: heapify down
    |=  i=@ud
    ^+  a
    =+  n=(snag i a)
    =+  s=(lent a)
    |-
    ?:  (gte i s)  a
    =+  il=(add (mul 2 i) 1)
    =+  l=?:((gte il s) n (snag il a))
    =+  ir=(add (mul 2 i) 2)
    =+  r=?:((gte ir s) n (snag ir a))
    =-  ?:((lte +.n +.m) a $(i j, a (snap (snap a j n) i m)))
    =<  [j=- m=+]
    %+  roll  (limo ~[[il l] [ir r]])
    |:  [[ii=*@ud in=*node] ji=s jn=n]
    ?:((gte +.in +.jn) [ji jn] [ii in])
  --
::
++  day15-mx
  |_  [l=(list @ud) w=@ud h=@ud]
  ::
  ++  path
    |-
    ^-  @ud
    :: implementation of dijkstra's algorithm, from here:
    :: https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm#Pseudocode
    =/  nlst=(list @ud)     (gulf 0 (sub (mul w h) 1))
    =/  vted=(set @ud)      (silt nlst)
    =/  dist=(map @ud @ud)  (malt (turn nlst |=(i=@ud [i ?:(=(i 0) 0 ~(out fe 5))])))
    =/  prev=(map @ud @ud)  (malt (turn nlst |=(i=@ud [i ?:(=(i 0) 0 (mul w h))])))
    =-  (~(got by -<:.) (rear nlst))
    |-
    ^+  [dist prev]
    ?:  =(~(wyt in vted) 0)
      [dist prev]
    =+  ^=  u  :: unvisited tile with lowest distance rating
      =-  -<:.
      %-  ~(rep in vted)
      |:  [n=0 an=0 av=~(out fe 5)]
      =+  v=(~(got by dist) n)
      ?:((lth v av) [n v] [an av])
    =.  vted  (~(del in vted) u)
    =-  $(dist -<:., prev ->:.)
    %+  roll  ~(tap in (~(int in vted) (silt (ajid u))))
    |:  [v=0 ad=dist ap=prev]
    =+  alt=(add (~(got by ad) u) (snag v l))
    ?.  (lth alt (~(got by ad) v))
      [ad ap]
    [(~(jab by ad) v |=(i=@ud alt)) (~(jab by ap) v |=(i=@ud u))]
  ::
  ++  path-2
    |-
    :: implementation of dijkstra's algorithm, from here:
    :: https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm#Pseudocode
    ^-  @ud
    =/  nlst=(list @ud)     (gulf 0 (sub (mul w h) 1))
    =/  dist=(map @ud @ud)  (malt (turn nlst |=(i=@ud [i ?:(=(i 0) 0 ~(out fe 5))])))
    =/  prev=(map @ud @ud)  (malt (turn nlst |=(i=@ud [i ?:(=(i 0) 0 (mul w h))])))
    =+  vted=(day15-pile (turn nlst |=(i=@ud [i (~(got by dist) i)])))
    =-  (~(got by -<:.) (rear nlst))
    |-
    ^+  [dist prev vted]
    ?:  ~(emt day15-pq vted)
      [dist prev vted]
    =^  uu  vted  ~(pop day15-pq vted)
    =+  u=-.uu
    =-  $(dist -<:., prev ->-:., vted ->+:.)
    %-  roll
    :-  ~(tap in (~(int in (silt ~(val day15-pq vted))) (silt (ajid u))))
    |:  [v=0 ad=dist ap=prev av=vted]
    =+  alt=(add (~(got by ad) u) (snag v l))
    ?.  (lth alt (~(got by ad) v))
      [ad ap av]
    [(~(jab by ad) v |=(i=@ud alt)) (~(jab by ap) v |=(i=@ud u)) (~(jab day15-pq av) [v alt])]
  ::
  ++  zoom
    |=  [zw=@ud zh=@ud]
    ^-  day15-matrix
    :_  [(mul zw w) (mul zh h)]
    %+  roll
      %+  turn  (gulf 0 (sub zh 1))
        |=  y=@ud
        %+  turn  (gulf 0 (sub zw 1))
        |=  x=@ud
        =+  nl=(turn l |=(v=@ud =+(w=(add v (add x y)) (add (div w 10) (mod w 10)))))
        =|  il=(list (list @ud))
        |-
        ^+  il
        ?:  =((lent nl) 0)  (flop il)
        $(nl (slag w nl), il [(scag w nl) il])
      |=  [nl=(list (list (list @ud))) al=(list @ud)]
        %+  weld  al
        ^-  (list @ud)
        %-  zing
        %+  roll  nl
        |=  [n=(list (list @ud)) a=(list (list @ud))]
        ?~  a  n
        (turn (day15-zipp a n) weld)
  ::
  ++  draw
    |-
    ^-  (list @t)
    =|  d=(list (list @tD))
    |-
    ?~  l  (turn (flop d) crip)
    %=  $
      l  (slag w `$?(~ _l)`l)
      d  :_  d
        %+  roll  (scag w `$?(~ _l)`l)
        |=([n=@ud a=(list @tD)] (weld a ~(rend co %$ %ud n)))
    ==
  ::
  ++  ajxy
    |=  [x=@ud y=@ud]
    ^-  (list [@ud @ud])
    %-  turn
    :_  |=([ix=@sd iy=@sd] [+:(old:si ix) +:(old:si iy)])
    %-  skim
    :_  okxy
    =+  [sx=(sun:si x) sy=(sun:si y)]
    ^-  (list [@sd @sd])  :~
      :-  (sum:si sx --1)  (sum:si sy --0)  :: (x+1,y+0)
      :-  (sum:si sx -1)   (sum:si sy --0)  :: (x-1,y+0)
      :-  (sum:si sx --0)  (sum:si sy --1)  :: (x+0,y+1)
      :-  (sum:si sx --0)  (sum:si sy -1)   :: (x+0,y-1)
    ==
  ::
  ++  ajid
    |=  i=@ud
    ^-  (list @ud)
    %-  turn
    :_  xyid
    (ajxy (idxy i))
  ::
  ++  okxy
    |=  [x=@sd y=@sd]
    ^-  ?
    ?&
      -:(old:si (cmp:si x --0))            :: x >= 0
      -:(old:si (cmp:si y --0))            :: y >= 0
      =((cmp:si x (sun:si w)) -1)          :: x < w
      =((cmp:si y (sun:si h)) -1)          :: x < h
    ==
  ::
  ++  okid
    |=  i=@sd
    ^-  ?
    ?&
      -:(old:si (cmp:si i --0))            :: i >= 0
      =((cmp:si i (sun:si (mul w h))) -1)  :: i < w*h
    ==
  ::
  ++  xyid
    |=  [x=@ud y=@ud]
    ^-  @ud
    (add x (mul y w))
  ++  idxy
    |=  i=@ud
    ^-  [@ud @ud]
    :-  (mod i w)
    (div i w)
  --
::
++  day15-parse
  :: given: a list of cords representing rows in a risk value matrix
  :: return: a matrix of @ud values representing the risk value matrix
  |=  input=(list @t)
  ^-  day15-matrix
  =+  rawin=(turn input |=(t=@t (rash t (star dit))))
  ?~  rawin
    !!
  [(zing rawin) (lent i.rawin) (lent rawin)]
::
++  day15-solve-1
  :: given: a list of cords representing rows in a risk value matrix
  :: return: the lowest risk path from the matrix's top-left to bot-rite
  |=  input=(list @t)
  ^-  @ud
  =+  imatx=(day15-parse input)
  ~(path day15-mx imatx)
::
++  day15-solve-2
  :: given: a list of cords representing rows in a risk value matrix
  :: return: the lowest risk path from the supermatrix's (5x5 version
  ::   of the original with modifications per supertile) top-left to bot-rite
  |=  input=(list @t)
  ^-  @ud
  :: NOTE: This does run to completion with the correct answer, but it
  :: takes about ~3 days to do so on a single ~2 GHz core.
  =+  imatx=(day15-parse input)
  =.  imatx  (~(zoom day15-mx imatx) 5 5)
  ~(path day15-mx imatx)
--
