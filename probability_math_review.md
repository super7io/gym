
<!--

probability_math_review.md

SPDX-FileCopyrightNotice: 2023 Alexander Murphy <super7@alexmurphy.io>
SPDX-License-Identifier: CC-BY-4.0
SPDX-License-Identifier: CC-BY-NC-SA-4.0

The "Math Review" section of Ward & Gundlach's (2016) book, implemented in Haskell.

-->

# Pre-probability math review

## Geometric Sums

> For $-1\lt a\lt1$, recall these two finite summations of geometric terms,
> 
> $1+a+a^2+a^3+...+a^r=\sum^{r}_{j=0}a^j=\frac{1-a^{r+1}}{1-a}$
> 
> and
>
> $a+a^2+a^3+a^4+...+a^r=\sum^{r}_{j=1}a^j=\frac{a-a^{r+1}}{1-a}$. 
>
> For $-1\lt$ $a\lt1$, these yield two infinite summations of geometric terms,
>
> $1+a+a^2+a^3+...=\sum^{\inf}_{j=0}a^j=\frac{1}{1-a}$ 
>
> $a+a^2+a^3+a^4...=\sum^{\inf}_{j=1}a^j=\frac{a}{1-a}$ 

These can be easily implemented in Haskell, it requires floating point exponentiation (`**`). For a given $a$ and $r$:

```haskell
g1 :: (Floating a, Ord a) => a -> a -> a
g1 a r
 | a <= -1.0 = 0.0
 | a >= 1.0 = 0.0
 | otherwise = (1-(a**(r+1))) / (1-a)
```

```haskell
g :: (Floating a, Ord a) => a -> a -> a
g a r
 | a <= -1.0 = 0.0
 | a >= 1.0 = 0.0
 | otherwise = (a-(a**(r+1))) / (1-a)
```

The infinte sums are even more straightforward.

```haskell
g1f :: (Floating a) => a -> a
g1f a = 1 / (1-a)
```

```haskell
gf :: (Floating a) => a -> a
gf a = a / (1-a)
```

## Exponential function

> For any real-valued $x$, the power series definition of the exponential function evaluated at $x$ is
>
> $e^x=\sum^{\inf}_{n=0}\frac{x^n}{n!}$, 
>
> where 
>
> $n! := (1)(2)...(n)$.

Defining the factorial function is a prerequisite:

```haskell
factorial :: (Integral n) => n -> n
factorial n = product [1..n]

map factorial [1..6]
-- [1,2,6,24,120,720]
```

And we need Euler's number (approximately):

```haskell
e = 2.71828
```

Then to evaluate $e$ to the $x$:

```haskell
exp x = product $ take x (repeat e)
```

But the power series is not this! We could get an arbitrarily accurate result using the series instead of our truncated value for e.

```haskell
-- tbc
```

## Sum of Integers, Sum of Squares

TBC...

## Miscellanea

All copyrightable content is released under the Creative Commons By licence, v4.0, unless otherwise specified in the source code.

Above, there may be fairly copied copyrightable material reproduced for non-commercial and pedagogical purposes. The source of this material was:

> Ward & Gundlach (2016) Introduction to Probability. Macmillan Learning. ISBN: 9780716771098

[Link to exact book](https://www.macmillanlearning.com/ed/uk/product/Introduction-to-Probability-1st-edition/p/0716771098).
