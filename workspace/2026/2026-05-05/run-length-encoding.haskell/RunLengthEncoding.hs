module RunLengthEncoding where

import Data.List (replicate)
import Data.List (unfoldr)
import Data.List.NonEmpty (NonEmpty ((:|)))
import Data.List.NonEmpty (NonEmpty)
import Data.List.NonEmpty (toList)

type Run a = NonEmpty a
type EncodedRun a = (a, Int)

encode ::
    Eq a => [a] -> [EncodedRun a]
encode =
    map encodeRun . listToRuns

listToRuns ::
    Eq a => [a] -> [Run a]
listToRuns xs =
    unfoldr step xs
        where
            step [] =
                Nothing
            step (x : xs) =
                let
                    (run', xs') = span (== x) xs
                    run = (x :| run')
                in
                    Just (run, xs')

encodeRun ::
    Run a -> EncodedRun a
encodeRun xs@(x :| _) =
    (x, length xs)

decode ::
    [EncodedRun a] -> [a]
decode =
    runsToList . map decodeRun

decodeRun ::
    EncodedRun a -> Run a
decodeRun (x, n) =
    (x :| replicate (n - 1) x)

runsToList ::
    [Run a] -> [a]
runsToList runs =
    foldl (++) [] $ map toList runs

