import Control.Monad (replicateM)
import Control.Monad.State (runState)
import Control.Monad.State (state)
import Data.List (intercalate)
import System.Random (getStdGen)
import System.Random (randomR)
import System.Random (StdGen)
import Text.Printf (printf)

main :: IO ()
main =
    do
        gen <- getStdGen
        demonstration gen
        pure ()

demonstration :: StdGen -> IO StdGen
demonstration gen =
    let
        (xs, gen') = generateRandomValues gen (10, 99) 20
        (sortedXs, gen'') = quickSort gen' xs
    in do
        printList xs
        printList sortedXs
        pure gen''

generateRandomValues :: StdGen -> (Int, Int) -> Int -> ([Int], StdGen)
generateRandomValues gen range n =
    let
        s = state (randomR range)
        m = replicateM n s
    in
        runState m gen

printList :: [Int] -> IO ()
printList xs
    | isSorted xs = printf "%s (sorted)\n" (listToString xs)
    | otherwise   = printf "%s (not sorted)\n" (listToString xs)

isSorted :: Ord a => [a] -> Bool
isSorted [] = True
isSorted (x : []) = True
isSorted (x1 : x2 : xs) = x1 <= x2 && isSorted (x2 : xs)

listToString :: [Int] -> String
listToString xs = intercalate " " $ map toString xs
    where
        toString x = printf "%d" x

quickSort :: Ord a => StdGen -> [a] -> ([a], StdGen)
quickSort gen [] = ([], gen)
quickSort gen xs =
    let
        (pivot, gen') = randomSelect gen xs
        (lessXs, equalXs, greaterXs) = partition pivot xs
        (sortedLessXs, gen'') = quickSort gen' lessXs
        (sortedGreaterXs, gen''') = quickSort gen'' greaterXs
        sortedXs = sortedLessXs ++ equalXs ++ sortedGreaterXs
    in
        (sortedXs, gen''')

randomSelect :: StdGen -> [a] -> (a, StdGen)
randomSelect gen xs =
    let
        (n, gen') = randomR (0, length xs - 1) gen
        x = xs !! n
    in
        (x, gen')

partition :: Ord a => a -> [a] -> ([a], [a], [a])
partition pivot xs = foldl folder ([], [], []) xs
    where
        folder (lessXs, equalXs, greaterXs) x
            | x < pivot = ((x : lessXs), equalXs, greaterXs)
            | x > pivot = (lessXs, equalXs, (x : greaterXs))
            | otherwise = (lessXs, (x : equalXs), greaterXs)

