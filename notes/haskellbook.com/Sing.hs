module Sing where

fstString :: String -> String
fstString x = x ++ " in the rain"

sndString :: [Char] -> [Char]
sndString = (++ " over the rainbow")

sing = if x > y
       then fstString x
       else sndString x
  where
    x = "Singing"
    y = "Somewhere"
