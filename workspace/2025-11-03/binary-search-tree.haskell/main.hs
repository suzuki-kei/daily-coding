{- cabal:
    build-depends: base, HUnit
-}

import Test.HUnit ((~:))
import Test.HUnit ((~=?))
import Test.HUnit (Test (TestList))
import Test.HUnit (Test)
import Test.HUnit (runTestTTAndExit)
import Test.HUnit (test)
import Text.Printf (printf)

main :: IO ()
main = runTestTTAndExit allTests

infix 1 ==>
(==>) :: a -> b -> (a, b)
(==>) a b = (a, b)

testsFromActualExpectedPairs :: (Eq a, Show a) => String -> [(a, a)] -> Test
testsFromActualExpectedPairs label pairs =
    let
        ns     = [1..] :: [Int]
        labels = map (\n -> printf "%s #%d" label n) ns
        zipper = (\label (actual, expected) -> label ~: actual ~=? expected)
        tests  = zipWith zipper labels pairs
    in
        test tests

testsFromArgumentExpectedPairs ::
    (Eq b, Show b) => String -> (a -> b) -> [(a, b)] -> Test
testsFromArgumentExpectedPairs label f pairs =
    let
        mapper = (\(argument, expected) -> (f argument, expected))
        pairs' = map mapper pairs
    in
        testsFromActualExpectedPairs label pairs'

allTests :: Test
allTests = TestList [
    fromValueTests,
    fromValuesTests,
    appendTests,
    appendsTests,
    popMinTests,
    fmapTreeTests]

data Tree a = EmptyTree
            | Node {nodeValue :: a,
                    nodeLeft  :: Tree a,
                    nodeRight :: Tree a}
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
    testsFromArgumentExpectedPairs "fromValues" fromValues [
        [] ==>
            EmptyTree,
        [5] ==>
            Node 5 EmptyTree EmptyTree,
        [5, 3] ==>
            Node 5 (Node 3 EmptyTree EmptyTree)
                   EmptyTree,
        [5, 3, 7] ==>
            Node 5 (Node 3 EmptyTree EmptyTree)
                   (Node 7 EmptyTree EmptyTree),
        [5, 3, 7, 4] ==>
            Node 5 (Node 3 EmptyTree (Node 4 EmptyTree EmptyTree))
                   (Node 7 EmptyTree EmptyTree),
        [5, 3, 7, 4, 9] ==>
            Node 5 (Node 3 EmptyTree (Node 4 EmptyTree EmptyTree))
                   (Node 7 EmptyTree (Node 9 EmptyTree EmptyTree)),
        [5, 3, 7, 4, 9, 1] ==>
            Node 5 (Node 3 (Node 1 EmptyTree EmptyTree)
                           (Node 4 EmptyTree EmptyTree))
                   (Node 7 EmptyTree (Node 9 EmptyTree EmptyTree)),
        [5, 3, 7, 4, 9, 1, 6] ==>
            Node 5 (Node 3 (Node 1 EmptyTree EmptyTree)
                           (Node 4 EmptyTree EmptyTree))
                   (Node 7 (Node 6 EmptyTree EmptyTree)
                           (Node 9 EmptyTree EmptyTree))]

append :: Ord a => Tree a -> a -> Tree a
append EmptyTree x = Node x EmptyTree EmptyTree
append (Node value left right) x
    | x < value = Node value (append left x) right
    | otherwise = Node value left (append right x)

appendTests :: Test
appendTests = testsFromActualExpectedPairs "append" [
    append EmptyTree 1 ==>
        Node 1 EmptyTree EmptyTree,
    append EmptyTree 2 ==>
        Node 2 EmptyTree EmptyTree,
    append EmptyTree 3 ==>
        Node 3 EmptyTree EmptyTree,
    append (Node 5 EmptyTree EmptyTree) 3 ==>
        (Node 5 (Node 3 EmptyTree EmptyTree) EmptyTree),
    append (Node 5 EmptyTree EmptyTree) 7 ==>
        (Node 5 EmptyTree (Node 7 EmptyTree EmptyTree))]

appends :: (Ord a) => Tree a -> [a] -> Tree a
appends tree [] = tree
appends tree (x:xs) = appends (append tree x) xs

