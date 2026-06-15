module Oreno.Data.Zip where

zip :: [a] -> [b] -> [(a, b)]
zip (x : xs) (y : ys) = (x, y) : zip xs ys
zip _ _ = []

unzip :: [(a, b)] -> ([a], [b])
unzip [] = ([], [])
unzip (x, y) : pairs =
    let
        (xs, ys) = unzip pairs
    in
        (x : xs, y : ys)

