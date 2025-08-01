{- cabal:
    build-depends: base, HUnit
-}

import Test.HUnit
import Text.Printf (printf)

main :: IO ()
main = runTestTTAndExit allTests

infix 1 ==>
(==>) :: a -> b -> (a, b)
(==>) a b = (a, b)

testFromActualExpectedPairs
    :: (Eq a, Show a) => String -> [(a, a)] -> Test
testFromActualExpectedPairs label pairs =
    let
        ns = [1..] :: [Int]
    in
        test $ zipWith zipper ns pairs
    where
        zipper n (actual, expected) =
            label ~: printf "#%d" n ~: expected ~=? actual

testFromArgumentExpectedPairs
    :: (Eq b, Show b) => String -> (a -> b) -> [(a, b)] -> Test
testFromArgumentExpectedPairs label f pairs =
    let
        actualExpectedPairs = map mapper pairs
    in
        testFromActualExpectedPairs label actualExpectedPairs
    where
        mapper (argument, expected) = (f argument, expected)

allTests :: Test
allTests = TestList [
        fromValueTests,
        fromValuesTests,
        appendTests,
        appendsTests,
        showTreeTests,
        fmapTreeTests]

data Tree a = EmptyTree
            | Node {nodeValue :: a,
                    nodeLeft  :: Tree a,
                    nodeRight :: Tree a}
    deriving Eq

data NonEmptyTree a = NonEmptyTree a (Tree a) (Tree a)
    deriving (Eq, Show)

fromValue :: a -> Tree a
fromValue x = Node x EmptyTree EmptyTree

fromValueTests :: Test
fromValueTests = testFromArgumentExpectedPairs "fromValue" fromValue [
        1 ==> Node 1 EmptyTree EmptyTree,
        2 ==> Node 2 EmptyTree EmptyTree,
        3 ==> Node 3 EmptyTree EmptyTree]

fromValues :: Ord a => [a] -> Tree a
fromValues xs = appends EmptyTree xs

fromValuesTests :: Test
fromValuesTests = testFromArgumentExpectedPairs "fromValues" fromValues [
        take 0 [5, 3, 1, 4, 7, 9, 6]
            ==> EmptyTree,
        take 1 [5, 3, 1, 4, 7, 9, 6]
            ==> Node 5 EmptyTree EmptyTree,
        take 2 [5, 3, 1, 4, 7, 9, 6]
            ==> Node 5 (Node 3 EmptyTree EmptyTree) EmptyTree,
        take 3 [5, 3, 1, 4, 7, 9, 6]
            ==> Node 5 (Node 3 (Node 1 EmptyTree EmptyTree) EmptyTree)
                       EmptyTree,
        take 4 [5, 3, 1, 4, 7, 9, 6]
            ==> Node 5 (Node 3 (Node 1 EmptyTree EmptyTree)
                               (Node 4 EmptyTree EmptyTree))
                       EmptyTree,
        take 5 [5, 3, 1, 4, 7, 9, 6]
            ==> Node 5 (Node 3 (Node 1 EmptyTree EmptyTree)
                               (Node 4 EmptyTree EmptyTree))
                       (Node 7 EmptyTree EmptyTree),
        take 6 [5, 3, 1, 4, 7, 9, 6]
            ==> Node 5 (Node 3 (Node 1 EmptyTree EmptyTree)
                               (Node 4 EmptyTree EmptyTree))
                       (Node 7 EmptyTree (Node 9 EmptyTree EmptyTree)),
        take 7 [5, 3, 1, 4, 7, 9, 6]
            ==> Node 5 (Node 3 (Node 1 EmptyTree EmptyTree)
                               (Node 4 EmptyTree EmptyTree))
                       (Node 7 (Node 6 EmptyTree EmptyTree)
                               (Node 9 EmptyTree EmptyTree))]

append :: Ord a => Tree a -> a -> Tree a
append EmptyTree x =
    Node x EmptyTree EmptyTree
append (Node value left right) x
    | x < value = Node value (append left x) right
    | otherwise = Node value left (append right x)

