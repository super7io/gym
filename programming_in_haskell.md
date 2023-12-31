
<!--

programming_in_haskell.md

SPDX-FileCopyrightNotice: 2023 Alexander Murphy <super7@alexmurphy.io>
SPDX-License-Identifier: CC-BY-4.0

Some interesting tibits of code from Graham Hutton's Programming in Haskell 2nd ed.

-->

# Select Intrigues of [Programming in Haskell](http://www.cs.nott.ac.uk/~pszgmh/pih.html)

## Removing `=` in quicksort

A Haskell definition of quicksort is provided in the book:

```haskell
qsort :: Ord a => [a] -> [a]
qsort []     = []
qsort (x:xs) = qsort smaller ++ [x] ++ qsort larger
               where 
                 smaller = [a | a <- xs, a <= x]
                 larger  = [b | b <- xs, b >  x]
```

Given as an exercise for the reader is the folllwing question:

> What would be the effect of replacing `<=` by `<` in the original definition [above] of `qsort`?

This is particularly interesting as it fundamentally changes the behaviour of the sort, in that some numbers will be *removed* from the final list. This behaviour might be useful though, in finding the unique values of an ordered set. We could rename this unique-value quicksort as `uqsort`:

```haskell
uqsort :: Ord a => [a] -> [a]
uqsort []     = []
uqsort (x:xs) = uqsort smaller ++ [x] ++ uqsort larger
                where 
                  smaller = [a | a <- xs, a < x] -- omit `=`
                  larger  = [b | b <- xs, b > x]
```

We can view the behaviour in GHCi:

```haskell
l = [5,7,2,9,2,1,9,3]
qsort l
-- [1,2,2,3,5,7,9,9]
uqsort l
-- [1,2,3,5,7,9]
```

## Recursively merging two lists

Using the [5 step process](https://doi.org/10.1093/comjnl/43.4.252) for defining functions:

**Step 1:** A type is provided in the requirements.

```haskell
merge :: Ord a => [a] -> [a] -> [a]
```

**Step 2:** There are various cases due to multiple parameters.

```haskell
merge :: Ord a => [a] -> [a] -> [a]
merge []     []     = ?
merge (n:ns) []     = ?
merge [] (m:ms)     = ?
merge (n:ns) (m:ms) = ?
```

**Step 3:** Base cases are quite straight forward, as the arguments are pre-ordered.

```haskell
merge :: Ord a => [a] -> [a] -> [a]
merge []     []     = []
merge (n:ns) []     = (n:ns)
merge [] (m:ms)     = (m:ms)
merge (n:ns) (m:ms) = 
```

**Step 4:** Now for the trickier part, selecting the lowest $n$ or $m$ and recurring.

```haskell
merge :: Ord a => [a] -> [a] -> [a]
merge []     []     = []
merge (n:ns) []     = (n:ns)
merge [] (m:ms)     = (m:ms)
merge (n:ns) (m:ms) = if n <= m then n : merge ns (m:ms) else m : merge (n:ns) ms
```

**Step 5:** The class is already generalise, and the cases are fine, leave it there!

## Miscellanea

All copyrightable content is released under the Creative Commons By licence (version 4.0) unless otherwise specified in the source code.

Select content in this document may have been fairly copied here for convenience, non-commercial, and pedagogical purposes from Hutton's [Programming in Haskell](http://www.cs.nott.ac.uk/~pszgmh/pih.html).

