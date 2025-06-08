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
    toStringTests,
    appendTests,
    popTests,
    functorTreeTests]

data Tree a = EmptyTree | Node {nodeValue :: a,
                                nodeLeft  :: Tree a,
                                nodeRight :: Tree a}
    deriving (Eq, Show)

data NonEmptyTree a = NonEmptyTree a (Tree a) (Tree a)
    deriving (Eq, Show)

fromValue :: a -> Tree a
fromValue x = Node x EmptyTree EmptyTree

fromValueTests = test [
    "fromValue" ~: "#1" ~: Node 1 EmptyTree EmptyTree ~=? fromValue 1,
    "fromValue" ~: "#2" ~: Node 2 EmptyTree EmptyTree ~=? fromValue 2,
    "fromValue" ~: "#3" ~: Node 3 EmptyTree EmptyTree ~=? fromValue 3]

fromValues :: Ord a => [a] -> Tree a
fromValues xs = foldl append EmptyTree xs

fromValuesTests= test [
    "fromValues" ~: "#1" ~: EmptyTree ~=? fromValues ([] :: [Int]),
    "fromValues" ~: "#2" ~: Node 5 EmptyTree EmptyTree ~=? fromValues [5],
    "fromValues" ~: "#3" ~: Node 5 (Node 3 EmptyTree EmptyTree) EmptyTree ~=? fromValues [5, 3],
    "fromValues" ~: "#4" ~: Node 5 (Node 3 EmptyTree EmptyTree) (Node 7 EmptyTree EmptyTree) ~=? fromValues [5, 3, 7],
    "fromValues" ~: "#5" ~: Node 5 (Node 3 EmptyTree (Node 4 EmptyTree EmptyTree)) (Node 7 EmptyTree EmptyTree) ~=? fromValues [5, 3, 7, 4],
    "fromValues" ~: "#6" ~: Node 5 (Node 3 EmptyTree (Node 4 EmptyTree EmptyTree)) (Node 7 (Node 6 EmptyTree EmptyTree) EmptyTree) ~=? fromValues [5, 3, 7, 4, 6],
    "fromValues" ~: "#7" ~: Node 5 (Node 3 EmptyTree (Node 4 EmptyTree EmptyTree)) (Node 7 (Node 6 EmptyTree EmptyTree) (Node 8 EmptyTree EmptyTree)) ~=? fromValues [5, 3, 7, 4, 6, 8],
    "fromValues" ~: "#8" ~: Node 5 (Node 3 (Node 2 EmptyTree EmptyTree) (Node 4 EmptyTree EmptyTree)) (Node 7 (Node 6 EmptyTree EmptyTree) (Node 8 EmptyTree EmptyTree)) ~=? fromValues [5, 3, 7, 4, 6, 8, 2]]

toString :: Show a => Tree a -> String
toString tree = "Tree {" ++ toString' tree ++ "}"
    where
        toString' EmptyTree                        = "()"
        toString' (Node value EmptyTree EmptyTree) = "(" ++ show value ++ ")"
        toString' (Node value left right)          = "(" ++ show value ++ toString' left ++ toString' right ++ ")"

toStringTests = test [
    "toString" ~: "#1" ~: "Tree {()}" ~=? toString (EmptyTree :: Tree Int),
    "toString" ~: "#2" ~: "Tree {(5)}" ~=? toString (fromValues [5]),
    "toString" ~: "#3" ~: "Tree {(5(3)())}" ~=? toString (fromValues [5, 3]),
    "toString" ~: "#4" ~: "Tree {(5(3)(7))}" ~=? toString (fromValues [5, 3, 7]),
    "toString" ~: "#5" ~: "Tree {(5(3()(4))(7))}" ~=? toString (fromValues [5, 3, 7, 4]),
    "toString" ~: "#6" ~: "Tree {(5(3()(4))(7(6)()))}" ~=? toString (fromValues [5, 3, 7, 4, 6]),
    "toString" ~: "#7" ~: "Tree {(5(3()(4))(7(6)(8)))}" ~=? toString (fromValues [5, 3, 7, 4, 6, 8]),
    "toString" ~: "#8" ~: "Tree {(5(3(2)(4))(7(6)(8)))}" ~=? toString (fromValues [5, 3, 7, 4, 6, 8, 2])]

