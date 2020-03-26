{-# LANGUAGE PatternSynonyms #-}
{-# LANGUAGE ViewPatterns #-}
-- |
-- Module       : Data.Text.Encoding.Base16.Lens
-- Copyright    : (c) 2019 Emily Pillmore
-- License      : BSD-style
--
-- Maintainer   : Emily Pillmore <emilypi@cohomolo.gy>
-- Stability    : Experimental
-- Portability  : non-portable
--
-- This module contains 'Prism''s for Base16-encoding and
-- decoding lazy 'ByteString' values.
--
module Data.ByteString.Lazy.Base16.Lens
( -- * Prisms
  _Hex
, _Base16
  -- * Patterns
, pattern Hex
, pattern Base16
) where


import Control.Lens

import Data.ByteString.Lazy (ByteString)
import qualified Data.ByteString.Lazy.Base16 as B16L


-- $setup
--
-- >>> import Control.Lens
-- >>> import Data.ByteString.Lazy.Base16.Lens
--
-- >>> :set -XOverloadedStrings
-- >>> :set -XTypeApplications


-- -------------------------------------------------------------------------- --
-- Optics

-- | A 'Prism'' into the Base16 encoding of a 'ByteString' value
--
-- >>> _Base16 # "Sun"
-- "53756e"
--
-- >>> "53756e" ^? _Base16
-- Just "Sun"
--
_Base16 :: Prism' ByteString ByteString
_Base16 = prism' B16L.encodeBase16' $ \s -> case B16L.decodeBase16 s of
    Left _ -> Nothing
    Right a -> Just a
{-# INLINE _Base16 #-}

-- | A 'Prism'' into the Base16 encoding of a lazy 'ByteString' value. This function
-- is an alias of '_Base16'.
--
-- >>> _Hex # "Sun"
-- "53756e"
--
-- >>> "53756e" ^? _Hex
-- Just "Sun"
--
_Hex :: Prism' ByteString ByteString
_Hex = prism' B16L.encodeBase16' $ \s -> case B16L.decodeBase16 s of
    Left _ -> Nothing
    Right a -> Just a
{-# INLINE _Hex #-}

-- -------------------------------------------------------------------------- --
-- Patterns

-- | Bidirectional pattern synonym for Base16-encoded lazy 'ByteString' values.
--
pattern Hex :: ByteString -> ByteString
pattern Hex a <- (preview _Hex -> Just a) where
    Hex a = _Hex # a

-- | Bidirectional pattern synonym for Base16-encoded lazy 'ByteString' values.
--
pattern Base16 :: ByteString -> ByteString
pattern Base16 a <- (preview _Base16 -> Just a) where
    Base16 a = _Base16 # a
