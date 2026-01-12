import Text.Printf (printf)

main :: IO ()
main = do
    let tree1 = foldl append EmptyTree [5, 3, 2, 4, 8, 9, 7, 1, 6]
    let tree2 = fmap (*2) $ foldl append EmptyTree [5, 3, 2, 4, 8, 9, 7, 1, 6]
    putStrLn $ replicate 60 '-'
    printTree $ tree1
    putStrLn $ replicate 60 '-'
    printTree $ tree2
    putStrLn $ replicate 60 '-'
    mapM_ (\target -> printContains target tree2) [1..10]
    where
        printContains :: Int -> Tree Int -> IO ()
        printContains target tree = do
            let found = show $ contains target tree
            printf "target=%d, contains=%s\n" target found

data Tree a = Tree {
    treeValue :: a,
    treeLeft :: Tree a,
    treeRight :: Tree a
} | EmptyTree deriving (Show)

data NonEmptyTree a = NonEmptyTree {
    nonEmptyTreeValue :: a,
    nonEmptyTreeLeft :: Tree a,
    nonEmptyTreeRight :: Tree a
} deriving (Show)

printTree :: (Show a) => Tree a -> IO ()
printTree EmptyTree = putStrLn "EmptyTree"
printTree tree = printTree 0 tree
    where
        printTree depth EmptyTree =
            pure ()
        printTree depth tree = do
            printTree (depth + 1) (treeRight tree)
            putStrLn $ replicate (depth * 4) ' ' ++ show (treeValue tree)
            printTree (depth + 1) (treeLeft tree)

instance Functor Tree where
    fmap :: (a -> b) -> Tree a -> Tree b
    fmap f EmptyTree = EmptyTree
    fmap f tree = Tree {
        treeValue = f (treeValue tree),
        treeLeft  = fmap f (treeLeft tree),
        treeRight = fmap f (treeRight tree)}

append :: Ord a => Tree a -> a -> Tree a
append EmptyTree x = Tree {
        treeValue = x,
        treeLeft  = EmptyTree,
        treeRight = EmptyTree}
append tree x
    | x < treeValue tree = tree{treeLeft = append (treeLeft tree) x}
    | otherwise          = tree{treeRight = append (treeRight tree) x}

contains :: (Ord a) => a -> Tree a -> Bool
contains target EmptyTree = False
contains target tree
    | target < treeValue tree  = contains target (treeLeft tree)
    | target > treeValue tree  = contains target (treeRight tree)
    | otherwise                = True

