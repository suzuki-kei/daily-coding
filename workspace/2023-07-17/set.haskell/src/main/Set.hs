module Set where

import qualified Lists

--
-- リストから集合を作成する.
--
fromList :: (Eq eq) => [eq] -> [eq]
fromList [] = []
fromList (x:xs)
    | Lists.contains x xs = xs
    | otherwise           = (x : fromList xs)

--
-- リストが集合であることを判定する.
--
isSet :: (Eq eq) => [eq] -> Bool
isSet [] = True
isSet [x] = True
isSet (x:xs)
    | Lists.contains x xs = False
    | otherwise           = isSet xs

--
-- 部分集合であることを判定する.
--
isSubset :: (Eq eq) => [eq] -> [eq] -> Bool
isSubset [] set2 = True
isSubset set1 [] = False
isSubset (x:xs) set2 
    | Lists.contains x set2 = isSubset xs set2
    | otherwise             = False

--
-- 2 つのリストが等しいことを判定する.
--
equals :: (Eq eq) => [eq] -> [eq] -> Bool
equals set1 set2 = and [isSubset set1 set2, isSubset set2 set1]

--
-- 和集合を求める.
--
union :: (Eq eq) => [eq] -> [eq] -> [eq]
union set1 set2 = set1 ++ (difference set2 set1)

--
-- 差集合を求める.
--
difference :: (Eq eq) => [eq] -> [eq] -> [eq]
difference set1 [] = set1
difference [] set2 = []
difference (x:xs) set2
    | Lists.contains x set2 = difference xs set2
    | otherwise             = x : difference xs set2

--
-- 共通部分を求める.
--
intersection :: (Eq eq) => [eq] -> [eq] -> [eq]
intersection set1 [] = []
intersection [] set2 = []
intersection (x:xs) set2
    | Lists.contains x set2 = x : intersection xs set2
    | otherwise             = intersection xs set2

