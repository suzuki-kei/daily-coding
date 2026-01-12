{- cabal:
    build-depends: base, HUnit
-}

import Test.HUnit
import Text.Printf (printf)

main :: IO ()
main = runTestTTAndExit allTests

allTests = TestList [
    fromValueTests,
    fromValuesTests,
    appendTests,
    popMinTests,
    popMaxTests,
    fmapTreeTests,
    showTreeTests]

infix 1 ==>
(==>) :: a -> b -> (a, b)
(==>) a b = (a, b)

testsFromActualExpectedPairs :: (Eq a, Show a) => String -> [(a, a)] -> Test
testsFromActualExpectedPairs label pairs =
    let
        labels = map (\n -> printf "%s #%d" label n) ([1..] :: [Int])
        zipper = (\label (actual, expected) -> label ~: expected ~=? actual)
        tests = zipWith zipper labels pairs
    in
        test tests

testsFromArgumentExpectedPairs :: (Eq b, Show b) => String -> (a -> b) -> [(a, b)] -> Test
testsFromArgumentExpectedPairs label f pairs =
    let
        mapper = (\(argument, expected) -> (f argument, expected))
        actualExpectedPairs = map mapper pairs
    in
        testsFromActualExpectedPairs label actualExpectedPairs

data Tree a = EmptyTree
            | Node {nodeValue :: a,
                    nodeLeft  :: Tree a,
                    nodeRight :: Tree a}
    deriving Eq

data NonEmptyTree a = NonEmptyTree a (Tree a) (Tree a)
    deriving (Eq, Show)

fromValue :: a -> Tree a
fromValue x = Node x EmptyTree EmptyTree

fromValueTests = testsFromArgumentExpectedPairs "fromValue" fromValue [
    1 ==> Node 1 EmptyTree EmptyTree,
    2 ==> Node 2 EmptyTree EmptyTree,
    3 ==> Node 3 EmptyTree EmptyTree]

fromValues :: Ord a => [a] -> Tree a
fromValues xs = foldl append EmptyTree xs

fromValuesTests = testsFromArgumentExpectedPairs "fromValues" fromValues [
    -- depth=0
    [] ==> EmptyTree,

    -- depth=1
    [5] ==> Node 5 EmptyTree EmptyTree,

    -- depth=2 (depth=1 の右側が EmptyTree の場合)
    [5, 3, 7] ==> Node 5 (Node 3 EmptyTree EmptyTree) (Node 7 EmptyTree EmptyTree),

    -- depth=2 (depth=1 の左側が EmptyTree の場合)
    [5, 7, 3] ==> Node 5 (Node 3 EmptyTree EmptyTree) (Node 7 EmptyTree EmptyTree),

    -- depth=3 (depth=2 の右側が EmptyTree の場合)
    [5, 3, 1, 4, 7] ==> Node 5 (Node 3 (Node 1 EmptyTree EmptyTree) (Node 4 EmptyTree EmptyTree)) (Node 7 EmptyTree EmptyTree),
    [5, 3, 4, 1, 7] ==> Node 5 (Node 3 (Node 1 EmptyTree EmptyTree) (Node 4 EmptyTree EmptyTree)) (Node 7 EmptyTree EmptyTree),

    -- depth=3 (depth=2 の右側が EmptyTree ではない場合)
    [5, 7, 3, 1, 4] ==> Node 5 (Node 3 (Node 1 EmptyTree EmptyTree) (Node 4 EmptyTree EmptyTree)) (Node 7 EmptyTree EmptyTree),
    [5, 7, 3, 4, 1] ==> Node 5 (Node 3 (Node 1 EmptyTree EmptyTree) (Node 4 EmptyTree EmptyTree)) (Node 7 EmptyTree EmptyTree),

    -- depth=3 (depth=2 の左側が EmptyTree の場合)
    [5, 7, 6, 9, 3] ==> Node 5 (Node 3 EmptyTree EmptyTree) (Node 7 (Node 6 EmptyTree EmptyTree) (Node 9 EmptyTree EmptyTree)),
    [5, 7, 9, 6, 3] ==> Node 5 (Node 3 EmptyTree EmptyTree) (Node 7 (Node 6 EmptyTree EmptyTree) (Node 9 EmptyTree EmptyTree)),

    -- depth=3 (depth=2 の左側が EmptyTree ではない場合)
    [5, 3, 7, 6, 9] ==> Node 5 (Node 3 EmptyTree EmptyTree) (Node 7 (Node 6 EmptyTree EmptyTree) (Node 9 EmptyTree EmptyTree)),
    [5, 3, 7, 9, 6] ==> Node 5 (Node 3 EmptyTree EmptyTree) (Node 7 (Node 6 EmptyTree EmptyTree) (Node 9 EmptyTree EmptyTree))]

append :: Ord a => Tree a -> a -> Tree a
append EmptyTree x = fromValue x
append (Node value left right) x
    | x < value = Node value (append left x) right
    | otherwise = Node value left (append right x)

appendTests = testsFromActualExpectedPairs "append" [
    -- パターンのテストは fromValues のテストでカバーするため,
    -- ここでは EmptyTree とそうではない場合のテストだけおこなう.
    append EmptyTree 1 ==> Node 1 EmptyTree EmptyTree,
    append EmptyTree 2 ==> Node 2 EmptyTree EmptyTree,
    append (Node 2 EmptyTree EmptyTree) 3 ==> Node 2 EmptyTree (Node 3 EmptyTree EmptyTree)]

