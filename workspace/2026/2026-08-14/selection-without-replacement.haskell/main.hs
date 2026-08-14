import Control.Monad (foldM)
import Control.Monad.State (runState)
import Control.Monad.State (state)
import Control.Monad.State (State)
import System.Random (getStdGen)
import System.Random (randomR)
import System.Random (StdGen)

main ::
    IO ()
main =
    do
        gen <- getStdGen
        let
            (xs, gen') = runState run gen
        print xs
    where
        run = selectionWithoutReplacement (10, 99) 20

selectionWithoutReplacement ::
    (Int, Int) -> Int -> State StdGen [Int]
selectionWithoutReplacement (min, max) n =
    do
        (xs, nSelected) <- foldM folder ([], 0) [min..max]
        pure (reverse xs)
    where
        folder (xs, nSelected) value =
            do
                selected <- shouldSelect value nSelected
                case selected of
                    True -> pure (value : xs, nSelected + 1)
                    False -> pure (xs, nSelected)
        shouldSelect value nSelected =
            let
                numerator = fromIntegral (n - nSelected) :: Double
                denominator = fromIntegral (max - value + 1) :: Double
            in do
                r <- uniform
                pure (r < numerator / denominator)

uniform ::
    State StdGen Double
uniform =
    do
        x <- state (randomR (0 :: Int, 2^53 - 1))
        pure ((fromIntegral x) / (2 ** 53))

