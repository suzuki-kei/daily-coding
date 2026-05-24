module List where

transpose :: [[a]] -> [[a]]
transpose xss = transpose' heads tails
    where
        (heads, tails) = unzip [(x, xs) | x : xs <- xss]
        transpose' [] [] = []
        transpose' heads tails = heads : transpose tails

