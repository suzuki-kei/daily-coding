module RunLengthEncoding where

import Data.List.NonEmpty (group)
import Data.List.NonEmpty (NonEmpty ((:|)))
import Data.List.NonEmpty (NonEmpty)
import Data.List.NonEmpty (toList)

type Run a = NonEmpty a
type EncodedRun a = (a, Int)

encode :: Eq a => [a] -> [EncodedRun a]
encode = map encodeRun . listToRuns
    where
        listToRuns = group
        encodeRun run@(x :| _) = (x, length run)

decode :: [EncodedRun a] -> [a]
decode = runsToList . map decodeRun
    where
        decodeRun (x, n) = x :| replicate (n - 1) x
        runsToList = concat . map toList

