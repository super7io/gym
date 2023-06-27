
-- sandpit.hs
--
-- SPDX-FileCopyrightNotice: 2023 Alexander Murphy <super7@alexmurphy.io>
-- SPDX-License-Identifier: CC0-1.0
--
-- A sandpit. For building sandcastles, obviously.

-- iteratively developing merge as it's tricky
merge :: Ord a => [a] -> [a] -> [a]
merge []     []     = []
merge (n:ns) []     = (n:ns)
merge [] (m:ms)     = (m:ms)
merge (n:ns) (m:ms) = if n > m
                         then merge (ns ++ [m,n]) ms
                         else merge ns ([m]++ms++[n])

-- pythagoreans
pyths :: Int -> [(Int,Int,Int)]
pyths n = [(x,y,z) | x <- [1..n], y <- [1..n], z <- [1..n], x^2+y^2 == z^2]


-- co-ordinate grid notes
grid :: Int -> Int -> [(Int,Int)]
grid a b = [(x,y) | x <- [0..a], y <- [0..b]]

square :: Int -> [(Int,Int)]
square n = [(x,y) | (x,y) <- grid n n, x /= y]


-- quicksort implementation
qsort :: Ord a => [a] -> [a]
qsort []     = []
qsort (x:xs) = qsort smaller ++ [x] ++ qsort larger
               where
                 smaller = [a | a <- xs, a <= x]
                 larger  = [b | b <- xs, b >  x]

uqsort :: Ord a => [a] -> [a]
uqsort []     = []
uqsort (x:xs) = uqsort smaller ++ [x] ++ uqsort larger
               where
                 smaller = [a | a <- xs, a < x] -- omit `=`
                 larger  = [b | b <- xs, b > x]

-- factorial?
f n = product [1..n]
-- types? Integral n


--fixme!
g :: (Floating a, Ord a) => a -> a -> a
g a r
 | a <= -1.0 = 0.0
 | a >= 1.0 = 0.0
 | otherwise = (1-(a**(r+1))) / (1-a)

