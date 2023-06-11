
<!--

project_euler_q1.md

SPDX-FileCopyrightNotice: 2023 Alexander Murphy <super7@alexmurphy.io>
SPDX-License-Identifier: CC-BY-4.0
SPDX-License-Identifier: CC-BY-NC-SA-4.0

A brief note on my solution to the question.

-->

# A reasonable solution to PE question 1

## Problem Statement

> If we list all the natural numbers below $10$ that are multiples of $3$ or $5$, we get $3$, $5$, $6$ and $9$. The sum of these multiples is $23$.
> 
> Find the sum of all the multiples of $3$ or $5$ below $1000$.



## Analysis

A straightforward problem using a filter and a fold. A single pass list comprehension could be used, resulting in a time and memory complexity of $O(n)$.

## Solution

```haskell
foldl (+) 0 [n | n <- (take 999 [1,2..]), n `mod` 3 == 0 || n `mod` 5 == 0]
```

## Discussion

At first I thought the time complexity would be worse than $O(n)$ as there is a second list to traverse. But as the inital list gets larger, the limit of the ratio of primes goes to zero. So it doesn't change the complexity!

There is likely a more efficient solution that doesn't utilise a second list. 

## Miscellanea

All copyrightable content is released under the Creative Commons By licence, v4.0, unless otherwise specified in the source code.

The problem statement is from [Project Euler](https://projecteuler.net/problem=1) used under licence (CC-BY-NC-SA-4.0).
