module Lps where

prefixes ::
    [a] -> [[a]]
prefixes xs =
    prefixes' xs [] []
        where
            prefixes' [] prefix prefixes =
                reverse $ map reverse (prefix : prefixes)
            prefixes' (x : xs) prefix prefixes =
                prefixes' xs (x : prefix) (prefix : prefixes)

properPrefixes ::
    [a] -> [[a]]
properPrefixes xs =
    properPrefixes' xs [] []
        where
            properPrefixes' [] prefix prefixes =
                reverse $ map reverse prefixes
            properPrefixes' (x : xs) prefix prefixes =
                properPrefixes' xs (x : prefix) (prefix : prefixes)

suffixes ::
    [a] -> [[a]]
suffixes xs =
    suffixes' xs []
        where
            suffixes' xs@[] suffixes =
                (xs : suffixes)
            suffixes' xs@(x : xs') suffixes =
                suffixes' xs' (xs : suffixes)

properSuffixes ::
    [a] -> [[a]]
properSuffixes [] =
    []
properSuffixes xs@(x : xs')  =
    suffixes xs'

lps ::
    Eq a => [a] -> [a]
lps xs =
    foldl longer [] $ intersection (properPrefixes xs) (properSuffixes xs)

longer ::
    [a] -> [a] -> [a]
longer xs ys
    | length xs > length ys = xs
    | otherwise             = ys

intersection ::
    Eq a => [a] -> [a] -> [a]
intersection xs ys =
    filter (\x -> x `elem` ys) xs

lpsArray ::
    Eq a => [a] -> [Int]
lpsArray [] =
    []
lpsArray xs =
    let
        (prefix : prefixes') = prefixes xs
    in
        map (length . lps) prefixes'

