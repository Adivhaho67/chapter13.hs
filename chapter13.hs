{-# LANGUAGE OverloadedStrings #-}

import System.Directory
import Data.List (isInfixOf, sort)
import qualified Data.Map as Map
import qualified Data.List as L

---------------------------------------------------------
-- HC13T1: List Files in Directory
---------------------------------------------------------
listFiles :: IO [FilePath]
listFiles = listDirectory "."

---------------------------------------------------------
-- HC13T2: Filter Files by Substring
---------------------------------------------------------
filterFilesBySubstring :: String -> [FilePath] -> [FilePath]
filterFilesBySubstring substr = filter (isInfixOf substr)

---------------------------------------------------------
-- HC13T3: Sort and Return Filtered Files
---------------------------------------------------------
sortAndFilterFiles :: String -> IO [FilePath]
sortAndFilterFiles substr = do
    files <- listFiles
    return $ sort $ filterFilesBySubstring substr files

---------------------------------------------------------
-- HC13T4 & HC13T5: SumNonEmpty Module
---------------------------------------------------------
module SumNonEmpty (sumNonEmpty) where

sumNonEmpty :: (Num a) => [a] -> a
sumNonEmpty [] = error "Cannot sum an empty list"
sumNonEmpty xs = sum xs

-- Only sumNonEmpty is exported; helper/error hidden.

---------------------------------------------------------
-- HC13T6: File Names to Map
---------------------------------------------------------
filesToMap :: [FilePath] -> Map.Map Int FilePath
filesToMap files = Map.fromList $ zip [1..] files

---------------------------------------------------------
-- HC13T7: Use Custom Module in Main
---------------------------------------------------------
-- Example usage of sumNonEmpty:
sumExample :: IO ()
sumExample = do
    let nums = [1,2,3,4,5]
    putStrLn ("Sum using sumNonEmpty: " ++ show (SumNonEmpty.sumNonEmpty nums))

---------------------------------------------------------
-- HC13T8: Qualified Imports for Name Conflicts
---------------------------------------------------------
-- Example: using Data.List qualified import as L
qualifiedExample :: IO ()
qualifiedExample = do
    let lst = [5,1,4,2,3]
    putStrLn ("Original list: " ++ show lst)
    putStrLn ("Sorted list using qualified import: " ++ show (L.sort lst))

---------------------------------------------------------
-- HC13T9: Renaming Module Namespace
---------------------------------------------------------
-- Example: rename Data.Map as DM
renamingExample :: IO ()
renamingExample = do
    let m = DM.fromList [(1,"A"),(2,"B")]
    putStrLn ("Map content using renamed namespace: " ++ show m)

---------------------------------------------------------
-- HC13T10: Multi-Module Main Function
---------------------------------------------------------
multiModuleMain :: IO ()
multiModuleMain = do
    putStrLn "Listing all files containing 'hs' and sorting:"
    files <- sortAndFilterFiles "hs"
    mapM_ putStrLn files
    let filesMap = filesToMap files
    putStrLn ("Files as Map: " ++ show filesMap)

---------------------------------------------------------
-- MAIN FUNCTION (demonstrates all tasks)
---------------------------------------------------------
main :: IO ()
main = do
    putStrLn "\n--- HC13T1: List Files ---"
    files <- listFiles
    print files

    putStrLn "\n--- HC13T2: Filter Files by Substring ('hs') ---"
    print $ filterFilesBySubstring "hs" files

    putStrLn "\n--- HC13T3: Sort and Filter Files ---"
    sortedFiltered <- sortAndFilterFiles "hs"
    print sortedFiltered

    putStrLn "\n--- HC13T6: File Names to Map ---"
    print $ filesToMap sortedFiltered

    putStrLn "\n--- HC13T7: Use Custom Module (sumNonEmpty) ---"
    sumExample

    putStrLn "\n--- HC13T8: Qualified Imports Example ---"
    qualifiedExample

    putStrLn "\n--- HC13T9: Renaming Module Namespace Example ---"
    renamingExample

    putStrLn "\n--- HC13T10: Multi-Module Main Function ---"
    multiModuleMain
