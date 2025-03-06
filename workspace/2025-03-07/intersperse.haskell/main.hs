
main :: IO ()
main = do
    print $ intersperse ',' ""
    print $ intersperse ',' "a"
    print $ intersperse ',' "ab"
    print $ intersperse ',' "abc"

intersperse :: a -> [a] -> [a]
intersperse separator [] = []
intersperse separator (x:[]) = [x]
intersperse separator (x1:x2:xs) = (x1 : separator : intersperse separator (x2:xs))

