{-# LANGUAGE NoImplicitPrelude #-}

module Oreno.Data.List where

import Data.Bool
import Data.Eq
import Data.Int
import Data.Maybe
import Data.Ord
import Prelude ((-))
import Prelude ((+))
import Prelude (($))
import Prelude (concat)
import Prelude (unzip)

infixr 5 ++
(++) :: [a] -> [a] -> [a]
(++) [] ys = ys
(++) (x : xs) ys = x : (xs ++ ys)

head :: [a] -> a
head (x : _) = x

last :: [a] -> a
last (x : []) = x
last xs@(_ : _ : _) = last $ tail xs

tail :: [a] -> [a]
tail (x : xs) = xs

init :: [a] -> [a]
init (x : []) = []
init (x : xs) = x : init xs

uncons :: [a] -> Maybe (a, [a])
uncons [] = Nothing
uncons (x : xs) = Just (x, xs)

unsnoc :: [a] -> Maybe ([a], a)
unsnoc [] = Nothing
unsnoc xs = Just (init xs, last xs)

singleton :: a -> [a]
singleton x = [x]

null :: [a] -> Bool
null [] = True
null xs = False

length :: [a] -> Int
length [] = 0
length (x : xs) = 1 + (length xs)

compareLength :: [a] -> Int -> Ordering
compareLength xs n
    | n < 0     = GT
    | otherwise = compareLength' xs n
    where
        compareLength' [] 0 = EQ
        compareLength' [] n = LT
        compareLength' (x : xs) 0 = GT
        compareLength' (x : xs) n = compareLength' xs (n - 1)

map :: (a -> b) -> [a] -> [b]
map f [] = []
map f (x : xs) = f x : map f xs

reverse :: [a] -> [a]
reverse xs = reverse' xs []
    where
        reverse' [] reversed = reversed
        reverse' (x : xs) reversed = reverse' xs (x : reversed)

intersperse :: a -> [a] -> [a]
intersperse separator [] = []
intersperse separator (x : xs) = x : intersperse' separator xs
    where
        intersperse' separator [] = []
        intersperse' separator (x : xs) = separator : x : intersperse' separator xs

intercalate :: [a] -> [[a]] -> [a]
intercalate separator xss = concat $ intersperse separator xss

transpose :: [[a]] -> [[a]]
transpose xss = transpose' heads tails
    where
        (heads, tails) = unzip [(x, xs) | x : xs <- xss]
        transpose' [] [] = []
        transpose' heads tails = heads : transpose tails

