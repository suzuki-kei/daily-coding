
main :: IO ()
main = do
    let tree = fromValues [5, 8, 2]
    let tree' = appends tree [7, 9, 1, 4]
    print tree'
    print $ search tree' 1
    print $ search tree' 2
    print $ search tree' 3
    print $ search tree' 4
    print $ search tree' 5
    print $ search tree' 6
    print $ search tree' 7
    print $ search tree' 8
    print $ search tree' 9
    print $ search tree' 10

data Tree a = Tree {
    value :: a,
    left :: Tree a,
    right :: Tree a
} | EmptyTree deriving (Show)

isEmpty :: Tree a -> Bool
isEmpty EmptyTree = True
isEmpty tree      = False

isLeaf :: Tree a -> Bool
isLeaf Tree {value = x, left = EmptyTree, right = EmptyTree} = True
isLeaf tree = False

fromValue :: a -> Tree a
fromValue x = Tree {value = x, left = EmptyTree, right = EmptyTree}

fromValues :: (Ord a) => [a] -> Tree a
fromValues xs = foldl append EmptyTree xs

append :: (Ord a) => Tree a -> a -> Tree a
append EmptyTree x = fromValue x
append tree x
    | x < value tree = tree {left = append (left tree) x}
    | otherwise      = tree {right = append (right tree) x}

appends :: (Ord a) => Tree a -> [a] -> Tree a
appends tree xs = foldl append tree xs

search :: (Ord a) => Tree a -> a -> Bool
search EmptyTree x = False
search tree x
    | x == value tree = True
    | x < value tree = search (left tree) x
    | x > value tree = search (right tree) x

