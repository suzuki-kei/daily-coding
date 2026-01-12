{- cabal:
    build-depends: base, HUnit
-}

import Test.HUnit

main :: IO ()
main = do
    runTestTT allTestList
    pure ()

allTestList = TestList [
    parseNonEmptyTreeTestList,
    fromValueTestList,
    fromValuesTestList,
    appendTestList,
    popTestList,
    popNTestList,
    showTreeTestList,
    fmapTreeTestList]

data Tree a = EmptyTree | Node {nodeValue :: a,
                                nodeLeft  :: Tree a,
                                nodeRight :: Tree a}
    deriving Eq

data NonEmptyTree a = NonEmptyTree a (Tree a) (Tree a)
    deriving (Eq, Show)

parseNonEmptyTree :: Tree a -> Maybe (NonEmptyTree a)
parseNonEmptyTree EmptyTree               = Nothing
parseNonEmptyTree (Node value left right) = Just (NonEmptyTree value left right)

parseNonEmptyTreeTestList = test [
    "parseNonEmptyTreeTestList" ~: "#1" ~: Nothing ~=? parseNonEmptyTree (EmptyTree :: Tree Int),
    "parseNonEmptyTreeTestList" ~: "#2" ~: Just (NonEmptyTree 1 EmptyTree EmptyTree) ~=? parseNonEmptyTree (fromValues [1])]

fromValue :: a -> Tree a
fromValue x = Node x EmptyTree EmptyTree

fromValueTestList = test [
    "fromValue" ~: "#1" ~: (Node 1 EmptyTree EmptyTree) ~=? fromValue 1,
    "fromValue" ~: "#2" ~: (Node 2 EmptyTree EmptyTree) ~=? fromValue 2,
    "fromValue" ~: "#3" ~: (Node 3 EmptyTree EmptyTree) ~=? fromValue 3]

fromValues :: Ord a => [a] -> Tree a
fromValues xs = foldl append EmptyTree xs

fromValuesTestList = test [
    "fromValues" ~: "#1" ~: EmptyTree ~=? fromValues ([] :: [Int]),
    "fromValues" ~: "#2" ~: (Node 1 EmptyTree EmptyTree) ~=? fromValues [1],
    "fromValues" ~: "#3" ~: (Node 1 EmptyTree (Node 2 EmptyTree EmptyTree)) ~=? fromValues [1, 2],
    "fromValues" ~: "#4" ~: (Node 2 (Node 1 EmptyTree EmptyTree) EmptyTree) ~=? fromValues [2, 1],
    "fromValues" ~: "#5" ~: (Node 5 (Node 2 (Node 1 EmptyTree EmptyTree) (Node 3 EmptyTree EmptyTree)) (Node 7 (Node 6 EmptyTree EmptyTree) EmptyTree)) ~=? fromValues [5, 2, 1, 3, 7, 6]]

append :: Ord a => Tree a -> a -> Tree a
append EmptyTree x =
    Node x EmptyTree EmptyTree
append (Node value left right) x
    | x < value = Node value (append left x) right
    | otherwise = Node value left (append right x)

appendTestList = test [
    "append" ~: "#1" ~: (Node 5 EmptyTree EmptyTree) ~=? append EmptyTree 5,
    "append" ~: "#2" ~: (Node 5 (Node 2 EmptyTree EmptyTree) EmptyTree) ~=? append (Node 5 EmptyTree EmptyTree) 2,
    "append" ~: "#3" ~: (Node 5 (Node 2 (Node 1 EmptyTree EmptyTree) EmptyTree) EmptyTree) ~=? append (Node 5 (Node 2 EmptyTree EmptyTree) EmptyTree) 1,
    "append" ~: "#4" ~: (Node 5 (Node 2 (Node 1 EmptyTree EmptyTree) (Node 3 EmptyTree EmptyTree)) EmptyTree) ~=? append (Node 5 (Node 2 (Node 1 EmptyTree EmptyTree) EmptyTree) EmptyTree) 3,
    "append" ~: "#5" ~: (Node 5 (Node 2 (Node 1 EmptyTree EmptyTree) (Node 3 EmptyTree EmptyTree)) (Node 7 EmptyTree EmptyTree)) ~=? append (Node 5 (Node 2 (Node 1 EmptyTree EmptyTree) (Node 3 EmptyTree EmptyTree)) EmptyTree) 7,
    "append" ~: "#6" ~: (Node 5 (Node 2 (Node 1 EmptyTree EmptyTree) (Node 3 EmptyTree EmptyTree)) (Node 7 (Node 6 EmptyTree EmptyTree) EmptyTree)) ~=? append (Node 5 (Node 2 (Node 1 EmptyTree EmptyTree) (Node 3 EmptyTree EmptyTree)) (Node 7 EmptyTree EmptyTree)) 6]

pop :: NonEmptyTree a -> (a, Tree a)
pop (NonEmptyTree value left right) = (value, pop' (Node value left right))
    where
        pop' EmptyTree                    = EmptyTree
        pop' (Node value left EmptyTree)  = left
        pop' (Node value EmptyTree right) = right
        pop' (Node value left right)      = Node (nodeValue left) (pop' left) right

