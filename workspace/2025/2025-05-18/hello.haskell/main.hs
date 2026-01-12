
main :: IO ()
main = print $ myMap (\x -> x * 2) $ [1..10]

class MyFunctor f where
    myMap :: (a -> b) -> f a -> f b

instance MyFunctor [] where
    myMap f [] = []
    myMap f (x : xs) = (f x : myMap f xs)