appendTests :: Test
appendTests = testFromActualExpectedPairs "append" [
        append EmptyTree 5
            ==> Node 5 EmptyTree EmptyTree,
        append (Node 5 EmptyTree EmptyTree) 3
            ==> Node 5 (Node 3 EmptyTree EmptyTree) EmptyTree,
        append (Node 5 (Node 3 EmptyTree EmptyTree) EmptyTree) 1
            ==> Node 5 (Node 3 (Node 1 EmptyTree EmptyTree) EmptyTree)
                       EmptyTree,
        append (Node 5 (Node 3 EmptyTree EmptyTree) EmptyTree) 4
            ==> Node 5 (Node 3 EmptyTree (Node 4 EmptyTree EmptyTree))
                       EmptyTree,
        append (Node 5 EmptyTree EmptyTree) 7
            ==> Node 5 EmptyTree (Node 7 EmptyTree EmptyTree),
        append (Node 5 EmptyTree (Node 7 EmptyTree EmptyTree)) 9
            ==> Node 5 EmptyTree
                       (Node 7 EmptyTree (Node 9 EmptyTree EmptyTree)),
        append (Node 5 EmptyTree (Node 7 EmptyTree EmptyTree)) 6
            ==> Node 5 EmptyTree
                       (Node 7 (Node 6 EmptyTree EmptyTree) EmptyTree)]

appends :: Ord a => Tree a -> [a] -> Tree a
appends tree xs = foldl append tree xs

appendsTests :: Test
appendsTests = testFromActualExpectedPairs "appends" [
        appends EmptyTree (take 0 [5, 3, 1, 4, 7, 9, 6])
            ==> EmptyTree,
        appends EmptyTree (take 1 [5, 3, 1, 4, 7, 9, 6])
            ==> Node 5 EmptyTree EmptyTree,
        appends EmptyTree (take 2 [5, 3, 1, 4, 7, 9, 6])
            ==> Node 5 (Node 3 EmptyTree EmptyTree) EmptyTree,
        appends EmptyTree (take 3 [5, 3, 1, 4, 7, 9, 6])
            ==> Node 5 (Node 3 (Node 1 EmptyTree EmptyTree) EmptyTree)
                       EmptyTree,
        appends EmptyTree (take 4 [5, 3, 1, 4, 7, 9, 6])
            ==> Node 5 (Node 3 (Node 1 EmptyTree EmptyTree)
                               (Node 4 EmptyTree EmptyTree))
                       EmptyTree,
        appends EmptyTree (take 5 [5, 3, 1, 4, 7, 9, 6])
            ==> Node 5 (Node 3 (Node 1 EmptyTree EmptyTree)
                               (Node 4 EmptyTree EmptyTree))
                       (Node 7 EmptyTree EmptyTree),
        appends EmptyTree (take 6 [5, 3, 1, 4, 7, 9, 6])
            ==> Node 5 (Node 3 (Node 1 EmptyTree EmptyTree)
                               (Node 4 EmptyTree EmptyTree))
                       (Node 7 EmptyTree (Node 9 EmptyTree EmptyTree)),
        appends EmptyTree (take 7 [5, 3, 1, 4, 7, 9, 6])
            ==> Node 5 (Node 3 (Node 1 EmptyTree EmptyTree)
                               (Node 4 EmptyTree EmptyTree))
                       (Node 7 (Node 6 EmptyTree EmptyTree)
                               (Node 9 EmptyTree EmptyTree))]

instance Show a => Show (Tree a) where
    show tree = "Tree {" ++ show' tree ++ "}"
        where
            show' EmptyTree =
                "()"
            show' (Node value EmptyTree EmptyTree) =
                "(" ++ show value ++ ")"
            show' (Node value left right) =
                "(" ++ show value ++ show' left ++ show' right ++ ")"

