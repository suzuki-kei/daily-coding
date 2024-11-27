import Data.List (intersperse)
import System.Random (StdGen, getStdGen, randomR, randomRs)
import Text.Printf (printf)

main :: IO ()
main = do
    gen <- getStdGen
    let xs = generateRandomValues gen 20
    printList xs
    printList $ quickSort gen xs

generateRandomValues :: StdGen -> Int -> [Int]
generateRandomValues gen n = take n $ randomRs (10, 99) gen

class ToString a where
    toString :: a -> String

instance ToString Int where
    toString x = printf "%d" x

instance ToString [Int] where
    toString xs = foldl (++) "" $ intersperse " " $ map toString xs

printList :: [Int] -> IO ()
printList xs
    | isSorted xs = printf "%s (sorted)\n" $ toString xs
    | otherwise   = printf "%s (not sorted)\n" $ toString xs

isSorted :: [Int] -> Bool
isSorted (x1:x2:xs) = and [x1 <= x2, isSorted (x2:xs)]
isSorted _          = True

quickSort :: StdGen -> [Int] -> [Int]
quickSort gen [] = []
quickSort gen xs = do
    let pivot = randomSelect gen xs
    let (lessXs, equalXs, greaterXs) = partition pivot xs
    (quickSort gen lessXs) ++ equalXs ++ (quickSort gen greaterXs)

randomSelect :: StdGen -> [Int] -> Int
randomSelect gen xs = xs !! (fst $ randomR (0, length xs - 1) gen)

partition :: Int -> [Int] -> ([Int], [Int], [Int])
partition pivot xs = partition pivot xs [] [] []
    where
        partition pivot [] lessXs equalXs greaterXs = (lessXs, equalXs, greaterXs)
        partition pivot (x:xs) lessXs equalXs greaterXs
            | x  < pivot = partition pivot xs (x:lessXs) equalXs greaterXs
            | x == pivot = partition pivot xs lessXs (x:equalXs) greaterXs
            | x  > pivot = partition pivot xs lessXs equalXs (x:greaterXs)

