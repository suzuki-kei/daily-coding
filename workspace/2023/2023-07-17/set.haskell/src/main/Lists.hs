module Lists where

--
-- 指定した値がリストに含まれることを判定する.
--
contains :: (Eq eq) => eq -> [eq] -> Bool
contains _ [] = False
contains target (x:xs)
    | target == x = True
    | otherwise   = contains target xs

