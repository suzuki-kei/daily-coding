module RunLengthEncoding where

import Data.List (replicate)
import Data.List.NonEmpty ((<|))
import Data.List.NonEmpty (NonEmpty ((:|)))
import Data.List.NonEmpty (NonEmpty)

type Run a = NonEmpty a
type EncodedRun a = (a, Int)
type DecodedRun a = [a]

encode :: Eq a => [a] -> [EncodedRun a]
encode = map encodeRun . listToRuns

encodeRun :: Run a -> EncodedRun a
encodeRun run@(x :| _) = (x, length run)

listToRuns :: Eq a => [a] -> [Run a]
listToRuns [] = []
listToRuns (x : xs) = listToRuns' xs (x :| []) []
    where
        listToRuns' [] run runs = reverse (run : runs)
        listToRuns' (x : xs) run@(runHead :| runTail) runs
            | x == runHead = listToRuns' xs (x <| run) runs
            | otherwise    = listToRuns' xs (x :| []) (run : runs)

decode :: [EncodedRun a] -> [a]
decode = runsToList . map decodeRun

decodeRun :: EncodedRun a -> DecodedRun a
decodeRun (x, n) = replicate n x

runsToList :: [DecodedRun a] -> [a]
runsToList runs = foldl (++) [] runs

