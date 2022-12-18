-- Laboratorul 1 (Macovei) 

-- 1. Jocul Piatra Foarfeca Hartie

data Alegere = Piatra | Foarfeca | Hartie 
               deriving (Eq, Show)

-- Folosim Eq pentru a preciza ca putem stabili egalitate intre doua date.
-- Folosim Show pentru a putea afisa datele sub forma de caractere. 

data Rezultat = Victorie | Infrangere | Egalitate 
                deriving (Eq, Show)

partida :: Alegere -> Alegere -> Rezultat
partida Piatra Foarfeca = Victorie
partida Piatra Hartie = Infrangere
partida Piatra Piatra = Egalitate
partida Foarfeca Piatra = Infrangere
partida Foarfeca Hartie = Victorie
partida Foarfeca Foarfeca = Egalitate
partida Hartie Hartie = Egalitate
partida Hartie Foarfeca = Infrangere
partida Hartie Piatra = Victorie

-- Pentru a scapa de trei cazuri, putem pune la final un caz general, de pattern matching.
-- Pe acest caz se va intra dupa ce toate celelate cazuri au fost verificate.  
-- De aceea este foarte important ca acesta sa fie pus la final:
---- partida Piatra Foarfeca = Victorie
---- partida Piatra Hartie = Infrangere
---- partida Foarfeca Piatra = Infrangere
---- partida Foarfeca Hartie = Victorie
---- partida Hartie Foarfeca = Infrangere
---- partida Hartie Piatra = Victorie
---- partida _ _ = Egalitate
-- Daca am pune cazul la inceput, am avea o generalizare care va genera eroare. 

-- 2. Compunerea functiilor 

f :: Int -> Int 
f x = x + 1
g :: Int -> Int 
g x = 2*x

-- *Main > f (g 2)
-- 5
-- *Main > (f . g) 2 
-- 5
-- *Main > f $ g 2
-- 5  

-- *Main > g (f 2)
-- 6
-- *Main > (g . f) 2
-- 6
-- *Main > g $ f 2 
-- 6

-- *Main > f (f (g (f (g 2))))
-- 12
-- *Main > (f . f . g . f . g) 2
-- 12
-- *Main > f $ f $ g $ f $ g 2
-- 12

-- 3. Recursivitate. Suma elementelor dintr-o lista

suma :: [Int] -> Int
suma [] = 0
suma (head:tail) = head + suma tail
