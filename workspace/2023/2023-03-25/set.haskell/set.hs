import Data.List (sort)

main :: IO ()
main = do
    let set1 = [10..16]
    let set2 = [14..20]
    print set1
    print set2
    print $ sort $ union set1 set2
    print $ sort $ difference set1 set2
    print $ sort $ intersection set1 set2

include :: (Eq eq) => eq -> [eq] -> Bool
include _ [] = False
include target (x:xs)
    | target == x = True
    | otherwise   = include target xs

isSet :: (Eq eq) => [eq] -> Bool
isSet [] = True
isSet (x:xs)
    | include x xs = False
    | otherwise    = isSet xs

union :: (Eq eq) => [eq] -> [eq] -> [eq]
union set1 [] = set1
union [] set2 = set2
union (x:xs) set2
    | include x set2 = union xs set2
    | otherwise      = union xs (x:set2)

difference :: (Eq eq) => [eq] -> [eq] -> [eq]
difference set1 [] = set1
difference [] set2 = []
difference (x:xs) set2
    | include x set2 = difference xs set2
    | otherwise      = (x : difference xs set2)

intersection :: (Eq eq) => [eq] -> [eq] -> [eq]
intersection _ [] = []
intersection [] _ = []
intersection (x:xs) set2
    | include x set2 = (x : intersection xs set2)
    | otherwise      = intersection xs set2

