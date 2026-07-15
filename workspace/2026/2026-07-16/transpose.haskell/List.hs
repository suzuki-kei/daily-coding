module List where

transpose :: [[a]] -> [[a]]
transpose xss =
    let
        (heads, tails) = unzip [(x, xs) | x : xs <- xss]
    in
        transpose' heads tails
    where
        transpose' [] [] = []
        transpose' heads tails = heads : transpose tails

