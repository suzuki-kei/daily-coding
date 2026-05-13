module ListToRuns where

import Data.List (group)
import Data.List (unfoldr)

type Run a = [a]

listToRuns1 :: Eq a => [a] -> [Run a]
listToRuns1 = listToRuns
    where
        listToRuns [] = []
        listToRuns xs@(x : _) = run : listToRuns xs'
            where
                (run, xs') = span (== x) xs

listToRuns2 :: Eq a => [a] -> [Run a]
listToRuns2 = listToRuns
    where
        listToRuns xs = unfoldr step xs
            where
                step [] = Nothing
                step xs@(x : _) = Just $ span (== x) xs

listToRuns3 :: Eq a => [a] -> [Run a]
listToRuns3 = listToRuns
    where
        listToRuns = group

