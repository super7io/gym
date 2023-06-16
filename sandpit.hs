
--fixme!
g :: (Integral a) => a -> a -> a
g a r
 | a <= -1.0 = 0.0
 | a >= 1.0 = 0.0
 | otherwise = (1-a**(r+1)) / (1-a)

