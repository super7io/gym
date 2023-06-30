
{-

countdown.hs

SPDX-FileCopyrightNotice: 2023 Alexander Murphy <super7@alexmurphy.io>
SPDX-License-Identifier: CC-BY-4.0

Solving the "countdown" problem as described in Graham Hutton's Programming in Haskell 2nd ed.

All copyrightable content is released under the Creative Commons By licence (version 4.0) unless otherwise specified in the source code.

Select content in this file may have been fairly copied for convenience, non-commercial, and pedagogical purposes from Hutton's Programming in Haskell (http://www.cs.nott.ac.uk/~pszgmh/)

-}

main :: IO ()
main = print (solutions' [1,3,7,10,25,50] 765)

data Op = Add | Sub | Mul | Div

instance Show Op where
  show Add = "+"
  show Sub = "-"
  show Mul = "*"
  show Div = "/"

-- unoptimized checks
-- valid :: Op -> Int -> Int -> Bool
-- valid Add _ _ = True
-- valid Mul _ _ = True
-- valid Sub x y = x > y
-- valid Div x y = x `mod` y == 0

valid' :: Op -> Int -> Int -> Bool
valid' Add x y = x <= y
valid' Mul x y = x /= 1 && y /= 1 && x <= y
valid' Sub x y = x > y
valid' Div x y = y /= 1 && x `mod` y == 0

apply :: Op -> Int -> Int -> Int
apply Add x y = x + y
apply Mul x y = x * y
apply Sub x y = x - y
apply Div x y = x `div` y

data Expr = Val Int | App Op Expr Expr

instance Show Expr where
  show (Val n)     = show n
  show (App o l r) = brak l ++ show o ++ brak r
                     where
                         brak (Val n) = show n
                         brak e       = "(" ++ show e ++ ")"

values :: Expr -> [Int]
values (Val n)     = [n]
values (App _ l r) = values l ++ values r

eval :: Expr -> [Int]
eval (Val n)     = [n | n > 0]
eval (App o l r) = [apply o x y | x <- eval l,
                                  y <- eval r,
                                  valid' o x y]

subs :: [a] -> [[a]]
subs []     = [[]]
subs (x:xs) = yss ++ map (x:) yss
              where yss = subs xs

interleave :: a -> [a] -> [[a]]
interleave x []     = [[x]]
interleave x (y:ys) = (x:y:ys) : map (y:) (interleave x ys)

perms :: [a] -> [[a]]
perms []     = [[]]
perms (x:xs) = concat (map (interleave x) (perms xs))

choices :: [a] -> [[a]]
choices = concat . map perms . subs

split :: [a] -> [([a],[a])]
split []     = []
split [_]    = []
split (x:xs) = ([x],xs) : [(x:ls,rs) | (ls,rs) <- split xs]

-- exprs :: [Int] -> [Expr]
-- exprs []  = []
-- exprs [n] = [Val n]
-- exprs ns  = [e | (ls,rs) <- split ns,
--                  l       <- exprs ls,
--                  r       <- exprs rs,
--                  e       <- combine l r]
--
-- combine :: Expr -> Expr -> [Expr]
-- combine l r = [App o l r | o <- ops]
--
--
-- unoptimized original
-- solutions :: [Int] -> Int -> [Expr]
-- solutions ns n = [e | ns' <- choices ns, e <- exprs ns', eval e == [n]]

ops :: [Op]
ops = [Add,Sub,Mul,Div]

type Result = (Expr,Int)

results :: [Int] -> [Result]
results []  = []
results [n] = [(Val n,n) | n > 0]
results ns  = [res | (ls,rs) <- split ns,
                     lx      <- results ls,
                     ry      <- results rs,
                     res     <- combine' lx ry]

combine' :: Result -> Result -> [Result]
combine' (l,x) (r,y) = [(App o l r, apply o x y) | o <- ops, valid' o x y]

solutions' :: [Int] -> Int -> [Expr]
solutions' ns n = [e | ns' <- choices ns, (e,m) <- results ns', m == n]

