import Control.Monad (replicateM)
import Control.Monad.State (runState)
import Control.Monad.State (state)
import System.Random (StdGen)
import System.Random (getStdGen)
import System.Random (randomR)

main :: IO ()
main = do
    gen <- getStdGen
    print $ fst $ randomRs (10, 99) 20 gen

randomRs :: (Int, Int) -> Int -> StdGen -> ([Int], StdGen)
randomRs range n gen = runState m gen
    where
        s = state (randomR range)
        m = replicateM n s

