import Control.Monad (replicateM)
import Control.Monad.State (runState)
import Control.Monad.State (state)
import System.Random (getStdGen)
import System.Random (randomR)
import System.Random (StdGen)
import Text.Printf (printf)

main :: IO ()
main = getStdGen >>= demonstration

demonstration :: StdGen -> IO ()
demonstration gen =
    let
        (xs, gen') = randomXs (10, 99) 20 gen
    in do
        printf "gen  = %s\n" (show gen)
        printf "gen' = %s\n" (show gen')
        printf "xs   = %s\n" (show xs)

randomXs :: (Int, Int) -> Int -> StdGen -> ([Int], StdGen)
randomXs (min, max) n gen =
    let
        s = state (randomR (min, max))
        m = replicateM n s
    in
        runState m gen

