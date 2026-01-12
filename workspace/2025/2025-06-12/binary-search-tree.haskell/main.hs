main :: IO ()
main = do
    let
        xs    = [5, 3, 1, 2, 7]
        tree1 = fromValues xs
        tree2 = fmap (*2) tree1
    print tree1
    print tree2
    mapM_ print $ parseNonEmptyTree tree1
    mapM_ (print . popN tree1) [0 .. length xs]

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

fromValues :: Ord a => [a] -> Tree a
fromValues xs = appends EmptyTree xs

append :: Ord a => Tree a -> a -> Tree a
append EmptyTree x = fromValue x
append (Node value left right) x
    | x < value = Node value (append left x) right
    | otherwise = Node value left (append right x)

appends :: Ord a => Tree a -> [a] -> Tree a
appends tree xs = foldl append EmptyTree xs

pop :: Ord a => NonEmptyTree a -> (a, Tree a)
pop (NonEmptyTree value left right) =
    let
        tree' = pop' (Node value left right)
    in
        (value, tree')
    where
        pop' (Node value left EmptyTree)  = left
        pop' (Node value EmptyTree right) = right
        pop' (Node value left right)      = Node (nodeValue left) (pop' left) right

popN :: Ord a => Tree a -> Int -> ([a], Tree a)
popN tree n = popN' tree n []
    where
        popN' tree 0 xs                    = (xs, tree)
        popN' EmptyTree n xs               = (xs, EmptyTree)
        popN' (Node value left right) n xs =
            let
                (x, tree') = pop (NonEmptyTree value left right)
            in
                popN' tree' (n - 1) (x : xs)

instance Show a => Show (Tree a) where
    show tree = "Tree {" ++ show' tree ++ "}"
        where
            show' EmptyTree                        = "()"
            show' (Node value EmptyTree EmptyTree) = "(" ++ show value ++ ")"
            show' (Node value left right)          = "(" ++ show value ++ show' left ++ show' right ++ ")"

instance Functor Tree where
    fmap f EmptyTree               = EmptyTree
    fmap f (Node value left right) = Node (f value) (fmap f left) (fmap f right)

