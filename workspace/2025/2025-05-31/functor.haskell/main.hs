
main :: IO ()
main = do
    print $ fmap' (*2) [1..10]
    print $ fmap' (*2) Nothing'
    print $ fmap' (*2) (Just' 10)

class Functor' f where
    fmap' :: (a -> b) -> f a -> f b

instance Functor' [] where
    fmap' :: (a -> b) -> [a] -> [b]
    fmap' f [] = []
    fmap' f (x:xs) = f x : fmap' f xs

data Maybe' a = Just' a | Nothing' deriving Show

instance Functor' Maybe' where
    fmap' :: (a -> b) -> Maybe' a -> Maybe' b
    fmap' f Nothing' = Nothing'
    fmap' f (Just' x) = Just' (f x)

