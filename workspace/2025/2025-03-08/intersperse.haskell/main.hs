
main :: IO ()
main = do
    demonstration $ prefixes ['a'..'z']

demonstration :: [String] -> IO ()
demonstration [] = pure ()
demonstration (xs:xss) = do
    print $ intersperse ',' xs
    demonstration xss

intersperse :: a -> [a] -> [a]
intersperse separator [] = []
intersperse separator (x:[]) = [x]
intersperse separator (x:xs) = (x : separator : intersperse separator xs)

prefixes :: [a] -> [[a]]
prefixes xs = accumulate xs [] []
    where
        accumulate [] prefix prefixes = prefixes ++ [prefix]
        accumulate (x:xs) prefix prefixes = accumulate xs (prefix ++ [x]) (prefixes ++ [prefix])

