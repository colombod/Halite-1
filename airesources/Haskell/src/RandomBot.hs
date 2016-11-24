module Main where

import System.Random (getStdGen)
import Halite

main :: IO ()
main = getStdGen >>= communicate name algorithm runEffects

name = "Random Haskell Bot"

algorithm :: RandomReader m => ID -> Map -> m [Move]
algorithm me g@(Map width height sites) =
   randomMoves $ filter ((== me) . siteOwner) (concat sites)

randomMoves :: RandomReader m => [Site] -> m [Move]
randomMoves = traverse $ randMove . siteLocation
   where
      randMove location = do
         direction <- toEnum <$> rand 5
         return $ Move location direction