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
    appendsTests,
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
        labels = map (\n -> printf "%s #%d" label n) ns
        zipper = (\label (actual, expected) -> label ~: actual ~=? expected)
        tests = zipWith zipper labels pairs
    in
        test tests

testsFromArgumentExpectedPairs ::
    (Eq b, Show b) => String -> (a -> b) -> [(a, b)] -> Test
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

data NonEmptyTree a = NonEmptyTree {nonEmptyTreeValue :: a,
                                    nonEmptyTreeLeft  :: Tree a,
                                    nonEmptyTreeRight :: Tree a}
    deriving (Eq, Show)

fromValue :: a -> Tree a
fromValue x = Node x EmptyTree EmptyTree

fromValueTests :: Test
fromValueTests = testsFromArgumentExpectedPairs "fromValue" fromValue [
    1 ==> Node 1 EmptyTree EmptyTree,
    2 ==> Node 2 EmptyTree EmptyTree,
    3 ==> Node 3 EmptyTree EmptyTree]

fromValues :: Ord a => [a] -> Tree a
fromValues xs = appends EmptyTree xs

fromValuesTests :: Test
fromValuesTests =
    let
        expectedForDepth0 = EmptyTree
        expectedForDepth1 = Node 5 EmptyTree EmptyTree
        expectedForDepth2 = Node 5 (Node 3 EmptyTree EmptyTree)
                                   (Node 7 EmptyTree EmptyTree)
        expectedForDepth3 = Node 5 (Node 3 (Node 1 EmptyTree EmptyTree)
                                           (Node 4 EmptyTree EmptyTree))
                                   (Node 7 (Node 6 EmptyTree EmptyTree)
                                           (Node 9 EmptyTree EmptyTree))
    in
        testsFromArgumentExpectedPairs "fromValues" fromValues [
            -- depth=0
            [] ==> expectedForDepth0,
            -- depth=1
            [5] ==> expectedForDepth1,
            -- depth=2
            [5, 3, 7] ==> expectedForDepth2,
            [5, 7, 3] ==> expectedForDepth2,
            -- depth=3
            [5, 3, 1, 4, 7, 6, 9] ==> expectedForDepth3,
            [5, 3, 1, 4, 7, 9, 6] ==> expectedForDepth3,
            [5, 3, 4, 1, 7, 6, 9] ==> expectedForDepth3,
            [5, 7, 6, 9, 3, 1, 4] ==> expectedForDepth3,
            [5, 7, 6, 9, 3, 4, 1] ==> expectedForDepth3,
            [5, 7, 9, 6, 3, 1, 4] ==> expectedForDepth3]

append :: Ord a => Tree a -> a -> Tree a
append EmptyTree x = fromValue x
append (Node value left right) x
    | x < value = Node value (append left x) right
    | otherwise = Node value left (append right x)

appendTests :: Test
appendTests = testsFromActualExpectedPairs "append" [
    -- fromValuesTests でカバーするため append のテストは省略する.
    True ==> True]

appends :: Ord a => Tree a -> [a] -> Tree a
appends tree xs = foldl append tree xs

appendsTests :: Test
appendsTests = testsFromActualExpectedPairs "append" [
    -- fromValuesTests でカバーするため appends のテストは省略する.
    True ==> True]

popMin :: NonEmptyTree a -> (a, Tree a)
popMin (NonEmptyTree value left right) = popMin' (Node value left right)
    where
        popMin' (Node value EmptyTree right) =
            (value, right)
        popMin' (Node value left right) =
            let
                (minValue, newLeft) = popMin' left
            in
                (minValue, Node value newLeft right)

popMinTests :: Test
popMinTests = testsFromActualExpectedPairs "popMin" [
    popMin (NonEmptyTree 5 (Node 3 (Node 1 EmptyTree EmptyTree)
                                   (Node 4 EmptyTree EmptyTree))
                           (Node 7 (Node 6 EmptyTree EmptyTree)
                                   (Node 9 EmptyTree EmptyTree)))
        ==> (1, Node 5 (Node 3 EmptyTree
                               (Node 4 EmptyTree EmptyTree))
                       (Node 7 (Node 6 EmptyTree EmptyTree)
                               (Node 9 EmptyTree EmptyTree))),
    popMin (NonEmptyTree 5 (Node 3 EmptyTree
                                   (Node 4 EmptyTree EmptyTree))
                           (Node 7 (Node 6 EmptyTree EmptyTree)
                                   (Node 9 EmptyTree EmptyTree)))
        ==> (3, Node 5 (Node 4 EmptyTree EmptyTree)
                       (Node 7 (Node 6 EmptyTree EmptyTree)
                               (Node 9 EmptyTree EmptyTree))),
    popMin (NonEmptyTree 5 (Node 4 EmptyTree EmptyTree)
                           (Node 7 (Node 6 EmptyTree EmptyTree)
                                   (Node 9 EmptyTree EmptyTree)))
        ==> (4, Node 5 EmptyTree
                       (Node 7 (Node 6 EmptyTree EmptyTree)
                               (Node 9 EmptyTree EmptyTree))),
    popMin (NonEmptyTree 5 EmptyTree
                           (Node 7 (Node 6 EmptyTree EmptyTree)
                                   (Node 9 EmptyTree EmptyTree)))
        ==> (5, Node 7 (Node 6 EmptyTree EmptyTree)
                       (Node 9 EmptyTree EmptyTree)),
    popMin (NonEmptyTree 5 EmptyTree
                           (Node 7 EmptyTree (Node 9 EmptyTree EmptyTree)))
        ==> (5, Node 7 EmptyTree
                       (Node 9 EmptyTree EmptyTree)),
    popMin (NonEmptyTree 5 EmptyTree (Node 9 EmptyTree EmptyTree))
        ==> (5, Node 9 EmptyTree EmptyTree),
    popMin (NonEmptyTree 9 EmptyTree EmptyTree)
        ==> (9, EmptyTree)]

