{-# LANGUAGE DataKinds #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE FlexibleInstances #-}

module Harm.Tables.Logic.Binary where

import Harm.Types

import GHC.TypeLits

type Decode = Maybe
type Encode = Either String

class IsBinary (n :: Nat) a | a -> n where
    dec :: W n -> Decode a
    enc :: a -> Encode (W n)

instance IsBinary 5 Rn where
    dec = return . Rn
    enc = return . unRn

instance IsBinary 5 Xn where
    dec w = Xn <$> dec w
    enc = enc . unXn

instance IsBinary 5 Wn where
    dec w = Wn <$> dec w
    enc = enc . unWn

instance IsBinary 7 Hint where
    dec w = return $ case w of
        0 -> HintNOP
        1 -> HintYIELD
        2 -> HintWFE
        3 -> HintWFI
        4 -> HintSEV
        5 -> HintSEVL
        _ -> HintUnk w
    enc h = return $ case h of
        HintNOP   -> 0
        HintYIELD -> 1
        HintWFE   -> 2
        HintWFI   -> 3
        HintSEV   -> 4
        HintSEVL  -> 5
        HintUnk w -> w
