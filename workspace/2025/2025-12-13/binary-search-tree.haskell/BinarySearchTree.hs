module BinarySearchTree where

data Tree a =
    EmptyTree
    | Node {
        nodeValue :: a,
        nodeLeft  :: Tree a,
        nodeRight :: Tree a}
    deriving (Eq, Show)

data NonEmptyTree a =
    NonEmptyTreeNode {
        nonEmptyTreeNodeValue :: a,
        nonEmptyTreeNodeLeft  :: Tree a,
        nonEmptyTreeNodeRight :: Tree a}
    deriving (Eq, Show)

parseNonEmptyTree ::
    Tree a -> Maybe (NonEmptyTree a)
parseNonEmptyTree EmptyTree =
    Nothing
parseNonEmptyTree (Node value left right) =
    Just (NonEmptyTreeNode value left right)

fromValue ::
    a -> Tree a
fromValue x =
    Node x EmptyTree EmptyTree

fromValues ::
    (Ord a) => [a] -> Tree a
fromValues xs =
    appends EmptyTree xs

append ::
    (Ord a) => Tree a -> a -> Tree a
append EmptyTree x =
    Node x EmptyTree EmptyTree
append (Node value left right) x
    | x < value = Node value (append left x) right
    | otherwise = Node value left (append right x)

appends ::
    (Ord a) => Tree a -> [a] -> Tree a
appends tree xs =
    foldl append tree xs

popMin ::
    NonEmptyTree a -> (a, Tree a)
popMin (NonEmptyTreeNode value left right) =
    popMin' (Node value left right)
        where
            popMin' (Node value EmptyTree right) =
                (value, right)
            popMin' (Node value left right) =
                let
                    (minValue, newLeft) = popMin' left
                    poppedTree          = Node value newLeft right
                in
                    (minValue, poppedTree)

popMax ::
    NonEmptyTree a -> (a, Tree a)
popMax (NonEmptyTreeNode value left right) =
    popMax' (Node value left right)
        where
            popMax' (Node value left EmptyTree) =
                (value, left)
            popMax' (Node value left right) =
                let
                    (maxValue, newRight) = popMax' right
                    poppedTree           = Node value left newRight
                in
                    (maxValue, poppedTree)

toList ::
    (NonEmptyTree a -> (a, Tree a)) -> Tree a -> [a]
toList pop tree =
    toList' pop tree []
        where
            toList' pop tree xs =
                case (parseNonEmptyTree tree) of
                    Nothing ->
                        reverse xs
                    Just nonEmptyTree ->
                        let
                            (x, tree') = pop nonEmptyTree
                        in
                            toList' pop tree' (x : xs)

instance Functor Tree where
    fmap f EmptyTree =
        EmptyTree
    fmap f (Node value left right) =
        Node (f value) (fmap f left) (fmap f right)

