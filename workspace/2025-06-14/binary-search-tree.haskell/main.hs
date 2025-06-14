{- cabal:
    build-depends: base, HUnit
-}

import Test.HUnit

main :: IO ()
main = do
    runTestTT allTests
    pure ()

allTests = TestList [
    fromValueTests,
    fromValuesTests,
    appendTests,
    appendsTests,
    popTests,
    showTreeTests,
    fmapTreeTests]

data Tree a = EmptyTree | Node {nodeValue :: a,
                                nodeLeft  :: Tree a,
                                nodeRight :: Tree a}
    deriving Eq

data NonEmptyTree a = NonEmptyTree a (Tree a) (Tree a)
    deriving (Eq, Show)

parseNonEmptyTree :: Tree a -> Maybe (NonEmptyTree a)
parseNonEmptyTree EmptyTree               = Nothing
parseNonEmptyTree (Node value left right) = Just (NonEmptyTree value left right)

fromValue :: a -> Tree a
fromValue x = Node x EmptyTree EmptyTree

fromValueTests = test [
    "fromValue" ~: "#1" ~: Node 1 EmptyTree EmptyTree ~=? fromValue 1,
    "fromValue" ~: "#2" ~: Node 2 EmptyTree EmptyTree ~=? fromValue 2,
    "fromValue" ~: "#3" ~: Node 3 EmptyTree EmptyTree ~=? fromValue 3]

fromValues :: Ord a => [a] -> Tree a
fromValues xs = appends EmptyTree xs

fromValuesTests = test [
    "fromValues" ~: "#1" ~: Node 5 EmptyTree EmptyTree ~=? fromValues [5],
    "fromValues" ~: "#2" ~: Node 5 (Node 3 EmptyTree EmptyTree) EmptyTree ~=? fromValues [5, 3],
    "fromValues" ~: "#3" ~: Node 5 (Node 3 EmptyTree (Node 4 EmptyTree EmptyTree)) EmptyTree ~=? fromValues [5, 3, 4],
    "fromValues" ~: "#4" ~: Node 5 (Node 3 (Node 1 EmptyTree EmptyTree) (Node 4 EmptyTree EmptyTree)) EmptyTree ~=? fromValues [5, 3, 4, 1],
    "fromValues" ~: "#5" ~: Node 5 (Node 3 (Node 1 EmptyTree EmptyTree) (Node 4 EmptyTree EmptyTree)) (Node 7 EmptyTree EmptyTree) ~=? fromValues [5, 3, 4, 1, 7],
    "fromValues" ~: "#5" ~: Node 5 (Node 3 (Node 1 EmptyTree EmptyTree) (Node 4 EmptyTree EmptyTree)) (Node 7 EmptyTree (Node 9 EmptyTree EmptyTree)) ~=? fromValues [5, 3, 4, 1, 7, 9],
    "fromValues" ~: "#5" ~: Node 5 (Node 3 (Node 1 EmptyTree EmptyTree) (Node 4 EmptyTree EmptyTree)) (Node 7 (Node 6 EmptyTree EmptyTree) (Node 9 EmptyTree EmptyTree)) ~=? fromValues [5, 3, 4, 1, 7, 9, 6]]

append :: Ord a => Tree a -> a -> Tree a
append EmptyTree x = fromValue x
append (Node value left right) x
    | x < value = Node value (append left x) right
    | otherwise = Node value left (append right x)

appendTests = test [
    "append" ~: "#1" ~: Node 5 EmptyTree EmptyTree ~=? append EmptyTree 5,
    "append" ~: "#2" ~: Node 5 (Node 3 EmptyTree EmptyTree) EmptyTree ~=? append (Node 5 EmptyTree EmptyTree) 3,
    "append" ~: "#3" ~: Node 5 (Node 3 EmptyTree (Node 4 EmptyTree EmptyTree)) EmptyTree ~=? append (Node 5 (Node 3 EmptyTree EmptyTree) EmptyTree) 4,
    "append" ~: "#4" ~: Node 5 (Node 3 (Node 1 EmptyTree EmptyTree) EmptyTree) EmptyTree ~=? append (Node 5 (Node 3 EmptyTree EmptyTree) EmptyTree) 1,
    "append" ~: "#5" ~: Node 5 EmptyTree (Node 7 EmptyTree EmptyTree) ~=? append (Node 5 EmptyTree EmptyTree) 7,
    "append" ~: "#6" ~: Node 5 EmptyTree (Node 7 EmptyTree (Node 9 EmptyTree EmptyTree)) ~=? append (Node 5 EmptyTree (Node 7 EmptyTree EmptyTree)) 9,
    "append" ~: "#7" ~: Node 5 EmptyTree (Node 7 (Node 6 EmptyTree EmptyTree) EmptyTree) ~=? append (Node 5 EmptyTree (Node 7 EmptyTree EmptyTree)) 6]

