import Test.HUnit ((~:))
import Test.HUnit ((~?=))
import Test.HUnit (runTestTTAndExit)
import Test.HUnit (test)
import Test.HUnit (Test)
import Test.HUnit (Test (TestList))
import Text.Printf (printf)

main :: IO ()
main = runTestTTAndExit allTests

transpose :: [[a]] -> [[a]]
transpose xss = transpose' heads tails
    where
        (heads, tails) = unzip [(head, tail) | (head : tail) <- xss]
        transpose' [] [] = []
        transpose' heads tails = heads : transpose tails

allTests :: Test
allTests = TestList [
    transposeTests]

transposeTests :: Test
transposeTests = test tests
    where
        assertions = [
            transpose ([] :: [[Int]])          ~?= [],
            transpose [[1]]                    ~?= [[1]],
            transpose [[1], [2]]               ~?= [[1, 2]],
            transpose [[1, 2], [3, 4]]         ~?= [[1, 3], [2, 4]],
            transpose [[1, 2, 3], [4, 5, 6]]   ~?= [[1, 4], [2, 5], [3, 6]],
            transpose [[1, 2], [3], [4, 5, 6]] ~?= [[1, 3, 4], [2, 5], [6]]]
        labels = map mapper ns
            where
                ns = [1..] :: [Int]
                mapper n = printf "transpose #%d" n
        tests = zipWith zipper labels assertions
            where
                zipper = (~:)

