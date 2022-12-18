-- Tema Laboratorul 2 
-- Enescu Irina Stefania (grupa 233)

import Data.List

-- 7. Exercitii: să se scrie urmatoarele functii folosind recursivitate:

-- a) myreplicate - pentru un întreg n si o valoare v întoarce lista de lungime n ce are doar elemente egale
-- cu v. Să se scrie si prototipul functiei.

myreplicate :: Int -> val -> [val]
myreplicate n v
    | n == 0 = []
    | otherwise = myreplicate(n-1) v ++ [v]

-- b) sumImp - pentru o listă de numere întregi, calculează suma valorilor impare. Să se scrie si prototipul
-- functiei.

sumImp :: [Int] -> Int
sumImp [] = 0
sumImp (h:t)
    | even h = sumImp t
    | otherwise = h + sumImp t

-- c) totalLen - pentru o listă de siruri de caractere, calculează suma lungimilor sirurilor care încep cu
-- caracterul ‘A’

totalLen :: [String] -> Int
totalLen [] = 0
totalLen (h:t)
    | take 1 h == "A" = totalLen t + length h
    | otherwise = totalLen t