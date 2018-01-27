{-# LANGUAGE OverloadedStrings #-}

data Dog    = Dog deriving Show
data Cat    = Cat deriving Show
data Human  = Human String deriving Show


class Greeting a where
    name    :: a -> String
    hello   :: a -> String
    hello _ = "..." -- helloのデフォルト実装
    bye     :: a -> String
    bye   _ = "..." -- byeのデフォルト実装

instance Greeting Human where
    name (Human n)  = n
    hello h         = "Hi, I'm " ++ name h ++ "."
    bye _           = "See you."

instance Greeting Dog where
    name _  = "a dog"
    hello _ = "Bow!"

instance Greeting Cat where
    name _  = "a cat"
    hello _ = "Meow..."
