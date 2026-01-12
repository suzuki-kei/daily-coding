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
    showTreeTests,
    fmapTreeTests]

infix 1 ==>
(==>) :: a -> b -> (a, b)
(==>) a b = (a, b)

testsFromActualExpectedPairs :: (Eq a, Show a) => String -> [(a, a)] -> Test
testsFromActualExpectedPairs label pairs =
    let
        ns = [1..] :: [Int]
        tests = zipWith zipper ns pairs
    in
        test tests
    where
        zipper n (actual, expected) =
            printf "%s #%d" label n ~: expected ~=? actual

testsFromArgumentExpectedPairs ::
    (Eq b, Show b) => String -> (a -> b) -> [(a, b)] -> Test
testsFromArgumentExpectedPairs label f pairs =
    let
        actualExpectedPairs = map mapper pairs
    in
        testsFromActualExpectedPairs label actualExpectedPairs
    where
        mapper (argument, expected) = (f argument, expected)

data Tree a = EmptyTree
            | Node {nodeValue :: a,
                    nodeLeft  :: Tree a,
                    nodeRight :: Tree a}
    deriving Eq

data NonEmptyTree a = NonEmptyTree {nonEmptyTreeValue :: a,
                                    nonEmptyTreeLeft  :: Tree a,
                                    nonEmptyTreeRight :: Tree a}
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

    -- depth=2
    [5, 3]
        ==> Node 5 (Node 3 EmptyTree EmptyTree) EmptyTree,
    [5, 7]
        ==> Node 5 EmptyTree (Node 7 EmptyTree EmptyTree),
    [5, 3, 7]
        ==> Node 5 (Node 3 EmptyTree EmptyTree) (Node 7 EmptyTree EmptyTree),
    [5, 7, 3]
        ==> Node 5 (Node 3 EmptyTree EmptyTree) (Node 7 EmptyTree EmptyTree),

    -- depth=3
    [5, 3, 1]
        ==> Node 5 (Node 3 (Node 1 EmptyTree EmptyTree) EmptyTree) EmptyTree,
    [5, 3, 4]
        ==> Node 5 (Node 3 EmptyTree (Node 4 EmptyTree EmptyTree)) EmptyTree,
    [5, 7, 6]
        ==> Node 5 EmptyTree (Node 7 (Node 6 EmptyTree EmptyTree) EmptyTree),
    [5, 7, 9]
        ==> Node 5 EmptyTree (Node 7 EmptyTree (Node 9 EmptyTree EmptyTree)),
    [5, 3, 1, 4]
        ==> Node 5 (Node 3 (Node 1 EmptyTree EmptyTree)
                           (Node 4 EmptyTree EmptyTree))
                   EmptyTree,
    [5, 3, 4, 1]
        ==> Node 5 (Node 3 (Node 1 EmptyTree EmptyTree)
                           (Node 4 EmptyTree EmptyTree))
                   EmptyTree,
    [5, 7, 6, 9]
        ==> Node 5 EmptyTree
                   (Node 7 (Node 6 EmptyTree EmptyTree)
                           (Node 9 EmptyTree EmptyTree)),
    [5, 7, 9, 6]
        ==> Node 5 EmptyTree
                   (Node 7 (Node 6 EmptyTree EmptyTree)
                           (Node 9 EmptyTree EmptyTree))]

append :: Ord a => Tree a -> a -> Tree a
append EmptyTree x = fromValue x
append (Node value left right) x
    | x < value = Node value (append left x) right
    | otherwise = Node value left (append right x)

appendTests = testsFromActualExpectedPairs "append" [
    -- depth=1
    append EmptyTree 5
        ==> Node 5 EmptyTree EmptyTree,

    -- depth=2
    append (append EmptyTree 5) 3
        ==> Node 5 (Node 3 EmptyTree EmptyTree) EmptyTree,
    append (append EmptyTree 5) 7
        ==> Node 5 EmptyTree (Node 7 EmptyTree EmptyTree),
    append (append (append EmptyTree 5) 3) 7
        ==> Node 5 (Node 3 EmptyTree EmptyTree) (Node 7 EmptyTree EmptyTree),
    append (append (append EmptyTree 5) 7) 3
        ==> Node 5 (Node 3 EmptyTree EmptyTree) (Node 7 EmptyTree EmptyTree),

    -- depth=3
    append (append (append EmptyTree 5) 3) 1
        ==> Node 5 (Node 3 (Node 1 EmptyTree EmptyTree) EmptyTree) EmptyTree,
    append (append (append EmptyTree 5) 3) 4
        ==> Node 5 (Node 3 EmptyTree (Node 4 EmptyTree EmptyTree)) EmptyTree,
    append (append (append EmptyTree 5) 7) 6
        ==> Node 5 EmptyTree (Node 7 (Node 6 EmptyTree EmptyTree) EmptyTree),
    append (append (append EmptyTree 5) 7) 9
        ==> Node 5 EmptyTree (Node 7 EmptyTree (Node 9 EmptyTree EmptyTree)),
    append (append (append (append EmptyTree 5) 3) 1) 4
        ==> Node 5 (Node 3 (Node 1 EmptyTree EmptyTree)
                           (Node 4 EmptyTree EmptyTree))
                   EmptyTree,
    append (append (append (append EmptyTree 5) 3) 4) 1
        ==> Node 5 (Node 3 (Node 1 EmptyTree EmptyTree)
                           (Node 4 EmptyTree EmptyTree))
                   EmptyTree,
    append (append (append (append EmptyTree 5) 7) 6) 9
        ==> Node 5 EmptyTree
                   (Node 7 (Node 6 EmptyTree EmptyTree)
                           (Node 9 EmptyTree EmptyTree)),
    append (append (append (append EmptyTree 5) 7) 9) 6
        ==> Node 5 EmptyTree
                   (Node 7 (Node 6 EmptyTree EmptyTree)
                           (Node 9 EmptyTree EmptyTree))]

