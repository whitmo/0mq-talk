{-# LANGUAGE OverloadedStrings #-}
-- |
-- Pub/Sub envelope publisher p.75
-- 
module Main where

import System.ZMQ4.Monadic
import Control.Concurrent (threadDelay)
import Control.Monad (forever)

main :: IO ()
main = 
    runZMQ $ do
        publisher <- socket Pub
        bind publisher "tcp://*:5563"
        forever $ do
            send publisher [SendMore] "A"
            send publisher [] "More sugar"
            send publisher [SendMore] "B" 
            send publisher [] "I'm a teapot" 
            liftIO $ threadDelay $ 1 * 1000 * 1000