appendsTests :: Test
appendsTests = testsFromActualExpectedPairs "appends" [
    appends EmptyTree [] ==>
        EmptyTree,
    appends (Node 5 EmptyTree EmptyTree) [] ==>
        Node 5 EmptyTree EmptyTree,
    appends (Node 5 EmptyTree EmptyTree) [3] ==>
        Node 5 (Node 3 EmptyTree EmptyTree)
               EmptyTree,
    appends (Node 5 EmptyTree EmptyTree) [3, 7] ==>
        Node 5 (Node 3 EmptyTree EmptyTree)
               (Node 7 EmptyTree EmptyTree),
    appends (Node 5 EmptyTree EmptyTree) [3, 7, 4] ==>
        Node 5 (Node 3 EmptyTree (Node 4 EmptyTree EmptyTree))
               (Node 7 EmptyTree EmptyTree),
    appends (Node 5 EmptyTree EmptyTree) [3, 7, 4, 9] ==>
        Node 5 (Node 3 EmptyTree (Node 4 EmptyTree EmptyTree))
               (Node 7 EmptyTree (Node 9 EmptyTree EmptyTree)),
    appends (Node 5 EmptyTree EmptyTree) [3, 7, 4, 9, 1] ==>
        Node 5 (Node 3 (Node 1 EmptyTree EmptyTree)
                       (Node 4 EmptyTree EmptyTree))
               (Node 7 EmptyTree (Node 9 EmptyTree EmptyTree)),
    appends (Node 5 EmptyTree EmptyTree) [3, 7, 4, 9, 1, 6] ==>
        Node 5 (Node 3 (Node 1 EmptyTree EmptyTree)
                       (Node 4 EmptyTree EmptyTree))
               (Node 7 (Node 6 EmptyTree EmptyTree)
                       (Node 9 EmptyTree EmptyTree))]

popMin :: Tree a -> Maybe (a, Tree a)
popMin EmptyTree = Nothing
popMin node = Just (popMin' node)
    where
        popMin' (Node value EmptyTree right) =
            (value, right)
        popMin' (Node value left right) =
            let
                (minValue, newLeft) = popMin' left
            in
                (minValue, Node value newLeft right)

popMinTests :: Test
popMinTests = testsFromArgumentExpectedPairs "popMin" popMin [
    fromValues [] ==>
        Nothing,
    fromValues [5] ==>
        Just (5, EmptyTree),
    fromValues [5, 3] ==>
        Just (3, Node 5 EmptyTree EmptyTree),
    fromValues [5, 3, 7] ==>
        Just (3, Node 5 EmptyTree (Node 7 EmptyTree EmptyTree)),
    fromValues [5, 3, 7, 4] ==>
        Just (3, Node 5 (Node 4 EmptyTree EmptyTree)
                        (Node 7 EmptyTree EmptyTree)),
    fromValues [5, 3, 7, 4, 9] ==>
        Just (3, Node 5 (Node 4 EmptyTree EmptyTree)
                        (Node 7 EmptyTree (Node 9 EmptyTree EmptyTree))),
    fromValues [5, 3, 7, 4, 9, 1] ==>
        Just (1, Node 5 (Node 3 EmptyTree (Node 4 EmptyTree EmptyTree))
                        (Node 7 EmptyTree (Node 9 EmptyTree EmptyTree)))]

instance Functor Tree where
    fmap f EmptyTree = EmptyTree
    fmap f (Node value left right) = Node (f value) (fmap f left) (fmap f right)

fmapTreeTests :: Test
fmapTreeTests = testsFromActualExpectedPairs "fmap (Tree a)" [
    fmap (+1) EmptyTree ==>
        EmptyTree,
    fmap (+1) (Node 5 (Node 3 (Node 1 EmptyTree EmptyTree)
                              (Node 4 EmptyTree EmptyTree))
                      (Node 7 (Node 6 EmptyTree EmptyTree)
                              (Node 9 EmptyTree EmptyTree))) ==>
        Node 6 (Node 4 (Node 2 EmptyTree EmptyTree)
                       (Node 5 EmptyTree EmptyTree))
               (Node 8 (Node 7 EmptyTree EmptyTree)
                       (Node 10 EmptyTree EmptyTree)),

    fmap (*2) (Node 5 (Node 3 (Node 1 EmptyTree EmptyTree)
                              (Node 4 EmptyTree EmptyTree))
                      (Node 7 (Node 6 EmptyTree EmptyTree)
                              (Node 9 EmptyTree EmptyTree))) ==>
        Node 10 (Node 6 (Node 2 EmptyTree EmptyTree)
                        (Node 8 EmptyTree EmptyTree))
                (Node 14 (Node 12 EmptyTree EmptyTree)
                         (Node 18 EmptyTree EmptyTree))]

