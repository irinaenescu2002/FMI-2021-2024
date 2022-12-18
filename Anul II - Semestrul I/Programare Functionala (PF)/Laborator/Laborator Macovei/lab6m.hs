-- Labortorul 6 (Macovei)

-- 1. Definirea lui MAP cu foldr

-- Primul pas este sa avem functia intr-o forma recursiva, cat mai apropiata de 
-- proprietatea de universalitate: g[] = i
--                                 g (x:xs) = op x (g xs) 
-- map :: (a -> b) -> [a] -> [b]
-- map _ [] = []
-- map f (x:xs) = f x : map f xs 
-- => 
-- Rescriu functia map, aducand lista pe prima pozitie (inversez parametrii). 
-- g :: [a] -> (a -> b) -> [b]
-- g [] _ = []
-- g (x:xs) f = f x : g xs f  
-- =>	
-- Transformam cazul de oprire cu un lambda function pentru a ajunge mai aproape
-- de forma standard si a obtine i (elementul initial) de forma (a -> b) -> [b].
-- g :: [a] -> (a -> b) -> [b]
-- g [] = \_ -> []
-- g (x:xs) f = f x : g xs f  
-- => 
-- Din proprietatea de universalitate, inlocuim g (x:xs) cu op x (g xs). 
-- g :: [a] -> (a -> b) -> [b]
-- g [] = \_ -> []
-- op x (g xs) f = f x : g xs f  
-- => 
-- Notez g xs := u si inlocuiesc. 
-- g :: [a] -> (a -> b) -> [b]
-- g [] = \_ -> []
-- op x u f = f x : u f  

-- Am obtinut elementul initial: 
i :: (a -> b) -> [b]
i = \_ -> []

-- Am obtinut functia:
op :: a -> ((a -> b) -> [b]) -> (a -> b) -> [b]
op = \x u f -> f x : u f

mapFold :: [a] -> (a -> b) -> [b]
mapFold = foldr op i 

-- 2. Functia ordonata rescrisa cu foldr.
-- Scrieti o functie care verifica daca o lista este ordonata dupa un anumit criteriu.

ordonata :: [a] -> (a -> a -> Bool) -> Bool
ordonata [] _ = True
ordonata [x] _ = True
ordonata (h:t) rel = (and [rel h y | y <- t]) && ordonata t rel

ordonata' :: [a] -> (a -> a -> Bool) -> Bool
ordonata' [] _ = True
ordonata' [x] _ = True
ordonata' (x:y:xs) rel 
    | rel x y = ordonata' (y:xs) rel
    | otherwise = False 

-- e suficient sa se compare un x cu succesorul lui
-- list = [1, 2, 3, 4, 5, 6]
-- [(1, 2), (2, 3), (3, 4), (4, 5), (5, 6)] === [(x succ x)] === zip list (tail list)
-- Cum?
-- zip [1, 2, 3, 4, 5, 6] [2, 3, 4, 5, 6] => (1, 2), (2, 3), (3, 4), (4, 5), (5, 6)
--         length = 6        length = 5
-- Trebuie sa verific de fapt ca orice tuplu din lista zip list (tail list) respecta relatia

ordonataT :: [(a, a)] -> (a -> a -> Bool) -> Bool
ordonataT [] _ = True
ordonataT ((x, y) : xs) rel
    | rel x y  = ordonataT xs rel
    | otherwise = False 

-- g :: [(a, a)] -> (a -> a -> Bool) -> Bool
-- g [] = \_ -> True
-- g ((x, y) : xs) rel
--     | rel x y  = g xs rel
--     | otherwise = False 
-- =>
-- g :: [(a, a)] -> (a -> a -> Bool) -> Bool
-- g [] = \_ -> True
-- g ((x, y) : xs) rel = 
--     if rel x y then g xs rel
--     else False 
-- => 
-- g :: [(a, a)] -> (a -> a -> Bool) -> Bool
-- g [] = \_ -> True
-- g (x : xs) rel = 
--     if rel (fst x) (snd x) then g xs rel
--     else False 
-- =>
-- Inlocuim g (x:xs) cu f x (g xs) rel = ...
-- =>
-- Notam u := g xs
-- => 
-- Solutia 

iord ::  (a -> a -> Bool) -> Bool
iord = \_ -> True

f :: (a, a) -> ((a -> a -> Bool) -> Bool) -> ((a -> a -> Bool) -> Bool)
f = \x u rel ->  if rel (fst x) (snd x) then u rel else False 

ordonataTF :: [a] -> (a -> a -> Bool) -> Bool
ordonataTF list = foldr f iord (zip list (tail list))
            --  where 
            --     iord ::  (a -> a -> Bool) -> Bool
            --     iord = \_ -> True

            --     f :: (a, a) -> ((a -> a -> Bool) -> Bool) -> ((a -> a -> Bool) -> Bool)
            --     f = \x u rel ->  if rel (fst x) (snd x) then u rel else False 

-- 3. TIPURI DE DATE 

-- Stim ca o lista contine doar elemente de acelasi tip. Cum facem daca vrem sa avem o lista 
-- care contine si char-uri si int-uri?

data CharInt = I Int | C Char 
-- atentie, constructorul de date si cel de tip trebuie scris cu litera mare

list :: [CharInt]
list = [C 'c', I 4, I 6, I 89, C 'y']

