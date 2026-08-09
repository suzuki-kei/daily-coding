import Control.Monad (replicateM)
import Control.Monad.State (runState)
import Control.Monad.State (state)
import Control.Monad.State (State)
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
        ((xs, sortedXs), gen') = runState run gen
    in do
        printList xs
        printList sortedXs
        pure gen'
    where
        run = do
            xs <- generateRandomValues (10, 99) 20
            sortedXs <- quickSort xs
            pure (xs, sortedXs)

generateRandomValues :: (Int, Int) -> Int -> State StdGen [Int]
generateRandomValues range n = replicateM n (state (randomR range))

printList :: [Int] -> IO ()
printList xs
    | isSorted xs = printf "%s (sorted)\n" (listToString xs)
    | otherwise   = printf "%s (not sorted)\n" (listToString xs)

isSorted :: Ord a => [a] -> Bool
isSorted [] = True
isSorted [_] = True
isSorted (x1 : x2 : xs) = x1 <= x2 && isSorted (x2 : xs)

listToString :: [Int] -> String
listToString xs = intercalate " " $ map toString xs
    where
        toString x = printf "%d" x

quickSort :: Ord a => [a] -> State StdGen [a]
quickSort [] = pure []
quickSort xs =
    do
        pivot <- randomSelect xs
        let (lessXs, equalXs, greaterXs) = partition pivot xs
        sortedLessXs <- quickSort lessXs
        sortedGreaterXs <- quickSort greaterXs
        pure (sortedLessXs ++ equalXs ++ sortedGreaterXs)

randomSelect :: [a] -> State StdGen a
randomSelect xs =
    do
        n <- state (randomR (0, length xs - 1))
        pure (xs !! n)

partition :: Ord a => a -> [a] -> ([a], [a], [a])
partition pivot xs = foldl folder ([], [], []) xs
    where
        folder (lessXs, equalXs, greaterXs) x
            | x < pivot = ((x : lessXs), equalXs, greaterXs)
            | x > pivot = (lessXs, equalXs, (x : greaterXs))
            | otherwise = (lessXs, (x : equalXs), greaterXs)