popMin :: Ord a => NonEmptyTree a -> (a, Tree a)
popMin (NonEmptyTree value left right) = popMin' (Node value left right)
    where
        popMin' (Node value EmptyTree right) = (value, right)
        popMin' (Node value left right) =
            let
                (minValue, newLeft) = popMin' left
            in
                (minValue, Node value newLeft right)

popMinTests = testsFromArgumentExpectedPairs "popMin" popMin [
    NonEmptyTree 5 (Node 3 (Node 1 EmptyTree EmptyTree) (Node 4 EmptyTree EmptyTree)) (Node 7 EmptyTree EmptyTree)
        ==> (1, Node 5 (Node 3 EmptyTree (Node 4 EmptyTree EmptyTree)) (Node 7 EmptyTree EmptyTree)),
    NonEmptyTree 5 (Node 3 EmptyTree (Node 4 EmptyTree EmptyTree)) (Node 7 EmptyTree EmptyTree)
        ==> (3, Node 5 (Node 4 EmptyTree EmptyTree) (Node 7 EmptyTree EmptyTree)),
    NonEmptyTree 5 (Node 4 EmptyTree EmptyTree) (Node 7 EmptyTree EmptyTree)
        ==> (4, Node 5 EmptyTree (Node 7 EmptyTree EmptyTree)),
    NonEmptyTree 5 EmptyTree (Node 7 EmptyTree EmptyTree)
        ==> (5, Node 7 EmptyTree EmptyTree),
    NonEmptyTree 7 EmptyTree EmptyTree
        ==> (7, EmptyTree)]

popMax :: Ord a => NonEmptyTree a -> (a, Tree a)
popMax (NonEmptyTree value left right) = popMax' (Node value left right)
    where
        popMax' (Node value left EmptyTree) = (value, left)
        popMax' (Node value left right) =
            let
                (maxValue, newRight) = popMax' right
            in
                (maxValue, Node value left newRight)

popMaxTests = testsFromArgumentExpectedPairs "popMax" popMax [
    NonEmptyTree 5 (Node 3 (Node 1 EmptyTree EmptyTree) (Node 4 EmptyTree EmptyTree)) (Node 7 EmptyTree EmptyTree)
        ==> (7, Node 5 (Node 3 (Node 1 EmptyTree EmptyTree) (Node 4 EmptyTree EmptyTree)) EmptyTree),
    NonEmptyTree 5 (Node 3 (Node 1 EmptyTree EmptyTree) (Node 4 EmptyTree EmptyTree)) EmptyTree
        ==> (5, Node 3 (Node 1 EmptyTree EmptyTree) (Node 4 EmptyTree EmptyTree)),
    NonEmptyTree 3 (Node 1 EmptyTree EmptyTree) (Node 4 EmptyTree EmptyTree)
        ==> (4, Node 3 (Node 1 EmptyTree EmptyTree) EmptyTree),
    NonEmptyTree 3 (Node 1 EmptyTree EmptyTree) EmptyTree
        ==> (3, Node 1 EmptyTree EmptyTree),
    NonEmptyTree 1 EmptyTree EmptyTree
        ==> (1, EmptyTree)]

instance Functor Tree where
    fmap f EmptyTree = EmptyTree
    fmap f (Node value left right) = Node (f value) (fmap f left) (fmap f right)

fmapTreeTests = testsFromActualExpectedPairs "fmap Tree" [
    fmap (+1) EmptyTree
        ==> EmptyTree,
    fmap (+1) (Node 5 EmptyTree EmptyTree)
        ==> (Node 6 EmptyTree EmptyTree),
    fmap (+1) (Node 5 (Node 3 EmptyTree EmptyTree) (Node 7 EmptyTree EmptyTree))
        ==> (Node 6 (Node 4 EmptyTree EmptyTree) (Node 8 EmptyTree EmptyTree)),
    fmap (+1) (Node 5 (Node 3 (Node 1 EmptyTree EmptyTree) (Node 4 EmptyTree EmptyTree))
                      (Node 7 (Node 6 EmptyTree EmptyTree) (Node 9 EmptyTree EmptyTree)))
        ==> (Node 6 (Node 4 (Node 2 EmptyTree EmptyTree) (Node 5 EmptyTree EmptyTree))
                    (Node 8 (Node 7 EmptyTree EmptyTree) (Node 10 EmptyTree EmptyTree))),
    fmap (*2) (Node 5 EmptyTree EmptyTree) ==> (Node 10 EmptyTree EmptyTree)]

instance Show a => Show (Tree a) where
    show tree = "Tree {" ++ show' tree ++ "}"
        where
            show' EmptyTree = "()"
            show' (Node value EmptyTree EmptyTree) = "(" ++ show value ++ ")"
            show' (Node value left right) = "(" ++ show value ++ show' left ++ show' right ++ ")"

showTreeTests = testsFromArgumentExpectedPairs "show (Tree a)" show [
    EmptyTree
        ==> "Tree {()}",
    Node 5 EmptyTree EmptyTree
        ==> "Tree {(5)}",
    Node 5 (Node 3 EmptyTree EmptyTree) (Node 7 EmptyTree EmptyTree)
        ==> "Tree {(5(3)(7))}",
    Node 5 (Node 3 (Node 1 EmptyTree EmptyTree) (Node 4 EmptyTree EmptyTree))
                   (Node 7 (Node 6 EmptyTree EmptyTree) (Node 9 EmptyTree EmptyTree))
        ==> "Tree {(5(3(1)(4))(7(6)(9)))}"]