appends :: Ord a => Tree a -> [a] -> Tree a
appends tree xs = foldl append tree xs

appendsTests = test [
    "appends" ~: "#1" ~: Node 5 EmptyTree EmptyTree ~=? appends EmptyTree [5],
    "appends" ~: "#2" ~: Node 5 (Node 3 EmptyTree EmptyTree) EmptyTree ~=? appends EmptyTree [5, 3],
    "appends" ~: "#3" ~: Node 5 (Node 3 EmptyTree EmptyTree) EmptyTree ~=? appends (Node 5 EmptyTree EmptyTree) [3],
    "appends" ~: "#4" ~: Node 5 (Node 3 EmptyTree (Node 4 EmptyTree EmptyTree)) EmptyTree ~=? appends EmptyTree [5, 3, 4],
    "appends" ~: "#5" ~: Node 5 (Node 3 EmptyTree (Node 4 EmptyTree EmptyTree)) EmptyTree ~=? appends (Node 5 (Node 3 EmptyTree EmptyTree) EmptyTree) [4],
    "appends" ~: "#6" ~: Node 5 (Node 3 (Node 1 EmptyTree EmptyTree) EmptyTree) EmptyTree ~=? appends EmptyTree [5, 3, 1],
    "appends" ~: "#7" ~: Node 5 (Node 3 (Node 1 EmptyTree EmptyTree) EmptyTree) EmptyTree ~=? appends (Node 5 (Node 3 EmptyTree EmptyTree) EmptyTree) [1],
    "appends" ~: "#8" ~: Node 5 EmptyTree (Node 7 EmptyTree EmptyTree) ~=? appends EmptyTree [5, 7],
    "appends" ~: "#9" ~: Node 5 EmptyTree (Node 7 EmptyTree EmptyTree) ~=? appends (Node 5 EmptyTree EmptyTree) [7],
    "appends" ~: "#10" ~: Node 5 EmptyTree (Node 7 EmptyTree (Node 9 EmptyTree EmptyTree)) ~=? appends EmptyTree [5, 7, 9],
    "appends" ~: "#11" ~: Node 5 EmptyTree (Node 7 EmptyTree (Node 9 EmptyTree EmptyTree)) ~=? appends (Node 5 EmptyTree (Node 7 EmptyTree EmptyTree)) [9],
    "appends" ~: "#12" ~: Node 5 EmptyTree (Node 7 (Node 6 EmptyTree EmptyTree) EmptyTree) ~=? appends EmptyTree [5, 7, 6],
    "appends" ~: "#13" ~: Node 5 EmptyTree (Node 7 (Node 6 EmptyTree EmptyTree) EmptyTree) ~=? appends (Node 5 EmptyTree (Node 7 EmptyTree EmptyTree)) [6]]

