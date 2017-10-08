module DoesItCompile where

bigNum = (^) 5 $ 10

-- This does /not/ work!
-- wahoo = bigNum $ 10

x :: [Char] -> IO ()
x = print

y :: IO ()
y = print "Wohoo!"

z :: IO ()
z = x "Kayoo!"


functionH :: [a] -> a
functionH (x:_) = x

functionC :: Ord a => a -> a -> Bool
functionC x y = if (x > y) then True else False

functionS :: (a, b) -> b
functionS (x, y) = y

i :: a -> a
i = id

c :: a -> b -> a
c a _ = a

c'' :: b -> a -> b
c'' = c

c' :: a -> b -> b
c' = flip c

r :: [a] -> [a]
r xs = xs ++ xs

co :: (b -> c) -> (a -> b) -> (a -> c)
co g f xs = g (f xs)

a :: (a -> c) -> a -> a
a _ val = val

a' :: (a -> b) -> a -> b
a' f a = f a
