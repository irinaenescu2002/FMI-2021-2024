-- Laboratorul 3 (Macovei)

-- 1. Functiile de nivel inalt 

-- Nu este suficient sa spunem f :: a -> a deoarece trebuie sa precizam ce tip
-- de clasa este a pentru a stii cum sa se comporte +.  

f :: (Num a) => a -> a
f x = x + 1

aplica2 :: (a -> a) -> a -> a
aplica2 f n = f (f n)

-- 2. Doua functii de nivel inalt sunt map si filter. 

-- Map aplica functia data pe fiecare element al listei. 
-- map :: (a -> b) -> [a] -> [b]
-- map f list = [f x | x <- list]

-- Toate rezultatele de mai jos sunt echivalente -> [2, 3, 4]
rezultat = map f [1, 2, 3]           
rezultat2 = map (\x -> x + 1) [1, 2, 3]   -- lambda expresie 
rezultat3 = map (+1) [1, 2, 3]            -- sectiune

-- Va calcula fiecare functie din lista cu argumentul 3:
-- map ($3) [(4+), (10*), (^2), sqrt]
-- [7.0,30.0,9.0,1.7320508075688772]

-- Filter filtreaza lista dupa o annumita proprietate data ca functie. 
-- filter :: (a -> Bool) -> [a] -> [b]

-- filter (\x -> x>2) [1, 2, 3, 4] => [3, 4]

-- 3. Ordonare folosind comprehensiunea (verificati daca o lista este ordonata).

-- and [True, False, False] => False 
-- and [True, True] => True
-- and [1<2, 2<3, 3<4] => True

ordonataNat :: [Int] -> Bool
ordonataNat [] = True
ordonataNat [x] = True
ordonataNat (h:t) = (and [h <= y | y <- t]) && ordonataNat t

-- Aceeasi functie, dar fara comprehensiune, doar recursiv 
-- Extragem primele doua elemente ale listei pentru a le compara doua cate doua
-- pana ajungem la ultimul element. 

ordonataNat2 :: [Int] -> Bool
ordonataNat2 [] = True
ordonataNat2 [x] = True
ordonataNat2 (h1 : h2 : t) = (h1 <= h2) &&  ordonataNat2 (h2:t)

-- Scrieti aceasta functie de ordonare pe cazuri generale. 
-- ordonataNat = ordonata list(<=)
-- Functia primeste o lista, un predicat si un raspuns boolean. 

ordonata :: [a] -> (a -> a -> Bool) -> Bool
ordonata [] _ = True
ordonata [x] _ = True
ordonata (h:t) rel = (and [rel h y | y <- t]) && ordonata t rel

-- ordonata (reverse [1..10]) (>) = True

-- 4. Definiti operatorul *<* pe tupluri.

(*<*) :: (Integer, Integer) -> (Integer, Integer) -> Bool
(*<*)(a, b)(c, d) 
    |(a < c) || (a == c && b <= d) = True
    | otherwise = False