showTreeTests :: Test
showTreeTests = testFromArgumentExpectedPairs "show (Tree a)" show [
        EmptyTree
            ==> "Tree {()}",
        Node 5 EmptyTree EmptyTree
            ==> "Tree {(5)}",
        Node 5 (Node 3 EmptyTree EmptyTree) EmptyTree
            ==> "Tree {(5(3)())}",
        Node 5 (Node 3 (Node 1 EmptyTree EmptyTree) EmptyTree) EmptyTree
            ==> "Tree {(5(3(1)())())}",
        Node 5 (Node 3 (Node 1 EmptyTree EmptyTree)
                       (Node 4 EmptyTree EmptyTree))
               EmptyTree
            ==> "Tree {(5(3(1)(4))())}",
        Node 5 (Node 3 (Node 1 EmptyTree EmptyTree)
                       (Node 4 EmptyTree EmptyTree))
               (Node 7 EmptyTree EmptyTree)
            ==> "Tree {(5(3(1)(4))(7))}",
        Node 5 (Node 3 (Node 1 EmptyTree EmptyTree)
                       (Node 4 EmptyTree EmptyTree))
               (Node 7 EmptyTree (Node 9 EmptyTree EmptyTree))
            ==> "Tree {(5(3(1)(4))(7()(9)))}",
        Node 5 (Node 3 (Node 1 EmptyTree EmptyTree)
                       (Node 4 EmptyTree EmptyTree))
               (Node 7 (Node 6 EmptyTree EmptyTree)
                       (Node 9 EmptyTree EmptyTree))
            ==> "Tree {(5(3(1)(4))(7(6)(9)))}"]

instance Functor Tree where
    fmap f EmptyTree =
        EmptyTree
    fmap f (Node value left right) =
        Node (f value) (fmap f left) (fmap f right)

fmapTreeTests :: Test
fmapTreeTests = testFromActualExpectedPairs "fmap Tree" [
        fmap (+1) EmptyTree
            ==> EmptyTree,
        fmap (+1) (Node 5 EmptyTree EmptyTree)
            ==> Node 6 EmptyTree EmptyTree,
        fmap (+1) (Node 5 (Node 3 EmptyTree EmptyTree) EmptyTree)
            ==> Node 6 (Node 4 EmptyTree EmptyTree) EmptyTree,
        fmap (+1) (Node 5 (Node 3 (Node 1 EmptyTree EmptyTree) EmptyTree)
                          EmptyTree)
            ==> Node 6 (Node 4 (Node 2 EmptyTree EmptyTree) EmptyTree)
                       EmptyTree,
        fmap (+1) (Node 5 (Node 3 (Node 1 EmptyTree EmptyTree)
                                  (Node 4 EmptyTree EmptyTree))
                          EmptyTree)
            ==> Node 6 (Node 4 (Node 2 EmptyTree EmptyTree)
                               (Node 5 EmptyTree EmptyTree))
                       EmptyTree,
        fmap (+1) (Node 5 (Node 3 (Node 1 EmptyTree EmptyTree)
                                  (Node 4 EmptyTree EmptyTree))
                          (Node 7 EmptyTree EmptyTree))
            ==> Node 6 (Node 4 (Node 2 EmptyTree EmptyTree)
                               (Node 5 EmptyTree EmptyTree))
                       (Node 8 EmptyTree EmptyTree),
        fmap (+1) (Node 5 (Node 3 (Node 1 EmptyTree EmptyTree)
                                  (Node 4 EmptyTree EmptyTree))
                          (Node 7 EmptyTree (Node 9 EmptyTree EmptyTree)))
            ==> Node 6 (Node 4 (Node 2 EmptyTree EmptyTree)
                               (Node 5 EmptyTree EmptyTree))
                       (Node 8 EmptyTree (Node 10 EmptyTree EmptyTree)),
        fmap (+1) (Node 5 (Node 3 (Node 1 EmptyTree EmptyTree)
                             (Node 4 EmptyTree EmptyTree))
                     (Node 7 (Node 6 EmptyTree EmptyTree)
                             (Node 9 EmptyTree EmptyTree)))
            ==> Node 6 (Node 4 (Node 2 EmptyTree EmptyTree)
                               (Node 5 EmptyTree EmptyTree))
                       (Node 8 (Node 7 EmptyTree EmptyTree)
                               (Node 10 EmptyTree EmptyTree)),
        fmap (*2) (Node 5 (Node 3 (Node 1 EmptyTree EmptyTree)
                             (Node 4 EmptyTree EmptyTree))
                     (Node 7 (Node 6 EmptyTree EmptyTree)
                             (Node 9 EmptyTree EmptyTree)))
            ==> Node 10 (Node 6 (Node 2 EmptyTree EmptyTree)
                                (Node 8 EmptyTree EmptyTree))
                       (Node 14 (Node 12 EmptyTree EmptyTree)
                                (Node 18 EmptyTree EmptyTree))]

