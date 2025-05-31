
main :: IO ()
main = do
    print $ fmap' (*2) [1..10]
    print $ fmap' (*2) (Just' 10)
    print $ fmap' (*2) Nothing'
    print $ fmap' (*2) $ foldl append EmptyTree [5, 3, 7, 9, 6, 1]

class Functor' f where
    fmap' :: (a -> b) -> f a -> f b

instance Functor' [] where
    fmap' :: (a -> b) -> [a] -> [b]
    fmap' f [] = []
    fmap' f (x:xs) = f x : fmap' f xs

data Maybe' a = Just' a | Nothing' deriving Show

instance Functor' Maybe' where
    fmap' :: (a -> b) -> Maybe' a -> Maybe' b
    fmap' f Nothing'  = Nothing'
    fmap' f (Just' a) = Just' (f a)

data Tree a = Tree {
    treeValue :: a,
    treeLeft :: Tree a,
    treeRight :: Tree a
} | EmptyTree deriving Show

instance Functor' Tree where
    fmap' :: (a -> b) -> Tree a -> Tree b
    fmap' f EmptyTree = EmptyTree
    fmap' f tree      = tree {
        treeValue = f (treeValue tree),
        treeLeft  = fmap' f (treeLeft tree),
        treeRight = fmap' f (treeRight tree)}

append :: (Ord a) => Tree a -> a -> Tree a
append EmptyTree x = Tree {
    treeValue = x,
    treeLeft  = EmptyTree,
    treeRight = EmptyTree}
append tree x
    | x < treeValue tree = tree {treeLeft = append (treeLeft tree) x}
    | otherwise          = tree {treeRight = append (treeRight tree) x}

