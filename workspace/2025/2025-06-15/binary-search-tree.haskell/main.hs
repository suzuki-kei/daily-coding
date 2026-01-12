{- cabal:
    build-depends: base, HUnit
-}

import Data.List (sort)
import Test.HUnit
import Text.Printf (printf)

main :: IO ()
main = do
    runTestTT allTests
    pure ()

allTests :: Test
allTests = TestList [
    fromValueTests,
    fromValuesTests,
    appendTests,
    appendsTests,
    popTests,
    popNTests,
    countTests,
    showTreeTests,
    fmapTreeTests]

infix 1 ==>
(==>) :: a -> b -> (a, b)
(==>) a b = (a, b)

testFromActualExpectedPairs
    :: (Eq a, Show a) => String -> [(a, a)] -> Test
testFromActualExpectedPairs label pairs =
    let
        ns = ([1..] :: [Int])
    in
        test (zipWith makeTest ns pairs)
    where
        makeTest n (actual, expected)
            = label ~: printf "#%d" n ~: expected ~=? actual

testFromArgumentExpectedPairs
    :: (Eq b, Show b) => String -> (a -> b) -> [(a, b)] -> Test
testFromArgumentExpectedPairs label f pairs =
    let
        actualExpectedPairs = map mapper pairs
    in
        testFromActualExpectedPairs label actualExpectedPairs
    where
        mapper (argument, expected) = (f argument, expected)

data Tree a = EmptyTree | Node {nodeValue :: a,
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
        -- 木の状態のパターンは append のテストに任せる
        -- ここでは追加する値の要素数のパターンをテストする
        take 0 [5, 3, 7] ==> EmptyTree,
        take 1 [5, 3, 7] ==> Node 5 EmptyTree EmptyTree,
        take 2 [5, 3, 7] ==> Node 5 (Node 3 EmptyTree EmptyTree) EmptyTree,
        take 3 [5, 3, 7] ==> Node 5 (Node 3 EmptyTree EmptyTree)
                                    (Node 7 EmptyTree EmptyTree)]

append :: Ord a => Tree a -> a -> Tree a
append EmptyTree x
    = fromValue x
append (Node value left right) x
    | x < value = Node value (append left x) right
    | otherwise = Node value left (append right x)

appendTests :: Test
appendTests = testFromActualExpectedPairs "append" [
        -- EmptyTree に追加する
        append EmptyTree 1
            ==> Node 1 EmptyTree EmptyTree,
        -- 深さ 1 の Tree の各末端に追加する
        append (Node 5 EmptyTree EmptyTree) 3
            ==> Node 5 (Node 3 EmptyTree EmptyTree) EmptyTree,
        append (Node 5 EmptyTree EmptyTree) 7
            ==> Node 5 EmptyTree (Node 7 EmptyTree EmptyTree),
        -- 深さ 2 の Tree の各末端に追加する
        append (Node 5 (Node 3 EmptyTree EmptyTree)
                       (Node 7 EmptyTree EmptyTree)) 2
            ==> Node 5 (Node 3 (Node 2 EmptyTree EmptyTree) EmptyTree)
                       (Node 7 EmptyTree EmptyTree),
        append (Node 5 (Node 3 EmptyTree EmptyTree)
                       (Node 7 EmptyTree EmptyTree)) 4
            ==> Node 5 (Node 3 EmptyTree (Node 4 EmptyTree EmptyTree))
                       (Node 7 EmptyTree EmptyTree),
        append (Node 5 (Node 3 EmptyTree EmptyTree)
                       (Node 7 EmptyTree EmptyTree)) 6
            ==> Node 5 (Node 3 EmptyTree EmptyTree)
                       (Node 7 (Node 6 EmptyTree EmptyTree) EmptyTree),
        append (Node 5 (Node 3 EmptyTree EmptyTree)
                       (Node 7 EmptyTree EmptyTree)) 8
            ==> Node 5 (Node 3 EmptyTree EmptyTree)
                       (Node 7 EmptyTree (Node 8 EmptyTree EmptyTree))]

appends :: Ord a => Tree a -> [a] -> Tree a
appends tree xs = foldl append tree xs

appendsTests :: Test
appendsTests = testFromArgumentExpectedPairs "appends" (appends EmptyTree) [
        -- 木の状態のパターンは append のテストに任せる
        -- ここでは追加する値の要素数のパターンをテストする
        take 0 [5, 3, 7] ==> EmptyTree,
        take 1 [5, 3, 7] ==> Node 5 EmptyTree EmptyTree,
        take 2 [5, 3, 7] ==> Node 5 (Node 3 EmptyTree EmptyTree) EmptyTree,
        take 3 [5, 3, 7] ==> Node 5 (Node 3 EmptyTree EmptyTree)
                                    (Node 7 EmptyTree EmptyTree)]

pop :: Ord a => NonEmptyTree a -> (a, Tree a)
pop (NonEmptyTree value left right) = pop' (Node value left right)
    where
        pop' (Node value EmptyTree right) = (value, right)
        pop' (Node value left right) =
            let
                (minValue, newLeft) = pop' left
            in
                (minValue, Node value newLeft right)