pop :: NonEmptyTree a -> (a, Tree a)
pop (NonEmptyTree value left right) =
    let
        tree' = pop' (Node value left right)
    in
        (value, tree')
    where
        pop' (Node value EmptyTree EmptyTree) = EmptyTree
        pop' (Node value left EmptyTree) = left
        pop' (Node value EmptyTree right) = right
        pop' (Node value left right) = Node (nodeValue left) (nodeRight left) right

popTests = test [
    "pop" ~: "#1" ~: (1, EmptyTree) ~=? pop (NonEmptyTree 1 EmptyTree EmptyTree),
    "pop" ~: "#2" ~: (2, EmptyTree) ~=? pop (NonEmptyTree 2 EmptyTree EmptyTree),
    "pop" ~: "#3" ~: (3, EmptyTree) ~=? pop (NonEmptyTree 3 EmptyTree EmptyTree),
    "pop" ~: "#4" ~: (5, (Node 3 EmptyTree EmptyTree)) ~=? pop (NonEmptyTree 5 (Node 3 EmptyTree EmptyTree) EmptyTree),
    "pop" ~: "#4" ~: (5, (Node 3 (Node 1 EmptyTree EmptyTree) EmptyTree)) ~=? pop (NonEmptyTree 5 (Node 3 (Node 1 EmptyTree EmptyTree) EmptyTree) EmptyTree),
    "pop" ~: "#4" ~: (5, (Node 3 EmptyTree (Node 7 EmptyTree EmptyTree))) ~=? pop (NonEmptyTree 5 (Node 3 EmptyTree (Node 7 EmptyTree EmptyTree)) EmptyTree),
    "pop" ~: "#5" ~: (5, (Node 7 EmptyTree EmptyTree)) ~=? pop (NonEmptyTree 5 EmptyTree (Node 7 EmptyTree EmptyTree)),
    "pop" ~: "#5" ~: (5, (Node 7 EmptyTree (Node 9 EmptyTree EmptyTree))) ~=? pop (NonEmptyTree 5 EmptyTree (Node 7 EmptyTree (Node 9 EmptyTree EmptyTree))),
    "pop" ~: "#5" ~: (5, (Node 7 (Node 6 EmptyTree EmptyTree) EmptyTree)) ~=? pop (NonEmptyTree 5 EmptyTree (Node 7 (Node 6 EmptyTree EmptyTree) EmptyTree))]

instance Show a => Show (Tree a) where
    show tree = "Tree {" ++ show' tree ++ "}"
        where
            show' EmptyTree                        = "()"
            show' (Node value EmptyTree EmptyTree) = "(" ++ show value ++ ")"
            show' (Node value left right)          = "(" ++ show value ++ show' left ++ show' right ++ ")"

showTreeTests = test [
    "show (Tree a)" ~: "#1" ~: "Tree {()}" ~=? show (EmptyTree :: Tree Int),
    "show (Tree a)" ~: "#2" ~: "Tree {(5)}" ~=? show (Node 5 EmptyTree EmptyTree),
    "show (Tree a)" ~: "#3" ~: "Tree {(5(3)())}" ~=? show (Node 5 (Node 3 EmptyTree EmptyTree) EmptyTree),
    "show (Tree a)" ~: "#4" ~: "Tree {(5()(4))}" ~=? show (Node 5 EmptyTree (Node 4 EmptyTree EmptyTree)),
    "show (Tree a)" ~: "#5" ~: "Tree {(5(3()(4))())}" ~=? show (Node 5 (Node 3 EmptyTree (Node 4 EmptyTree EmptyTree)) EmptyTree),
    "show (Tree a)" ~: "#6" ~: "Tree {(5()(7))}" ~=? show (Node 5 EmptyTree (Node 7 EmptyTree EmptyTree)),
    "show (Tree a)" ~: "#7" ~: "Tree {(5()(7))}" ~=? show (Node 5 EmptyTree (Node 7 EmptyTree EmptyTree)),
    "show (Tree a)" ~: "#8" ~: "Tree {(5()(7(6)()))}" ~=? show (Node 5 EmptyTree (Node 7 (Node 6 EmptyTree EmptyTree) EmptyTree)),
    "show (Tree a)" ~: "#9" ~: "Tree {(5()(7()(9)))}" ~=? show (Node 5 EmptyTree (Node 7 EmptyTree (Node 9 EmptyTree EmptyTree))),
    "show (Tree a)" ~: "#10" ~: "Tree {(5()(7(6)(9)))}" ~=? show (Node 5 EmptyTree (Node 7 (Node 6 EmptyTree EmptyTree) (Node 9 EmptyTree EmptyTree)))]

instance Functor Tree where
    fmap f EmptyTree               = EmptyTree
    fmap f (Node value left right) = Node (f value) (fmap f left) (fmap f right)

fmapTreeTests = test [
    "fmap Tree" ~: "#1" ~: EmptyTree ~=? fmap (+1) (EmptyTree :: Tree Int),
    "fmap Tree" ~: "#2" ~: fromValues [6] ~=? fmap (+1) (fromValues [5]),
    "fmap Tree" ~: "#3" ~: fromValues [6, 4] ~=? fmap (+1) (fromValues [5, 3]),
    "fmap Tree" ~: "#4" ~: fromValues [6, 4, 5] ~=? fmap (+1) (fromValues [5, 3, 4]),
    "fmap Tree" ~: "#5" ~: fromValues [6, 4, 5, 8] ~=? fmap (+1) (fromValues [5, 3, 4, 7]),
    "fmap Tree" ~: "#6" ~: fromValues [6, 4, 5, 8, 7] ~=? fmap (+1) (fromValues [5, 3, 4, 7, 6]),
    "fmap Tree" ~: "#7" ~: fromValues [6, 4, 5, 8, 7, 10] ~=? fmap (+1) (fromValues [5, 3, 4, 7, 6, 9]),
    "fmap Tree" ~: "#8" ~:  fromValues [10] ~=? fmap (*2) (fromValues [5]),
    "fmap Tree" ~: "#9" ~:  fromValues [10, 6] ~=? fmap (*2) (fromValues [5, 3]),
    "fmap Tree" ~: "#10" ~: fromValues [10, 6, 8] ~=? fmap (*2) (fromValues [5, 3, 4]),
    "fmap Tree" ~: "#11" ~: fromValues [10, 6, 8, 14] ~=? fmap (*2) (fromValues [5, 3, 4, 7]),
    "fmap Tree" ~: "#12" ~: fromValues [10, 6, 8, 14, 12] ~=? fmap (*2) (fromValues [5, 3, 4, 7, 6]),
    "fmap Tree" ~: "#13" ~: fromValues [10, 6, 8, 14, 12, 18] ~=? fmap (*2) (fromValues [5, 3, 4, 7, 6, 9])]

