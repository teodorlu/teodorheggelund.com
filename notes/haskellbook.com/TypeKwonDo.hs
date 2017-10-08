module TypeKwonDo where

import Data.Char as C

-- 1.
f :: Int -> String
f = show

g :: String -> Char
g = (!! 0)

h :: Int -> Char
h = g . f

-- 2.
data X
data Y
data Z

xz :: X -> Z
xz = undefined

yz :: Y -> Z
yz = undefined

xform :: (X, Y) -> (Z, Z)
xform (x, y) = (xz x, yz y)

munge :: (x -> y) -> (y -> (w, z)) -> x -> w
munge xy ywz x =
  let y = xy x
      (w, _) = ywz y
  in  w

class Fractional a => Ractional a where
  react :: a -> String

instance Ractional Double where
  react = (++ "!") . show

divideThenAdd :: Ractional a => a -> a -> a
divideThenAdd x y = x / y + 1

class Shout a where
  shout :: a -> String

newtype TString = TString { unString :: String
                          }

instance Shout TString where
  shout = ("I am " ++) . map C.toUpper . unString

data Unit = Unit deriving Show

class IsOne a where
  one :: a

instance IsOne Unit where
  one = Unit