popTests = testFromArgumentExpectedPairs "pop" pop [
        -- 深さ 1 の Tree
        NonEmptyTree 1 EmptyTree EmptyTree
            ==> (1, EmptyTree),
        -- 深さ 2 の Tree
        NonEmptyTree 5 (Node 3 EmptyTree EmptyTree) EmptyTree
            ==> (3, Node 5 EmptyTree EmptyTree),
        NonEmptyTree 5 EmptyTree (Node 7 EmptyTree EmptyTree)
            ==> (5, Node 7 EmptyTree EmptyTree),
        NonEmptyTree 5 (Node 3 EmptyTree EmptyTree)
                       (Node 7 EmptyTree EmptyTree)
            ==> (3, Node 5 EmptyTree (Node 7 EmptyTree EmptyTree)),
        -- 深さ 3 の Tree
        NonEmptyTree 5 (Node 3 (Node 2 EmptyTree EmptyTree) EmptyTree)
                       (Node 7 EmptyTree EmptyTree)
            ==> (2, Node 5 (Node 3 EmptyTree EmptyTree)
                           (Node 7 EmptyTree EmptyTree)),
        NonEmptyTree 5 (Node 3 EmptyTree (Node 4 EmptyTree EmptyTree))
                       (Node 7 EmptyTree EmptyTree)
            ==> (3, (Node 5 (Node 4 EmptyTree EmptyTree)
                            (Node 7 EmptyTree EmptyTree))),
        NonEmptyTree 5 (Node 3 EmptyTree EmptyTree)
                       (Node 7 (Node 6 EmptyTree EmptyTree) EmptyTree)
            ==> (3, (Node 5 EmptyTree 
                            (Node 7 (Node 6 EmptyTree EmptyTree) EmptyTree))),
        NonEmptyTree 5 (Node 3 EmptyTree EmptyTree)
                       (Node 7 EmptyTree (Node 8 EmptyTree EmptyTree))
            ==> (3, (Node 5 EmptyTree
                            (Node 7 EmptyTree (Node 8 EmptyTree EmptyTree)))),
        NonEmptyTree 5 (Node 3 (Node 2 EmptyTree EmptyTree)
                               (Node 4 EmptyTree EmptyTree))
                       (Node 7 (Node 6 EmptyTree EmptyTree)
                               (Node 8 EmptyTree EmptyTree))
            ==> (2, Node 5 (Node 3 EmptyTree
                                   (Node 4 EmptyTree EmptyTree))
                           (Node 7 (Node 6 EmptyTree EmptyTree)
                                   (Node 8 EmptyTree EmptyTree)))]

