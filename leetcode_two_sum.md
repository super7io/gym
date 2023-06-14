
<!--

leetcode_two_sum.md

SPDX-FileCopyrightNotice: 2023 Alexander Murphy <super7@alexmurphy.io>
SPDX-License-Identifier: CC-BY-4.0
SPDX-License-Identifier: CC-BY-NC-SA-4.0

Leetcode's infamous "two sum" in a functional style.

-->

# Functional Two Sum

## Problem Statement

> Given an array of integers *nums* and an integer *target*, return indices of the two numbers such that they add up to target.
> 
> You may assume that each input would have exactly one solution, and you may not use the same element twice.
> 
> You can return the answer in any order.

## Analysis

An awful question (manipulating indexes is a job for a compiler). A hashmap may also work for this granting $O(1)$ complexity. But let's attempt to use lists only, and base-Haskell rather than the `array` or `vector` packages.

Haskell lists don't have an "index" so we'll need to add one, perhaps by using `zip`. Subtracting the target number from the list will leave the remainder - we are informed from the problem statement that there is guaranteed to be only one solution so the sum of the corresponding solution elements will equal the *target*.

## Solution

```haskell
-- test data
n = 9
l = [1,5,6,12,23,19,3]

-- solution
k = map ((-) n) l
f x = elem x k
z = zip [0..] $ map f l
[fst x | x <- z, snd x == True]
```

## Discussion

While not neatly wrapped into a function (the above solution more closely resembles an interactive script, which makes sense, as GHCi was used to wrangle it) the above solution works.

LeetCode is renowned for creating many edge cases, so I'll be curious to try and find an $l$ or an $n$ for which the above code provides an incorrect solution.

## Miscellanea

All copyrightable content is released under the Creative Commons By licence, v4.0, unless otherwise specified in the source code.

The problem statement is publicly viewable on [LeetCode](https://leetcode.com/problems/two-sum), fairly copied here for convenience, non-commercial, and pedagogical purposes.
