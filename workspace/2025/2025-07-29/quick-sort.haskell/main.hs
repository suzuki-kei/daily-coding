import Control.Monad (replicateM)
import Control.Monad.State (runState)
import Control.Monad.State (state)
import Data.List (intercalate)
import System.Random (StdGen)
import System.Random (getStdGen)
import System.Random (randomR)
import Text.Printf (printf)

main :: IO ()
main = do
    gen <- getStdGen
    let (xs, gen') = generateRandomValues 20 gen
    let (sortedXs, gen'') = quickSort xs gen'
    printList xs
    printList sortedXs

generateRandomValues :: Int -> StdGen -> ([Int], StdGen)
generateRandomValues n gen = runState m gen
    where
        r = (10, 99) :: (Int, Int)
        s = state (randomR r)
        m = replicateM n s

class ToString a where
    toString :: a -> String

instance ToString Int where
    toString n = printf "%d" n

listToString :: ToString a => [a] -> String
listToString xs = intercalate " " $ map toString xs

printList :: (Ord a, ToString a) => [a] -> IO ()
printList xs
    | isSorted xs = printf "%s (sorted)\n" $ listToString xs
    | otherwise   = printf "%s (not sorted)\n" $ listToString xs

isSorted :: Ord a => [a] -> Bool
isSorted [] = True
isSorted (x : []) = True
isSorted (x1 : x2 : xs) = x1 <= x2 && isSorted (x2 : xs)

quickSort :: Ord a => [a] -> StdGen -> ([a], StdGen)
quickSort [] gen = ([], gen)
quickSort xs gen = (sortedXs, gen''')
    where
        (pivot, gen') = randomSelect xs gen
        (lessXs, equalXs, greaterXs) = partition pivot xs
        (sortedLessXs, gen'') = quickSort lessXs gen'
        (sortedGreaterXs, gen''') = quickSort greaterXs gen''
        sortedXs = sortedLessXs ++ equalXs ++ sortedGreaterXs

randomSelect :: [a] -> StdGen -> (a, StdGen)
randomSelect xs gen = (x, gen')
    where
        (n, gen') = randomR (0, length xs - 1) gen
        x = xs !! n

partition :: Ord a => a -> [a] -> ([a], [a], [a])
partition pivot xs = foldl folder ([], [], []) xs
    where
        folder (lessXs, equalXs, greaterXs) x
            | x  < pivot = ((x : lessXs), equalXs, greaterXs)
            | x == pivot = (lessXs, (x : equalXs), greaterXs)
            | x  > pivot = (lessXs, equalXs, (x : greaterXs))

