-- Laboratorul 5 (Macovei)

import Numeric.Natural

-- 1. Definirea lui MAP cu foldr

-- map :: (a -> b) -> [a] -> [b]
-- map _ [] = []
-- map f (x:xs) = f x : map f xs 
-- => 
-- g :: [a] -> (a -> b) -> [b]
-- g [] _ = []
-- g (x:xs) f = f x : g xs f  
-- =>
-- g :: [a] -> (a -> b) -> [b]
-- g [] = \_ -> []
-- op x (g xs) f = f x : g xs f  
-- => 
-- g :: [a] -> (a -> b) -> [b]
-- g [] = \_ -> []
-- op x u f = f x : u f  

i :: (a -> b) -> [b]
i = \_ -> []

op :: a -> ((a -> b) -> [b]) -> (a -> b) -> [b]
op x u = \f -> f x : u f

-- ghci> (foldr op i) [1, 2, 3] (+2)
-- [3,4,5]

-- 2. Evaluarea lenesa: Haskell nu evalueaza ceea ce nu ii trebuie mai departe 

logistic :: Num a => a -> a -> Natural -> a
logistic rate start = f
                      where 
                        f 0 = start 
                        f n = rate * f (n-1) * (1 - f (n-1))

logistic0 :: Fractional a => Natural -> a
logistic0 = logistic 3.741 0.00079

-- Cu cat argumentul pe care care il dam lui logistic0 este mai mare, cu atat
-- va creste timpul de asteptare al evaluarii

ex1 :: Natural
ex1 = 20

-- Daca vrem sa afisam lista, va calcula toate elementele
ex20 :: Fractional a => [a]
ex20 = [1, logistic0 ex1, 3]

-- Daca vrem sa afisam head-ul, nu va calcula logistic0 ex1 si va afisa doar primul element. 
ex21 :: Fractional a => a
ex21 = head ex20

-- Nu va evalua toata lista, va afisa doar elementul de pe pozitia a doua. 
ex22 :: Fractional a => a
ex22 = ex20 !! 2 

-- Nu va evalua toata lista, va lua elem de pe pozitia 2 si il va impacheta intr-o alta lista. 
ex23 :: Fractional a => [a]
ex23 = drop 2 ex20

-- Va evalua doar tail-ul, adica ultimele doua elemente. 
ex24 :: Fractional a => [a]
ex24 = tail ex20

-- Pentru 5, va da direct True fara a calcula si a doua parte. 
ex31 :: Natural -> Bool
ex31 x = x < 7 || logistic0 (ex1 + x) > 2

-- Pentru 5, o sa dureze deoarece calculeaza primul caz, nu merge direct la al doilea. 
ex32 :: Natural -> Bool
ex32 x = logistic0 (ex1 + x) > 2 || x < 7

-- 3. Matrice ca lista de liste 

matrice :: Num a => [[a]]
matrice = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]

-- 3.1 Scrieti o functie care verifica daca o matrice este corecta (listele au lungime egala).
-- Luam prima si a doua linie si vedem daca sunt egale, apoi mergem cu doua cate doua 
-- recursiv pentru a verifica in continuare. 

corect :: [[a]] -> Bool
corect [] = True
corect [_] = True 
corect (x:y:xs) = length  x == length y && corect(y:xs)

-- 3.2 Scrieti o functie care returneaza elementul de pe pozitia i si j. 

el :: [[a]] -> Int -> Int -> a
el matrix line column = (matrix !! line) !! column 

-- 3.3 Scrieti o functie care genereaza o lista de forma:
-- [(elem1, i_elem1, j_elem1), (elem2, i_elem1, j_elem2)...]

enumera :: [a] -> [(a, Int)]
enumera list = zip list [0..]

insereazaPozitie :: ([(a, Int)], Int) -> [(a, Int, Int)]
insereazaPozitie (lista, linie) = map (\(x, coloana) -> (x, linie, coloana)) lista

transforma :: [[a]] -> [(a, Int, Int)]
transforma matrix = concat(map insereazaPozitie (enumera (map enumera matrix)))

transforma' :: [[a]] -> [(a, Int, Int)]
transforma' = concat . map insereazaPozitie . enumera . map enumera

-- ghci> map enumera matrice
-- [[(1,0),(2,1),(3,2)],[(4,0),(5,1),(6,2)],[(7,0),(8,1),(9,2)]]
-- [[(element, coloana sa), ....], .....]

-- ghci> enumera (map enumera matrice)
-- [([(1,0),(2,1),(3,2)],0),([(4,0),(5,1),(6,2)],1),([(7,0),(8,1),(9,2)],2)]
-- [[[(element, coloana sa), ....], linia elementelor], .....]

-- ghci> map insereazaPozitie (enumera (map enumera matrice))
-- [[(1,0,0),(2,0,1),(3,0,2)],[(4,1,0),(5,1,1),(6,1,2)],[(7,2,0),(8,2,1),(9,2,2)]]
-- inserez linia in tuplul fiecarui element 

-- ghci> concat (map insereazaPozitie (enumera (map enumera matrice)))
-- [(1,0,0),(2,0,1),(3,0,2),(4,1,0),(5,1,1),(6,1,2),(7,2,0),(8,2,1),(9,2,2)]
-- concatenez toate listele  