popN :: Ord a => Tree a -> Int -> ([a], Tree a)
popN tree n = popN' tree n []
    where
        popN' EmptyTree n xs =
            (reverse xs, EmptyTree)
        popN' tree 0 xs =
            (reverse xs, tree)
        popN' (Node value left right) n xs =
            let
                (x, tree') = pop (NonEmptyTree value left right)
            in
                popN' tree' (n - 1) (x : xs)

popNTests :: Test
popNTests =
    let
        tree = Node 5 (Node 3 (Node 2 EmptyTree EmptyTree)
                              (Node 4 EmptyTree EmptyTree))
                      (Node 7 (Node 6 EmptyTree EmptyTree)
                              (Node 8 EmptyTree EmptyTree))
    in
        testFromArgumentExpectedPairs "popN" (popN tree) [
            0 ==> ([],
                   Node 5 (Node 3 (Node 2 EmptyTree EmptyTree)
                                  (Node 4 EmptyTree EmptyTree))
                          (Node 7 (Node 6 EmptyTree EmptyTree)
                                  (Node 8 EmptyTree EmptyTree))),
            1 ==> ([2],
                   Node 5 (Node 3 EmptyTree
                                  (Node 4 EmptyTree EmptyTree))
                          (Node 7 (Node 6 EmptyTree EmptyTree)
                                  (Node 8 EmptyTree EmptyTree))),
            2 ==> ([2, 3],
                   Node 5 (Node 4 EmptyTree EmptyTree)
                          (Node 7 (Node 6 EmptyTree EmptyTree)
                                  (Node 8 EmptyTree EmptyTree))),
            3 ==> ([2, 3, 4],
                   Node 5 EmptyTree
                          (Node 7 (Node 6 EmptyTree EmptyTree)
                                  (Node 8 EmptyTree EmptyTree))),
            4 ==> ([2, 3, 4, 5],
                   Node 7 (Node 6 EmptyTree EmptyTree)
                          (Node 8 EmptyTree EmptyTree)),
            5 ==> ([2, 3, 4, 5, 6],
                   Node 7 EmptyTree (Node 8 EmptyTree EmptyTree)),
            6 ==> ([2, 3, 4, 5, 6, 7],
                   Node 8 EmptyTree EmptyTree),
            7 ==> ([2, 3, 4, 5, 6, 7, 8], EmptyTree),
            8 ==> ([2, 3, 4, 5, 6, 7, 8], EmptyTree)]

count :: Tree a -> Int
count EmptyTree = 0
count (Node value left right) = 1 + count left + count right

countTests :: Test
countTests =
    let
        xs = [5, 3, 7, 2, 4, 8, 6]
        ns = [0 .. length xs - 1]
        pairs = map (\n -> fromValues (take n xs) ==> n) ns
    in
        testFromArgumentExpectedPairs "count" count pairs

instance Show a => Show (Tree a) where
    show tree = "Tree {" ++ show' tree ++ "}"
        where
            show' EmptyTree
                = "()"
            show' (Node value EmptyTree EmptyTree)
                = "(" ++ show value ++ ")"
            show' (Node value left right)
                = "(" ++ show value ++ show' left ++ show' right ++ ")"

showTreeTests = testFromArgumentExpectedPairs "show (Tree a)" show [
        -- EmptyTree
        EmptyTree
            ==> "Tree {()}",
        -- 深さ 1 の Tree
        Node 5 EmptyTree EmptyTree
            ==> "Tree {(5)}",
        -- 深さ 2 の Tree
        Node 5 (Node 3 EmptyTree EmptyTree) EmptyTree
            ==> "Tree {(5(3)())}",
        Node 5 EmptyTree (Node 7 EmptyTree EmptyTree)
            ==> "Tree {(5()(7))}",
        Node 5 (Node 3 EmptyTree EmptyTree) (Node 7 EmptyTree EmptyTree)
            ==> "Tree {(5(3)(7))}",
        -- 深さ 3 の Tree
        Node 5 (Node 3 (Node 2 EmptyTree EmptyTree) EmptyTree)
               (Node 7 EmptyTree EmptyTree)
            ==> "Tree {(5(3(2)())(7))}",
        Node 5 (Node 3 EmptyTree (Node 4 EmptyTree EmptyTree))
               (Node 7 EmptyTree EmptyTree)
            ==> "Tree {(5(3()(4))(7))}",
        Node 5 (Node 3 EmptyTree EmptyTree)
               (Node 7 (Node 6 EmptyTree EmptyTree) EmptyTree)
            ==> "Tree {(5(3)(7(6)()))}",
        Node 5 (Node 3 EmptyTree EmptyTree)
               (Node 7 EmptyTree (Node 8 EmptyTree EmptyTree))
            ==> "Tree {(5(3)(7()(8)))}",
        Node 5 (Node 3 (Node 2 EmptyTree EmptyTree)
                       (Node 4 EmptyTree EmptyTree))
               (Node 7 (Node 6 EmptyTree EmptyTree)
                       (Node 8 EmptyTree EmptyTree))
            ==> "Tree {(5(3(2)(4))(7(6)(8)))}"]

instance Functor Tree where
    fmap f EmptyTree
        = EmptyTree
    fmap f (Node value left right)
        = Node (f value) (fmap f left) (fmap f right)

fmapTreeTests = testFromActualExpectedPairs "fmap Tree" [
        -- EmptyTree
        fmap (+1) EmptyTree
            ==> EmptyTree,
        -- 深さ 1 の Tree
        fmap (+1) (Node 1 EmptyTree EmptyTree)
            ==> Node 2 EmptyTree EmptyTree,
        -- 深さ 2 の Tree
        fmap (+1) (Node 5 (Node 3 EmptyTree EmptyTree) EmptyTree)
            ==> Node 6 (Node 4 EmptyTree EmptyTree) EmptyTree,
        fmap (+1) (Node 5 EmptyTree (Node 7 EmptyTree EmptyTree))
            ==> Node 6 EmptyTree (Node 8 EmptyTree EmptyTree),
        fmap (+1) (Node 5 (Node 3 EmptyTree EmptyTree)
                          (Node 7 EmptyTree EmptyTree))
            ==> Node 6 (Node 4 EmptyTree EmptyTree)
                       (Node 8 EmptyTree EmptyTree),
        -- 深さ 3 の Tree
        fmap (+1) (Node 5 (Node 3 (Node 2 EmptyTree EmptyTree)
                                  (Node 4 EmptyTree EmptyTree))
                          (Node 7 (Node 6 EmptyTree EmptyTree)
                                  (Node 8 EmptyTree EmptyTree)))
            ==> Node 6 (Node 4 (Node 3 EmptyTree EmptyTree)
                               (Node 5 EmptyTree EmptyTree))
                       (Node 8 (Node 7 EmptyTree EmptyTree)
                               (Node 9 EmptyTree EmptyTree)),
        -- 異なる mapper
        fmap (*2) (Node 5 (Node 3 (Node 2 EmptyTree EmptyTree)
                                  (Node 4 EmptyTree EmptyTree))
                          (Node 7 (Node 6 EmptyTree EmptyTree)
                                  (Node 8 EmptyTree EmptyTree)))
            ==> Node 10 (Node 6 (Node 4 EmptyTree EmptyTree)
                                (Node 8 EmptyTree EmptyTree))
                        (Node 14 (Node 12 EmptyTree EmptyTree)
                                 (Node 16 EmptyTree EmptyTree))]

