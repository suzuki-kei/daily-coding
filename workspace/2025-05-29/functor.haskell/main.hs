
main :: IO ()
main = do
    print $ fmap' (*2) [1..10]
    print $ fmap' (*2) (Just' 2)
    print $ fmap' (*2) Nothing'

class Functor' typeConstructor where
    fmap' :: (a -> b) -> typeConstructor a -> typeConstructor b

instance Functor' [] where
    fmap' :: (a -> b) -> [] a -> [] b
    fmap' f [] = []
    fmap' f (x:xs) = f x : fmap' f xs

data Maybe' a = Just' a | Nothing' deriving Show

instance Functor' Maybe' where
    fmap' :: (a -> b) -> Maybe' a -> Maybe' b
    fmap' f (Just' x) = Just' (f x)
    fmap' f Nothing' = Nothing'

