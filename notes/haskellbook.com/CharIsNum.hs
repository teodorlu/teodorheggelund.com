module StringIsNum where

import Data.Char (ord, chr)

byIntOp :: (Int -> Int -> Int) -> Char -> Char -> Char
byIntOp intfun c1 c2 = chr $ ord c1 `intfun` ord c2

instance Num Char where
  (+) = byIntOp (+)
  (*) = byIntOp (*)
  abs = id
  signum _ = 'a'
  fromInteger = chr . fromInteger
  negate _ = 'a'
