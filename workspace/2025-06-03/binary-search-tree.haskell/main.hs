import Text.Printf (printf)

main :: IO ()
main = do
    let tree1 = appends EmptyTree [5, 1, 3, 7]
    let tree2 = fmap (*2) tree1
    print tree1
    print tree2
    mapM_ (\x -> printf "contains tree2 %d = %s\n" x (show $ contains tree2 x)) ([1..10] :: [Int])
    print $ parseNonEmptyTree tree1
    mapM_ (\n -> print (popN tree1 n)) [0..5]

data Tree a = EmptyTree | Node {
        nodeValue :: a,
        nodeLeft :: Tree a,
        nodeRight :: Tree a
    }
    deriving Eq

data NonEmptyTree a = NonEmptyTree a (Tree a) (Tree a)
    deriving Show

parseNonEmptyTree :: Tree a -> Maybe (NonEmptyTree a)
parseNonEmptyTree EmptyTree = Nothing
parseNonEmptyTree (Node value left right) = Just (NonEmptyTree value left right)

depth :: Tree a -> Int
depth EmptyTree               = 0
depth (Node value left right) = 1 + maximum [depth left, depth right]

contains :: Ord a => Tree a -> a -> Bool
contains EmptyTree x = False
contains (Node value left right) x
    | x < value = contains left x
    | x > value = contains right x
    | otherwise = True

append :: (Ord a) => Tree a -> a -> Tree a
append EmptyTree x = Node x EmptyTree EmptyTree
append node@(Node value left right) x
    | x < value = node {nodeLeft = append left x}
    | otherwise = node {nodeRight = append right x}

appends :: (Ord a) => Tree a -> [a] -> Tree a
appends tree xs = foldl append tree xs

pop :: NonEmptyTree a -> (a, Tree a)
pop (NonEmptyTree value left right) = (value, pop' (Node value left right))
    where
        pop' node@(Node value EmptyTree EmptyTree) = EmptyTree
        pop' node@(Node value left right)
            | depth left > depth right = Node (nodeValue left) (pop' left) right
            | otherwise                = Node (nodeValue right) left (pop' right)

popN :: Tree a -> Int -> ([a], Tree a)
popN tree n = popN' tree n []
    where
        popN' tree 0 xs = (reverse xs, tree)
        popN' tree n xs = case parseNonEmptyTree tree of
            Nothing                                   -> (reverse xs, EmptyTree)
            Just tree@(NonEmptyTree value left right) ->
                let
                    (x, tree') = pop tree
                in
                    popN' tree' (n - 1) (x : xs)

instance Show a => Show (Tree a) where
    show :: Tree a -> String
    show tree = "Tree {" ++ (show' tree) ++ "}"
        where
            show' EmptyTree                        = "()"
            show' (Node value EmptyTree EmptyTree) = "(" ++ (show value) ++ ")"
            show' (Node value left right)          = "(" ++ (show value) ++ " " ++ (show' left) ++ " " ++ (show' right) ++ ")"

instance Functor Tree where
    fmap :: (a -> b) -> Tree a -> Tree b
    fmap f EmptyTree               = EmptyTree
    fmap f (Node value left right) = Node (f value) (fmap f left) (fmap f right)

