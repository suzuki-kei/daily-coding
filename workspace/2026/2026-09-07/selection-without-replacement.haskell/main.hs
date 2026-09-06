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
selectionWithoutReplacement (minValue, maxValue) n =
    do
        (xs, nSelected) <- foldM folder ([], 0) [minValue..maxValue]
        pure (reverse xs)
    where
        folder (xs, nSelected) x =
            do
                selected <- shouldSelect x nSelected
                case selected of
                    True -> pure (x : xs, nSelected + 1)
                    False -> pure (xs, nSelected)
        shouldSelect x nSelected =
            let
                nRemaining = n - nSelected
                nCandidatesRemaining = maxValue - x + 1
                selectionProbability = fromIntegral nRemaining / fromIntegral nCandidatesRemaining
            in do
                r <- uniform
                pure (r < selectionProbability)

uniform ::
    State StdGen Double
uniform =
    let
        scale = 2^53 :: Int
    in do
        x <- state (randomR (0, scale - 1))
        pure (fromIntegral x / fromIntegral scale)

