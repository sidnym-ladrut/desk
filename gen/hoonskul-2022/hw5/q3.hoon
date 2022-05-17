:: hw5/q3.hoon
:: solutions to %hw5 q3 (hoon school 2022-2 cohort)
:-  %say
|=  *
:-  %noun
:: NOTE: Evaluating within a `%say` generator produces a very different
:: result than does running the following on the `dojo` command line.
-:|=(a=@ud (add 1 a))