popTestList = test [
    "pop" ~: "#1" ~: (5, EmptyTree) ~=? pop (NonEmptyTree 5 EmptyTree EmptyTree),
    "pop" ~: "#2" ~: (5, Node 3 EmptyTree EmptyTree) ~=? pop (NonEmptyTree 5 (Node 3 EmptyTree EmptyTree) EmptyTree),
    "pop" ~: "#3" ~: (3, Node 5 EmptyTree EmptyTree) ~=? pop (NonEmptyTree 3 EmptyTree (Node 5 EmptyTree EmptyTree)),
    "pop" ~: "#4" ~: (5, Node 3 EmptyTree (Node 7 EmptyTree EmptyTree)) ~=? pop (NonEmptyTree 5 (Node 3 EmptyTree EmptyTree) (Node 7 EmptyTree EmptyTree)),
    "pop" ~: "#5" ~: (5, Node 3 (Node 1 EmptyTree EmptyTree) (Node 7 EmptyTree EmptyTree)) ~=? pop (NonEmptyTree 5 (Node 3 (Node 1 EmptyTree EmptyTree) EmptyTree) (Node 7 EmptyTree EmptyTree))]

popN :: Ord a => Tree a -> Int -> ([a], Tree a)
popN tree n = popN' tree n []
    where
        popN' tree 0 xs                    = (reverse xs, tree)
        popN' EmptyTree n xs               = (reverse xs, EmptyTree)
        popN' (Node value left right) n xs =
            let
                (x, tree') = pop (NonEmptyTree value left right)
            in
                popN' tree' (n - 1) (x : xs)

popNTestList = test [
    "popN" ~: "#1" ~: ([], EmptyTree) ~=? popN (EmptyTree :: Tree Int) 0,
    "popN" ~: "#2" ~: ([], EmptyTree) ~=? popN (EmptyTree :: Tree Int) 1,
    "popN" ~: "#3" ~: ([], (Node 5 (Node 3 EmptyTree EmptyTree) (Node 7 EmptyTree EmptyTree))) ~=? popN (Node 5 (Node 3 EmptyTree EmptyTree) (Node 7 EmptyTree EmptyTree)) 0,
    "popN" ~: "#4" ~: ([5], (Node 3 EmptyTree (Node 7 EmptyTree EmptyTree))) ~=? popN (Node 5 (Node 3 EmptyTree EmptyTree) (Node 7 EmptyTree EmptyTree)) 1,
    "popN" ~: "#5" ~: ([5, 3], (Node 7 EmptyTree EmptyTree)) ~=? popN (Node 5 (Node 3 EmptyTree EmptyTree) (Node 7 EmptyTree EmptyTree)) 2,
    "popN" ~: "#6" ~: ([5, 3, 7], EmptyTree) ~=? popN (Node 5 (Node 3 EmptyTree EmptyTree) (Node 7 EmptyTree EmptyTree)) 3,
    "popN" ~: "#7" ~: ([5, 3, 7], EmptyTree) ~=? popN (Node 5 (Node 3 EmptyTree EmptyTree) (Node 7 EmptyTree EmptyTree)) 4]

instance Show a => Show (Tree a) where
    show tree = "Tree {" ++ (show' tree) ++ "}"
        where
            show' EmptyTree                        = "()"
            show' (Node value EmptyTree EmptyTree) = "(" ++ (show value) ++ ")"
            show' (Node value left right)          = "(" ++ (show value) ++ " " ++ (show' left) ++ " " ++ (show' right) ++ ")"

showTreeTestList = test [
    "show (Tree a)" ~: "#1" ~: "Tree {()}" ~=? show (fromValues ([] :: [Int])),
    "show (Tree a)" ~: "#2" ~: "Tree {(5)}" ~=? show (fromValues [5]),
    "show (Tree a)" ~: "#3" ~: "Tree {(5 (2) ())}" ~=? show (fromValues [5, 2]),
    "show (Tree a)" ~: "#4" ~: "Tree {(5 (2 (1) ()) ())}" ~=? show (fromValues [5, 2, 1]),
    "show (Tree a)" ~: "#5" ~: "Tree {(5 (2 (1) (3)) ())}" ~=? show (fromValues [5, 2, 1, 3]),
    "show (Tree a)" ~: "#6" ~: "Tree {(5 (2 (1) (3)) (7))}" ~=? show (fromValues [5, 2, 1, 3, 7]),
    "show (Tree a)" ~: "#7" ~: "Tree {(5 (2 (1) (3)) (7 (6) ()))}" ~=? show (fromValues [5, 2, 1, 3, 7, 6])]

instance Functor Tree where
    fmap f EmptyTree               = EmptyTree
    fmap f (Node value left right) = Node (f value) (fmap f left) (fmap f right)

fmapTreeTestList = test [
    "fmap (Tree a)" ~: "#1" ~: EmptyTree ~=? fmap (+1) EmptyTree,
    "fmap (Tree a)" ~: "#2" ~: fromValues [6, 3, 2, 4, 8, 7] ~=? fmap (+1) (fromValues [5, 2, 1, 3, 7, 6]),
    "fmap (Tree a)" ~: "#3" ~: fromValues [10, 4, 2, 6, 14, 12] ~=? fmap (*2) (fromValues [5, 2, 1, 3, 7, 6])]