append :: Ord a => Tree a -> a -> Tree a
append EmptyTree x = fromValue x
append (Node value left right) x
    | x < value = Node value (append left x) right
    | otherwise = Node value left (append right x)

appendTests = test [
    "append" ~: "#1" ~: (Node 5 EmptyTree EmptyTree) ~=? append EmptyTree 5,
    "append" ~: "#2" ~: (Node 5 (Node 3 EmptyTree EmptyTree) EmptyTree) ~=? append (Node 5 EmptyTree EmptyTree) 3,
    "append" ~: "#3" ~: (Node 5 (Node 3 EmptyTree EmptyTree) (Node 7 EmptyTree EmptyTree)) ~=? append (Node 5 (Node 3 EmptyTree EmptyTree) EmptyTree) 7,
    "append" ~: "#4" ~: (Node 5 (Node 3 EmptyTree (Node 4 EmptyTree EmptyTree)) (Node 7 EmptyTree EmptyTree)) ~=? append (Node 5 (Node 3 EmptyTree EmptyTree) (Node 7 EmptyTree EmptyTree)) 4,
    "append" ~: "#5" ~: (Node 5 (Node 3 EmptyTree (Node 4 EmptyTree EmptyTree)) (Node 7 (Node 6 EmptyTree EmptyTree) EmptyTree)) ~=? append (Node 5 (Node 3 EmptyTree (Node 4 EmptyTree EmptyTree)) (Node 7 EmptyTree EmptyTree)) 6,
    "append" ~: "#6" ~: (Node 5 (Node 3 EmptyTree (Node 4 EmptyTree EmptyTree)) (Node 7 (Node 6 EmptyTree EmptyTree) (Node 8 EmptyTree EmptyTree))) ~=? append (Node 5 (Node 3 EmptyTree (Node 4 EmptyTree EmptyTree)) (Node 7 (Node 6 EmptyTree EmptyTree) EmptyTree)) 8,
    "append" ~: "#7" ~: (Node 5 (Node 3 (Node 2 EmptyTree EmptyTree) (Node 4 EmptyTree EmptyTree)) (Node 7 (Node 6 EmptyTree EmptyTree) (Node 8 EmptyTree EmptyTree))) ~=? append (Node 5 (Node 3 EmptyTree (Node 4 EmptyTree EmptyTree)) (Node 7 (Node 6 EmptyTree EmptyTree) (Node 8 EmptyTree EmptyTree))) 2]

pop :: NonEmptyTree a -> (a, Tree a)
pop (NonEmptyTree value left right) =
    let
        tree' = pop' (Node value left right)
    in
        (value, tree')
    where
        pop' (Node value EmptyTree EmptyTree) = EmptyTree
        pop' (Node value left EmptyTree)      = left
        pop' (Node value EmptyTree right)     = right
        pop' (Node value left right)          = Node (nodeValue left) (pop' left) right

popTests = test [
    "pop" ~: "#1" ~: (1, EmptyTree) ~=? pop (NonEmptyTree 1 EmptyTree EmptyTree),
    "pop" ~: "#2" ~: (2, (Node 1 EmptyTree EmptyTree)) ~=? pop (NonEmptyTree 2 (Node 1 EmptyTree EmptyTree) EmptyTree),
    "pop" ~: "#3" ~: (2, (Node 1 EmptyTree EmptyTree)) ~=? pop (NonEmptyTree 2 EmptyTree (Node 1 EmptyTree EmptyTree)),
    "pop" ~: "#4" ~: (2, (Node 1 EmptyTree (Node 3 EmptyTree EmptyTree))) ~=? pop (NonEmptyTree 2 (Node 1 EmptyTree EmptyTree) (Node 3 EmptyTree EmptyTree))]

instance Functor Tree where
    fmap f EmptyTree               = EmptyTree
    fmap f (Node value left right) = Node (f value) (fmap f left) (fmap f right)

functorTreeTests = test [
    "functor Tree" ~: "#1" ~: EmptyTree ~=? fmap (+1) (EmptyTree :: Tree Int),
    "functor Tree" ~: "#2" ~: fromValues [6, 4, 8, 5, 7, 9, 3] ~=? fmap (+1) (fromValues [5, 3, 7, 4, 6, 8, 2]),
    "functor Tree" ~: "#3" ~: fromValues [10, 6, 14, 8, 12, 16, 4] ~=? fmap (*2) (fromValues [5, 3, 7, 4, 6, 8, 2])]