popMin :: NonEmptyTree a -> (a, Tree a)
popMin (NonEmptyTree value left right) = popMin' (Node value left right)
    where
        popMin' (Node value EmptyTree right) = (value, right)
        popMin' (Node value left right) =
            let
                (minValue, newLeft) = popMin' left
            in
                (minValue, Node value newLeft right)

popMinTests = testsFromActualExpectedPairs "popMin" [
    popMin (NonEmptyTree 5 EmptyTree EmptyTree)
        ==> (5, EmptyTree),

    popMin (NonEmptyTree 5 (Node 3 EmptyTree EmptyTree) EmptyTree)
        ==> (3, Node 5 EmptyTree EmptyTree),
    popMin (NonEmptyTree 5 (Node 3 (Node 1 EmptyTree EmptyTree) EmptyTree)
                           EmptyTree)
        ==> (1, Node 5 (Node 3 EmptyTree EmptyTree) EmptyTree),
    popMin (NonEmptyTree 5 (Node 3 EmptyTree (Node 4 EmptyTree EmptyTree))
                           EmptyTree)
        ==> (3, Node 5 (Node 4 EmptyTree EmptyTree) EmptyTree),

    popMin (NonEmptyTree 5 (Node 3 (Node 1 EmptyTree EmptyTree)
                                   (Node 4 EmptyTree EmptyTree))
                           EmptyTree)
        ==> (1, Node 5 (Node 3 EmptyTree (Node 4 EmptyTree EmptyTree))
                       EmptyTree),
    popMin (NonEmptyTree 5 EmptyTree (Node 7 EmptyTree EmptyTree))
        ==> (5, Node 7 EmptyTree EmptyTree),
    popMin (NonEmptyTree 5 EmptyTree
                           (Node 7 (Node 6 EmptyTree EmptyTree) EmptyTree))
        ==> (5, Node 7 (Node 6 EmptyTree EmptyTree) EmptyTree),
    popMin (NonEmptyTree 5 EmptyTree
                           (Node 7 EmptyTree (Node 9 EmptyTree EmptyTree)))
        ==> (5, Node 7 EmptyTree (Node 9 EmptyTree EmptyTree)),
    popMin (NonEmptyTree 5 EmptyTree
                           (Node 7 (Node 6 EmptyTree EmptyTree)
                                   (Node 9 EmptyTree EmptyTree)))
        ==> (5, Node 7 (Node 6 EmptyTree EmptyTree)
                       (Node 9 EmptyTree EmptyTree))]

instance Show a => Show (Tree a) where
    show tree = "Tree {" ++ show' tree ++ "}"
        where
            show' EmptyTree = "()"
            show' (Node value EmptyTree EmptyTree) = "(" ++ show value ++ ")"
            show' (Node value left right) =
                "(" ++ show value ++ show' left ++ show' right ++ ")"

showTreeTests =
    let
        ns = [5, 3, 7, 1, 4, 9, 6]
    in
        testsFromArgumentExpectedPairs "show (Tree a)" show [
            fromValues (take 0 ns) ==> "Tree {()}",
            fromValues (take 1 ns) ==> "Tree {(5)}",
            fromValues (take 2 ns) ==> "Tree {(5(3)())}",
            fromValues (take 3 ns) ==> "Tree {(5(3)(7))}",
            fromValues (take 4 ns) ==> "Tree {(5(3(1)())(7))}",
            fromValues (take 5 ns) ==> "Tree {(5(3(1)(4))(7))}",
            fromValues (take 6 ns) ==> "Tree {(5(3(1)(4))(7()(9)))}",
            fromValues (take 7 ns) ==> "Tree {(5(3(1)(4))(7(6)(9)))}"]

instance Functor Tree where
    fmap f EmptyTree = EmptyTree
    fmap f (Node value left right) =
        Node (f value) (fmap f left) (fmap f right)

fmapTreeTests = testsFromActualExpectedPairs "fmap Tree" [
    fmap (+1) EmptyTree
        ==> EmptyTree,
    fmap (+1) (Node 1 EmptyTree EmptyTree)
        ==> (Node 2 EmptyTree EmptyTree),
    fmap (+1) (Node 5 (Node 3 (Node 1 EmptyTree EmptyTree)
                              (Node 4 EmptyTree EmptyTree))
                      (Node 7 (Node 6 EmptyTree EmptyTree)
                              (Node 9 EmptyTree EmptyTree)))
        ==> (Node 6 (Node 4 (Node 2 EmptyTree EmptyTree)
                            (Node 5 EmptyTree EmptyTree))
                    (Node 8 (Node 7 EmptyTree EmptyTree)
                            (Node 10 EmptyTree EmptyTree))),
    fmap (*2) (Node 5 (Node 3 (Node 1 EmptyTree EmptyTree)
                              (Node 4 EmptyTree EmptyTree))
                      (Node 7 (Node 6 EmptyTree EmptyTree)
                              (Node 9 EmptyTree EmptyTree)))
        ==> (Node 10 (Node 6 (Node 2 EmptyTree EmptyTree)
                             (Node 8 EmptyTree EmptyTree))
                    (Node 14 (Node 12 EmptyTree EmptyTree)
                             (Node 18EmptyTree EmptyTree)))]

