
main :: IO ()
main = do
    let
        tree1 = fromValues [5, 1, 7, 3, 6, 9]
        tree2 = fmap (*2) tree1
        emptyTree = EmptyTree :: Tree Int
    print tree1
    print tree2
    print emptyTree
    print (parseNonEmptyTree tree1)
    mapM_ (\n -> print (popN tree1 n)) [0..10]

data Tree a = EmptyTree
            | Node {nodeValue :: a,
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

fromValues :: Ord a => [a] -> Tree a
fromValues xs = foldl append EmptyTree xs

append :: Ord a => Tree a -> a -> Tree a
append EmptyTree x = fromValue x
append (Node value left right) x
    | x < value = Node value (append left x) right
    | otherwise = Node value left (append right x)

depth :: Tree a -> Int
depth EmptyTree               = 0
depth (Node value left right) = 1 + maximum [depth left, depth right]

pop :: NonEmptyTree a -> (a, Tree a)
pop (NonEmptyTree value left right) = (value, pop' (Node value left right))
    where
        pop' (Node value EmptyTree EmptyTree) = EmptyTree
        pop' (Node value left EmptyTree)      = left
        pop' (Node value EmptyTree right)     = right
        pop' (Node value left right)          = Node (nodeValue left) (pop' left) right

popN :: Tree a -> Int -> ([a], Tree a)
popN tree n = popN' tree n []
    where
        popN' :: Tree a -> Int -> [a] -> ([a], Tree a)
        popN' tree 0 xs                    = (reverse xs, tree)
        popN' EmptyTree n xs               = (reverse xs, EmptyTree)
        popN' (Node value left right) n xs =
            let
                (x, tree') = pop (NonEmptyTree value left right) 
            in
                popN' tree' (n - 1) (x:xs)

instance Show a => Show (Tree a) where
    show :: Tree a -> String
    show tree = "Tree {" ++ (show' tree) ++ "}"
        where
            show' EmptyTree                        = "()"
            show' (Node value EmptyTree EmptyTree) = "(" ++ (show value) ++ ")"
            show' (Node value left right)          = "(" ++ (show value) ++ (show' left) ++ (show' right) ++ ")"

instance Functor Tree where
    fmap :: (a -> b) -> Tree a -> Tree b
    fmap f EmptyTree               = EmptyTree
    fmap f (Node value left right) = Node (f value) (fmap f left) (fmap f right)

