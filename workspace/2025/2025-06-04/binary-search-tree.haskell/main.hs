
main :: IO ()
main = do
    let
        tree1 = fromValues [5, 3, 7, 2, 4, 8, 6]
        tree2 = fmap (*2) tree1
        emptyTree = EmptyTree :: Tree Int
    print tree1
    print tree2
    print emptyTree

data Tree a = EmptyTree | Node {
        nodeValue :: a,
        nodeLeft :: Tree a,
        nodeRight :: Tree a
    }
    deriving Eq

append :: Ord a => Tree a -> a -> Tree a
append EmptyTree x =
    Node x EmptyTree EmptyTree
append (Node value left right) x
    | x < value = Node value (append left x) right
    | otherwise = Node value left (append right x)

appends :: Ord a => Tree a -> [a] -> Tree a
appends tree xs = foldl append tree xs

fromValue :: a -> Tree a
fromValue x = Node x EmptyTree EmptyTree

fromValues :: Ord a => [a] -> Tree a
fromValues xs = appends EmptyTree xs

--pop :: Tree a -> (a, Tree a)
--pop (Node value EmptyTree EmptyTree) = (value, EmptyTree)
--pop (Node value left EmptyTree)      = (value, left)
--pop (Node value EmptyTree right)     = (value, right)
--pop (Node value left right)          = (value, right)

instance Show a => Show (Tree a) where
    show :: Tree a -> String
    show tree = "Tree {" ++ (show' tree) ++ "}"
        where
            show' EmptyTree                        = ""
            show' (Node value EmptyTree EmptyTree) = "(" ++ (show value) ++ ")"
            show' (Node value left right)          = "(" ++ (show value) ++ (show' left) ++ (show' right) ++ ")"

instance Functor Tree where
    fmap :: (a -> b) -> Tree a -> Tree b
    fmap f EmptyTree               = EmptyTree
    fmap f (Node value left right) = Node (f value) (fmap f left) (fmap f right)

