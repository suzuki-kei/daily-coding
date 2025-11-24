import Control.Monad (replicateM)
import Control.Monad.State (runState)
import Control.Monad.State (state)
import Data.List (intercalate)
import System.Random (getStdGen)
import System.Random (randomR)
import System.Random (StdGen)
import Text.Printf (printf)
import Text.Printf (PrintfArg)

main :: IO ()
main = getStdGen >>= demonstration

demonstration :: StdGen -> IO ()
demonstration gen =
    let
        (xs, gen') = randomRs (10, 99) 20 gen
        (sortedXs, gen'') = quickSort xs gen
    in do
        printList xs
        printList sortedXs

randomRs :: (Int, Int) -> Int -> StdGen -> ([Int], StdGen)
randomRs range n gen =
    let
        s = state (randomR range)
        m = replicateM n s
    in
        runState m gen

printList :: (PrintfArg a, Ord a) => [a] -> IO ()
printList xs
    | isSorted xs = printf "%s (sorted)\n" (toString xs)
    | otherwise   = printf "%s (not sorted)\n" (toString xs)
    where
        toString xs = intercalate " " $ map (printf "%d") xs

isSorted :: Ord a => [a] -> Bool
isSorted [] = True
isSorted [x] = True
isSorted (x1 : x2 : xs) = x1 <= x2 && isSorted (x2 : xs)

quickSort :: Ord a => [a] -> StdGen -> ([a], StdGen)
quickSort [] gen = ([], gen)
quickSort xs gen =
    let
        (pivot, gen') = randomSelect xs gen
        (lessXs, equalXs, greaterXs) = partition pivot xs
        (sortedLessXs, gen'') = quickSort lessXs gen'
        (sortedGreaterXs, gen''') = quickSort greaterXs gen''
        sortedXs = sortedLessXs ++ equalXs ++ sortedGreaterXs
    in
        (sortedXs, gen''')

randomSelect :: [a] -> StdGen -> (a, StdGen)
randomSelect xs gen =
    let
        (n, gen') = randomR (0, length xs - 1) gen
        x = xs !! n
    in
        (x, gen')

partition :: Ord a => a -> [a] -> ([a], [a], [a])
partition pivot xs = foldl step ([], [], []) xs
    where
        step (lessXs, equalXs, greaterXs) x
            | x  < pivot = ((x : lessXs), equalXs, greaterXs)
            | x == pivot = (lessXs, (x : equalXs), greaterXs)
            | x  > pivot = (lessXs, equalXs, (x : greaterXs))

