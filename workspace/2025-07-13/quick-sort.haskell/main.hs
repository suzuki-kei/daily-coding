import Data.List (intercalate)
import System.Random (StdGen)
import System.Random (getStdGen)
import System.Random (randomR)
import Text.Printf (printf)

main :: IO ()
main = do
    gen <- getStdGen
    let
        (xs, gen') = generateRandomValues 20 gen
        (sortedXs, gen'') = quickSort xs gen'
    printList xs
    printList sortedXs

generateRandomValues :: Int -> StdGen -> ([Int], StdGen)
generateRandomValues n gen = foldl folder ([], gen) [1..n]
    where
        folder (xs, gen) i =
            let
                (x, gen') = randomR (10, 99) gen
            in
                ((x : xs), gen')

printList :: (Ord a, ToString a) => [a] -> IO ()
printList xs
    | isSorted xs = printf "%s (sorted)\n" (listToString xs)
    | otherwise   = printf "%s (not sorted)\n" (listToString xs)

isSorted :: Ord a => [a] -> Bool
isSorted [] = True
isSorted (x : []) = True
isSorted (x1 : x2 : xs) = x1 <= x2 && isSorted (x2 : xs)

listToString :: ToString a => [a] -> String
listToString xs = intercalate " " $ map toString xs

class ToString a where
    toString :: a -> String

instance ToString Int where
    toString n = printf "%d" n

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
partition pivot xs = foldl folder ([], [], []) xs
    where
        folder (lessXs, equalXs, greaterXs) x
            | x  < pivot = ((x : lessXs), equalXs, greaterXs)
            | x == pivot = (lessXs, (x : equalXs), greaterXs)
            | x  > pivot = (lessXs, equalXs, (x : greaterXs))

