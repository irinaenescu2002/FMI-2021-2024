
-- Laboratorul 7 (Macovei)

import Data.Char

-- 1. Functia de tip lookup (actioneaza precum dictionarele din Python)
-- Functia afiseaza stringul (valoarea) unei chei.

myLookUp :: Int -> [(Int, String)] -> Maybe String 
myLookUp _ [] = Nothing 
myLookUp element (x:xs) 
    | element == fst x = Just (snd x)
    | otherwise        = myLookUp element xs

myLookUpFoldr :: Foldable t => t (Int, String) -> Int -> Maybe String
myLookUpFoldr list = foldr f i list 
    where 
        i :: Int -> Maybe String
        i = \_ -> Nothing 
        f :: (Int, String) -> (Int -> Maybe String) -> Int -> Maybe String
        f = \x u element -> if element == fst x then Just (snd x) else u element 

myLookUpFold :: Int -> [(Int, String)] -> Maybe String
myLookUpFold element = foldr (\x found -> if fst x == element then Just (snd x) else found) Nothing


-- 2. Sa se scrie o functie myLookUp' cu aceeasi signatura ca myLookUp care, atunci cand gaseste valoarea
-- capitalizeaza prima litera. (i.e. transforma prima litera in majuscula).

myLookUp' :: Int -> [(Int, String)] -> Maybe String 
myLookUp' _ [] = Nothing
myLookUp' element (x:xs)
    | element == fst x = Just (toUpper(head(snd x)) : tail(snd x))
    | otherwise = myLookUp' element xs

myLookUp1' :: Int-> [(Int, String)] -> Maybe String
myLookUp1' _ [] = Nothing
myLookUp1' element (x:xs)
    | element == fst x = Just (toUpper x1 : x2)
    | otherwise = myLookUp1' element xs
    where x1 : x2 = snd x