instance Show a => Show (Tree a) where
    show tree = "Tree {" ++ show' tree ++ "}"
        where
            show' EmptyTree =
                "()"
            show' (Node value EmptyTree EmptyTree) =
                "(" ++ show value ++ ")"
            show' (Node value left right) =
                "(" ++ show value ++ show' left ++ show' right ++ ")"

showTreeTests = testsFromArgumentExpectedPairs "show (Tree a)" show [
    -- depth=0
    EmptyTree
        ==> "Tree {()}",
    -- depth=1
    Node 5 EmptyTree EmptyTree
        ==> "Tree {(5)}",
    -- depth=2
    Node 5 (Node 3 EmptyTree EmptyTree) EmptyTree
        ==> "Tree {(5(3)())}",
    Node 5 EmptyTree (Node 7 EmptyTree EmptyTree)
        ==> "Tree {(5()(7))}",
    Node 5 (Node 3 EmptyTree EmptyTree) (Node 7 EmptyTree EmptyTree)
        ==> "Tree {(5(3)(7))}",
    -- depth=3
    Node 5 (Node 3 (Node 1 EmptyTree EmptyTree) EmptyTree) EmptyTree
        ==> "Tree {(5(3(1)())())}",
    Node 5 (Node 3 EmptyTree (Node 4 EmptyTree EmptyTree)) EmptyTree
        ==> "Tree {(5(3()(4))())}",
    Node 5 (Node 3 (Node 1 EmptyTree EmptyTree) (Node 4 EmptyTree EmptyTree))
                   EmptyTree
        ==> "Tree {(5(3(1)(4))())}",
    Node 5 (Node 3 EmptyTree EmptyTree)
           (Node 7 (Node 6 EmptyTree EmptyTree) EmptyTree)
        ==> "Tree {(5(3)(7(6)()))}",
    Node 5 (Node 3 EmptyTree EmptyTree)
           (Node 7 EmptyTree (Node 9 EmptyTree EmptyTree))
        ==> "Tree {(5(3)(7()(9)))}",
    Node 5 (Node 3 EmptyTree EmptyTree)
           (Node 7 (Node 6 EmptyTree EmptyTree) (Node 9 EmptyTree EmptyTree))
        ==> "Tree {(5(3)(7(6)(9)))}",
    Node 5 (Node 3 (Node 1 EmptyTree EmptyTree) (Node 4 EmptyTree EmptyTree))
           (Node 7 (Node 6 EmptyTree EmptyTree) (Node 9 EmptyTree EmptyTree))
        ==> "Tree {(5(3(1)(4))(7(6)(9)))}"]

instance Functor Tree where
    fmap f EmptyTree =
        EmptyTree
    fmap f (Node value left right) =
        Node (f value) (fmap f left) (fmap f right)

fmapTreeTests :: Test
fmapTreeTests = testsFromActualExpectedPairs "fmap Tree" [
    -- depth=0
    fmap (+1) EmptyTree ==> EmptyTree,
    -- depth=1
    fmap (+1) (Node 1 EmptyTree EmptyTree) ==> Node 2 EmptyTree EmptyTree,
    fmap (+1) (Node 2 EmptyTree EmptyTree) ==> Node 3 EmptyTree EmptyTree,
    -- depth=2
    fmap (+1) (Node 5 (Node 3 EmptyTree EmptyTree)
                      (Node 7 EmptyTree EmptyTree))
        ==> Node 6 (Node 4 EmptyTree EmptyTree)
                   (Node 8 EmptyTree EmptyTree),
    -- depth=3
    fmap (+1) (Node 5 (Node 3 (Node 1 EmptyTree EmptyTree)
                              (Node 4 EmptyTree EmptyTree))
                      (Node 7 (Node 6 EmptyTree EmptyTree)
                              (Node 9 EmptyTree EmptyTree)))
        ==> Node 6 (Node 4 (Node 2 EmptyTree EmptyTree)
                           (Node 5 EmptyTree EmptyTree))
                   (Node 8 (Node 7 EmptyTree EmptyTree)
                           (Node 10 EmptyTree EmptyTree)),
    -- other function
    fmap (*2) (Node 5 (Node 3 (Node 1 EmptyTree EmptyTree)
                              (Node 4 EmptyTree EmptyTree))
                      (Node 7 (Node 6 EmptyTree EmptyTree)
                              (Node 9 EmptyTree EmptyTree)))
        ==> Node 10 (Node 6 (Node 2 EmptyTree EmptyTree)
                            (Node 8 EmptyTree EmptyTree))
                   (Node 14 (Node 12 EmptyTree EmptyTree)
                            (Node 18 EmptyTree EmptyTree))]

