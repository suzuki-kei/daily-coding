import Text.Printf

main :: IO ()
main = do
    let set1 = makeSet [10..16]
    let set2 = makeSet [14..20]
    printSet "set1" set1
    printSet "set2" set2
    printSet "union(set1, set2)" $ union set1 set2
    printSet "difference(set1, set2)" $ difference set1 set2
    printSet "intersection(set1, set2)" $ intersection set1 set2

printSet :: String -> [Int] -> IO ()
printSet name set = do
    printf "%s = %s\n" name $ unwords $ map show set

include :: Int -> [Int] -> Bool
include target [] = False
include target (x:xs)
    | target == x = True
    | otherwise   = include target xs

makeSet :: [Int] -> [Int]
makeSet [] = []
makeSet (x:xs)
    | include x xs = makeSet xs
    | otherwise    = x : makeSet xs

isSet :: [Int] -> Bool
isSet [] = True
isSet (x:xs)
    | include x xs = False
    | otherwise    = isSet xs

union :: [Int] -> [Int] -> [Int]
union set1 [] = set1
union [] set2 = set2
union (x:xs) set2
    | include x set2 = union xs set2
    | otherwise      = x : union xs set2

difference :: [Int] -> [Int] -> [Int]
difference set1 [] = set1
difference [] set2 = []
difference (x:xs) set2
    | include x set2 = difference xs set2
    | otherwise      = x : difference xs set2

intersection :: [Int] -> [Int] -> [Int]
intersection set1 [] = []
intersection [] set2 = []
intersection (x:xs) set2
    | include x set2 = x : intersection xs set2
    | otherwise      = intersection xs set2

