module BinarySearchTree where

data Tree a =
    EmptyTree
    |
    Node {
        nodeValue :: a,
        nodeLeft  :: Tree a,
        nodeRight :: Tree a
    }
    deriving (Eq, Show)

fromValue ::
    a -> Tree a
fromValue x =
    Node x EmptyTree EmptyTree

fromValues ::
    Ord a => [a] -> Tree a
fromValues xs =
    appends EmptyTree xs

append ::
    Ord a => Tree a -> a -> Tree a
append EmptyTree x =
    Node x EmptyTree EmptyTree
append (Node value left right) x
    | x < value = Node value (append left x) right
    | otherwise = Node value left (append right x)

appends ::
    Ord a => Tree a -> [a] -> Tree a
appends tree xs =
    foldl append tree xs

popMin ::
    Tree a -> Maybe (a, Tree a)
popMin EmptyTree =
    Nothing
popMin (Node value left right) =
    case (popMin left) of
        Just (minValue, newLeft) ->
            Just (minValue, Node value newLeft right)
        Nothing ->
            Just (value, right)

popMax ::
    Tree a -> Maybe (a, Tree a)
popMax EmptyTree =
    Nothing
popMax (Node value left right) =
    case (popMax right) of
        Just (maxValue, newRight) ->
            Just (maxValue, Node value left newRight)
        Nothing ->
            Just (value, left)

toList ::
    (Tree a -> Maybe (a, Tree a)) -> Tree a -> [a]
toList pop tree =
    toList' tree []
        where
            toList' tree xs =
                case (pop tree) of
                    Just (x, tree') ->
                        toList' tree' (x : xs)
                    Nothing ->
                        reverse xs

