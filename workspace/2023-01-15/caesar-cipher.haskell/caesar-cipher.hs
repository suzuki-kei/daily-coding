import Data.Char
import Data.List
import Data.Ord
import Text.Printf

main = do
    let n = 1
    let s = "An advanced, purely functional programming language"
    let encoded = encode n s
    let decoded = decode n encoded
    let guessed = guess encoded
    printf "n = %d\n" n
    printf "s = %s\n" s
    printf "encoded = %s\n" encoded
    printf "decoded = %s\n" decoded
    printf "guessed = %s\n" guessed

encode :: Int -> String -> String
encode n s = map (rotate n) s

decode :: Int -> String -> String
decode n = encode (26 - n)

rotate :: Int -> Char -> Char
rotate n c | isLower c = rotateLower n c
           | isUpper c = rotateUpper n c
           | otherwise = rotateNonAlphabet n c
    where
        rotateLower = rotateChar $ ord 'a'
        rotateUpper = rotateChar $ ord 'A'
        rotateNonAlphabet n c = c
        rotateChar offset n c = chr $ (ord c + n - offset) `mod` 26 + offset

guess :: String -> String
guess s = decode n s
    where
        cipherTextFrequencies = toFrequencies s
        distances = map distance $ map (rotateList cipherTextFrequencies) [0..25]
        n = fst $ minimumBy (comparing snd) (indexed distances)

toFrequencies :: String -> [Float]
toFrequencies s = map (`divideIntegral` normalizedLength) normalizedCharCounts
    where
        normalized = map toLower $ filter isAlpha s
        normalizedLength = length normalized
        normalizedCharCounts = [count c normalized | c <- ['a'..'z']]

distance :: [Float] -> Float
distance frequencies = chiSquaredTest englishFrequencies frequencies

chiSquaredTest :: [Float] -> [Float] -> Float
chiSquaredTest expectedValues observedValues = sum ps
    where
        p expected observed = (observed / expected) ^ 2 / expected
        ps = zipWith p expectedValues observedValues
        sum = foldl (+) 0

englishFrequencies :: [Float]
englishFrequencies = [
    8.17, 1.49, 2.78, 4.25, 12.70, 2.23, 2.02, 6.09, 6.97, 0.15, 0.77, 4.03, 2.41,
    6.75, 7.51, 1.93, 0.10,  5.99, 6.33, 9.06, 2.76, 0.98, 2.36, 0.15, 1.97, 0.07]

rotateList :: [a] -> Int -> [a]
rotateList xs n = drop n xs ++ take n xs

indexed :: [a] -> [(Int, a)]
indexed xs = zip [0..] xs

count :: Eq a => a -> [a] -> Int
count x xs = length $ filter (== x) xs

divideIntegral :: (Integral a, Fractional b) => a -> a -> b
divideIntegral x1 x2 = fromIntegral x1 / fromIntegral x2

