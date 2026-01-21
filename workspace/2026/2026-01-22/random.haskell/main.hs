import Control.Monad (replicateM)
import Control.Monad.State (runState)
import Control.Monad.State (state)
import System.Random (getStdGen)
import System.Random (randomR)
import System.Random (StdGen)
import Text.Printf (printf)

main ::
    IO ()
main = do
    gen <- getStdGen
    let (xs, gen') = randomValues (10, 99) 20 gen
    printf "gen  = %s\n" (show gen)
    printf "gen' = %s\n" (show gen')
    printf "xs   = %s\n" (show xs)

randomValues ::
    (Int, Int) -> Int -> StdGen -> ([Int], StdGen)
randomValues (min, max) n gen =
    let
        s = state (randomR (min, max))
        m = replicateM n s
    in
        runState m gen

