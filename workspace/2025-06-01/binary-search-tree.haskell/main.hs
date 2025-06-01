
main :: IO ()
main = do
    let tree = foldl append EmptyTree [5, 3, 8, 6, 9, 7, 1, 2, 4]
    print $ tree
    print $ depth tree
    mapM_ (print . popN tree) [0..10]

data Tree a = EmptyTree | Tree {
    treeValue :: a,
    treeLeft  :: Tree a,
    treeRight :: Tree a
} deriving Eq

isLeaf :: Tree a -> Bool
isLeaf (Tree _ EmptyTree EmptyTree) = True
isLeaf _                            = False

append :: Ord a => Tree a -> a -> Tree a
append EmptyTree x = Tree x EmptyTree EmptyTree
append tree@(Tree value left right) x
    | x < value = tree {treeLeft = append left x}
    | otherwise = tree {treeRight = append right x}

depth :: Tree a -> Int
depth EmptyTree           = 0
depth (Tree x left right) = 1 + maximum [depth left, depth right]

pop :: Tree a -> (Maybe a, Tree a)
pop EmptyTree         = (Nothing, EmptyTree)
pop tree@(Tree x _ _) = (Just x, pop tree)
    where
        pop (Tree x left EmptyTree)  = left
        pop (Tree x EmptyTree right) = right
        pop (Tree _ left right)
            | depth left > depth right = Tree (treeValue left) (pop left) right
            | otherwise                = Tree (treeValue right) left (pop right)

popN :: Tree a -> Int -> ([Maybe a], Tree a)
popN tree 0 = ([], tree)
popN tree n = accumulate tree n []
    where
        accumulate tree 0 xs = (reverse xs, tree)
        accumulate tree n xs =
            let
                (x, tree') = pop tree
            in
                accumulate tree' (n - 1) (x:xs)

instance Show a => Show (Tree a) where
    show tree = "Tree {" ++ (toString tree) ++ "}"
        where
            toString EmptyTree           = ""
            toString (Tree x left right) = foldl (++) [] ["(", show x, toString left, toString right, ")"]

instance Functor Tree where
    fmap :: (a -> b) -> Tree a -> Tree b
    fmap f EmptyTree = EmptyTree
    fmap f tree      = Tree {treeValue = f (treeValue tree),
                             treeLeft  = fmap f (treeLeft tree),
                             treeRight = fmap f (treeRight tree)}

