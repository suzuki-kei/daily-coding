module BinarySearchTree where

data Tree a = EmptyTree
            | Node {nodeValue :: a,
                    nodeLeft  :: Tree a,
                    nodeRight :: Tree a}
    deriving (Show, Eq)

fromValue :: Ord a => a -> Tree a
fromValue x = append EmptyTree x

fromValues :: Ord a => [a] -> Tree a
fromValues xs = appends EmptyTree xs

append :: Ord a => Tree a -> a -> Tree a
append EmptyTree x = Node x EmptyTree EmptyTree
append (Node value left right) x
    | x < value = Node value (append left x) right
    | otherwise = Node value left (append right x)

appends :: Ord a => Tree a -> [a] -> Tree a
appends tree xs = foldl append tree xs

toList :: Ord a => Tree a -> [a]
toList tree = toList' tree []
    where
        toList' tree xs = case popMin tree of
            Just (minValue, poppedTree) -> toList' poppedTree (minValue : xs)
            Nothing                     -> reverse xs

popMin :: Tree a -> Maybe (a, Tree a)
popMin EmptyTree = Nothing
popMin tree = Just (popMin' tree)
    where
        popMin' (Node value EmptyTree right) = (value, right)
        popMin' (Node value left right) = 
            let
                (minValue, newLeft) = popMin' left
            in
                (minValue, Node value newLeft right)

popMax :: Tree a -> Maybe (a, Tree a)
popMax EmptyTree = Nothing
popMax tree = Just (popMax' tree)
    where
        popMax' (Node value left EmptyTree) = (value, left)
        popMax' (Node value left right) =
            let
                (maxValue, newRight) = popMax' right
            in
                (maxValue, Node value left newRight)

instance Functor Tree where
    fmap f EmptyTree = EmptyTree
    fmap f (Node value left right) = Node (f value) (fmap f left) (fmap f right)

