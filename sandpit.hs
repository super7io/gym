
-- factorial?
f n = product [1..n]
-- types? Integral n


--fixme!
g :: (Floating a, Ord a) => a -> a -> a
g a r
 | a <= -1.0 = 0.0
 | a >= 1.0 = 0.0
 | otherwise = (1-(a**(r+1))) / (1-a)

