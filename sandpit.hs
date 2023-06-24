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

