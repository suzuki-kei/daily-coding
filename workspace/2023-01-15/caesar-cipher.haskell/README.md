# caesar-cipher

## Functions

    encode :: Int -> String -> String
    encode key plainText
        平文を暗号化する.

    decode :: Int -> String -> String
    decode key cipherText
        暗号文を復号する.

    rotate :: Int -> Char -> Char
    rotate n c
        アルファベットを n 文字ずらす.
        Ex. rotate 1 'a' => 'b'

    guess :: String -> String
    guess cipherText
        暗号文から平文を推測する.

    toFrequencies :: String -> [Float]
    toFrequencies text
        文字列を a から z までの出現頻度に変換する.
        [a の出現頻度, b の出現頻度, ..., z の出現頻度] であるリストに変換する.

    distance :: [Float] -> Float
    distance frequencies
        englishFrequencies との距離を求める.

    chiSquaredTest :: [Float] -> [Float] -> Float
    chiSquaredTest expectedValues observedValues
        カイ二乗検定.

    englishFrequencies :: [Float]
        一般的な英語文書における a から z までの出現頻度.

    rotateList :: [a] -> Int -> [a]
    rotateList xs n
        リストの要素をローテーションする
        Ex. rotateList "abc" 1 => "bca"

    indexed :: [a] -> [(Int, a)]
    indexed xs
        任意のリストをインデックス付きのリストに変換する.
        Ex. indexed "abc" => [(0, 'a'), (1, 'b'), (2, 'c')]

    count :: Eq a => a -> [a] -> Int
    count x xs
        指定した値がリストに含まれる個数を求める.
        Ex. count 'l' "hello" => 2

    divideIntegral :: (Integral a, Fractional b) => a -> a -> b
    divideIntegral x1 x2
        x1 を x2 で割った値を求める.
        fromIntegral x1 / fromIntegral x2 に等しい.

