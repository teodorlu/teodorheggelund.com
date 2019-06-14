--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid (mappend)
import           Data.Maybe (fromMaybe)
import           Hakyll
import           System.IO.Unsafe (unsafePerformIO)

--------------------------------------------------------------------------------

-- Org files from a given folder that are not hidden
from :: String -> Pattern
from folder = fromRegex $ "^" ++ folder ++ "/[^\\.][a-zA-Z0-9æøåÆØÅ\\-]*\\.org$"

fromDbg :: String -> Pattern
fromDbg folder =
  unsafePerformIO $ do
    let re = from folder
    print re
    return re

main :: IO ()
main = hakyll $ do
    match "images/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    match "static/*" $ do
      route idRoute
      compile copyFileCompiler

    match (fromList ["projects.org", "experience.org", "about.org", "resources.org"]) $ do
        route   $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= relativizeUrls

    match (from "posts") $ do
        route $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/post.html"    postCtx
            >>= loadAndApplyTemplate "templates/default.html" postCtx
            >>= relativizeUrls

    match "pages/*" $ do
        route $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" postCtx
            >>= relativizeUrls

    match (from "drafts") $ do
        route $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/post.html"    postCtx
            >>= loadAndApplyTemplate "templates/default.html" postCtx
            >>= relativizeUrls

    -- create ["archive.html"] $ do
    --     route idRoute
    --     compile $ do
    --         posts <- recentFirst =<< loadAll "posts/*"
    --         let archiveCtx =
    --                 listField "posts" postCtx (return posts) `mappend`
    --                 constField "title" "Arkiv"               `mappend`
    --                 defaultContext

    --         makeItem ""
    --             >>= loadAndApplyTemplate "templates/archive.html" archiveCtx
    --             >>= loadAndApplyTemplate "templates/default.html" archiveCtx
    --             >>= relativizeUrls


    match "index.html" $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll "posts/*"
            let indexCtx =
                    listField "posts" postCtx (return posts) `mappend`
                    constField "title" "Teodor Heggelund"    `mappend`
                    defaultContext

            getResourceBody
                >>= applyAsTemplate indexCtx
                >>= loadAndApplyTemplate "templates/default.html" indexCtx
                >>= relativizeUrls

    match "templates/*" $ compile templateCompiler

-- describeLanguage :: Text -> MString
describeLanguage lang =
  case lang of
    -- "no" -> Just " (Norwegian)"
    _ -> Nothing

languageContext :: Context a
languageContext = field "lang" $ \item -> do
    metadata <- getMetadata (itemIdentifier item)
    return $ fromMaybe "" $ lookupString "lang" metadata >>= describeLanguage

--------------------------------------------------------------------------------
postCtx :: Context String
postCtx =
    dateField "date" "%Y-%m-%d" `mappend`
    languageContext             `mappend`
    defaultContext

