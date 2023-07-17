import Test.HUnit
import qualified ListsTest
import qualified SetTest

main :: IO ()
main = do
    runTestTT ListsTest.testList
    runTestTT SetTest.testList
    pure ()

