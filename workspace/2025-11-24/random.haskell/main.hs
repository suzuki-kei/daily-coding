import Control.Monad (replicateM)
import Control.Monad.State (runState)
import Control.Monad.State (state)
import System.Random (getStdGen)
import System.Random (randomR)
import System.Random (StdGen)

main :: IO ()
main = getStdGen >>= demonstration

demonstration :: StdGen -> IO ()
demonstration gen =
    let
        (xs, gen') = randomRs (10, 99) 20 gen
    in do
        putStrLn $ "gen  = " ++ (show gen)
        putStrLn $ "gen' = " ++ (show gen')
        putStrLn $ "xs   = " ++ (show xs)

randomRs :: (Int, Int) -> Int -> StdGen -> ([Int], StdGen)
randomRs range n gen =
    let
        s = state (randomR range)
        m = replicateM n s
    in
        runState m gen

