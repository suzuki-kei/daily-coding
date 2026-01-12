
main = do
    print $ myCount [1..10]
    print $ mySum [1..10]
    print $ myMinimum [1..10]
    print $ myMaximum [1..10]

myCount :: (Num a) => [a] -> Int
myCount [] = 0
myCount (x:xs) = 1 + myCount xs

mySum :: (Num a) => [a] -> a
mySum [] = 0
mySum (x:xs) = x + mySum xs

myMinimum :: (Ord a) => [a] -> a
myMinimum (x:[]) = x
myMinimum (x1:x2:xs)
    | x1 <= x2 = myMinimum(x1:xs)
    | x1 >= x2 = myMinimum(x2:xs)

myMaximum :: (Ord a) => [a] -> a
myMaximum (x:[]) = x
myMaximum (x1:x2:xs)
    | x1 >= x2 = myMaximum(x1:xs)
    | x1 <= x2 = myMaximum(x2:xs)

