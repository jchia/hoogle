{-# LANGUAGE TemplateHaskell #-}
module General.Embedded
  ( embeddedHtml
  , embeddedJsJquery
  , embeddedJsFlot
  , embeddedJsFlotTime
  ) where

import qualified Data.ByteString as BS
import Data.FileEmbed (embedDir, embedFile, makeRelativeToProject)
import Language.Haskell.TH.Syntax (runIO)
import qualified Language.Javascript.JQuery as JQuery
import qualified Language.Javascript.Flot as Flot

-- | All files under @html/@ in the source tree, embedded at compile time.
-- Paths are forward-slash relative (e.g. @"index.html"@, @"plugin/chosen.css"@).
embeddedHtml :: [(FilePath, BS.ByteString)]
embeddedHtml = $(makeRelativeToProject "html" >>= embedDir)

-- | Bytes of jquery's main JS file, read at compile time from the
-- upstream @js-jquery@ package's data-files. After compilation the
-- binary has no runtime dependency on those data-files.
embeddedJsJquery :: BS.ByteString
embeddedJsJquery = $(runIO JQuery.file >>= embedFile)

-- | Bytes of flot's main JS file, read at compile time from
-- @js-flot@'s data-files.
embeddedJsFlot :: BS.ByteString
embeddedJsFlot = $(runIO (Flot.file Flot.Flot) >>= embedFile)

-- | Bytes of flot's time-axis JS file, read at compile time from
-- @js-flot@'s data-files.
embeddedJsFlotTime :: BS.ByteString
embeddedJsFlotTime = $(runIO (Flot.file Flot.FlotTime) >>= embedFile)
