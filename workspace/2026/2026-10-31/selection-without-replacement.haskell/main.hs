import Control.Monad (foldM)
import Control.Monad.State (State)
import Control.Monad.State (runState)
import Control.Monad.State (state)
import System.Random (StdGen)
import System.Random (getStdGen)
import System.Random (randomR)

main ::
    IO ()
main =
    let
        demonstrations =
            [
                selectionWithoutReplacement (0, 9) 20,
                selectionWithoutReplacement (10, 99) 20
            ]
    in do
        gen <- getStdGen
        gen' <- foldM folder gen demonstrations
        pure ()
    where
        folder gen demonstration =
            let
                ((xs, nSelected), gen') = runState demonstration gen
            in do
                print xs
                pure gen'

selectionWithoutReplacement ::
    (Int, Int) -> Int -> State StdGen ([Int], Int)
selectionWithoutReplacement (minValue, maxValue) n =
    do
        (xs, nSelected) <- foldM folder ([], 0) [minValue..maxValue]
        pure (reverse xs, nSelected)
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
        -- Double (IEEE 754 binary64) の有効精度である 53 bit に合わせている
        scale = 2^53 :: Int
    in do
        n <- state (randomR (0, scale - 1))
        pure (fromIntegral n / fromIntegral scale)

