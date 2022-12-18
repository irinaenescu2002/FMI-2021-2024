import Language.Haskell.TH (Lit(IntegerL))
-- Laboratorul 4 (Macovei)

-- 1. Compunerea unor functii (pentru fiecare functie din lista listf
-- trebuie sa aplicam functia f).

compuneList :: (b -> c) -> [(a -> b)] -> [(a -> c)]
compuneList f listf = map (f .) listf

-- 2. Aplicarea functiilor pe un argument (aplicam argumentul a fiecarei
-- functii din lista listf)
-- aplicaList 100 [sqrt, (^2)] = [10, 10000]

aplicaList :: a -> [(a -> b)] -> [b]
aplicaList _ [] = []
aplicaList n (f:fs) = f n : aplicaList n fs

--  FUNCTIA FOLDR. PROPRIETATEA DE UNIVERSALITATE.

-- foldr :: (a -> b -> b) -> b -> [a]  -> b
-- Foldr ia o functie cu doua argumente, un elem initial, o lista de elemente
-- si intoarce un element final.
-- Practic, la fiecare pas se cumuleaza elementul initial conform functiei

-- foldr op unit [a1, a2, ... an] a1 `op` a2 `op` ... `op` an `op` unit
-- foldr (+) 0 [1, 2, 3, 4] = 1 + 2 + 3 + 4 + 0 = 10

-- Proprietatea de universalitate
-- Daca avem o functie pe care o putem scrie recursiv:
-- g [] = i
-- g (x:xs) = f x (g xs)
-- atunci functia g = foldr f i 
-- Plecand de la varianta recursiva, pot face implementarea cu foldr. 

suma :: [Int] -> Int
suma [] = 0 
suma (x:xs) = x + suma xs        -- putem rescrie: (+) x (suma xs)

-- Avem acelasi pattern, unde f este (+), g este suma, iar 0 este elem initial. 
-- Din proprietatea de universalitate, avem ca: suma = foldr (+) 0

-- Daca nu ne prindeam de smecheria cu rescrierea:
-- Rescriem: g[] = 0
--           g (x:xs) = x + g xs
-- Din th. de universalitate avem ca g(x:xs) = f x (g xs).
-- Atunci: g[] = 0
--         f x (g xs) = x + g xs
-- Notam g xs = u si avem: g[] = 0
--                         f x u = x + u
-- Acum putem deduce:
--    (\x u -> x + u) care e echivalent cu (+)
--    0 element initial 
-- Prin urmare: 
-- suma = foldr f i 
--        where 
--             i = 0
--             f x u = u + x
-- Rescris:
-- suma = foldr (\x u -> x + u) 0


-- 3. Produs recursiv

produsRec :: [Integer] -> Integer
produsRec [] = 1
produsRec (x:xs) = x * produsRec xs

produsFold :: [Integer] -> Integer
produsFold lista = foldr (*) 1 lista

-- 4. And recursiv 

andRec :: [Bool] -> Bool
andRec [] = True
andRec (x:xs) = x && andRec xs

andFold :: [Bool] -> Bool
andFold lista = foldl (&&) True lista 

-- 5. Concatenare

-- "s" ++ "tr" = "str"
-- 's' : "tr" = "str" 
-- 's' ++ 't' = eroare 
-- 's' ++ 't' + 'r' + [] = "str"
-- [1, 2, 3] ++ [3, 4, 5] = [1, 2, 3, 3, 4, 5]

concatRec :: [[a]] -> [a]
concatRec [] = []
concatRec (x:xs) = x ++ concatRec xs

concatFold :: [[a]] -> [a]
concatFold lista = foldr (++) [] lista

-- 6. Exercitiul 7 Laboratorul 5 

-- a

rmChar :: Char -> String -> String
rmChar _ [] = []
rmChar ch (x:xs) 
    | x == ch = rmChar ch xs
    | otherwise = x : rmChar ch xs

-- b

rmCharsRec :: String -> String -> String
rmCharsRec [] str = str 
rmCharsRec _ [] = []
rmCharsRec str (x:xs)
    | elem x str = rmCharsRec str xs
    | otherwise = x : rmCharsRec str xs

rmCharsFold2 :: String -> String -> String
rmCharsFold2 str1 str2 = foldr rmChar str2 str1

-- Rulare pas cu pas:
--                              rmChar sn str2
--                rmChar s(n-1) res1
--  rmChar s(n-2) res2
-- ...............................
-- Ajungem sa fie eliminate toate caracterele din str1 care sunt in str2

-- Explicatie asociativitate la dreapta:
-- foldr (rmChar) str2 str1
--                     [s1, s2, ... sn]
-- Se scot sn, ... s2, s1 pe rand din str2:
-- s1 `rmChar` s2 `rmChar` ... `rmChar` sn `rmChar` str2

-- Sa ne reamintim! Principiile de currying si uncurrying 
-- f x y z = x + y + z
-- Se poate rescrie ca: 
-- f x y = \z -> x + y + z
-- f x = \y z -> x + y + z
-- f = \x y z -> x + y + z

-- Atentie! Am inversat str1 si str2 ca sa ne folosim de proprietatea de universalitate. 

-- g [] = i
-- g (x:xs) = f x (g x)
-- =>
-- g [] str = []
-- g (x:xs) str = if elem x str then g xs str else x : g xs str 
-- => 
-- g [] = \str -> []
-- f x (g xs) str = if elem x str then g xs str else x : g xs str 
--     (am inlocut g(x:xs) cu f x (g xs))
-- => 
-- g [] = \_ -> []
-- f x u str = if elem x str then u str else x : u str 
--     (notam u = g xs)
-- =>
-- g = foldr f i 

rmCharsAlg :: String -> String -> String
rmCharsAlg = foldr (\x u str -> if elem x str then u str else x : u str)(\_ -> [])

-- rmCharsAlg "fotbal" ['a'..'l'] = "ot"

-- 6. Folosind doar recursia, scrieti o functie semn care ia ca parametru 
-- o lista de intregi si intoarce un string care contine semnul numerelor
-- care apartin intervalului [-9, 9].
-- semn [-5, -10, -9, 9, 10, -3, 0] = "--+-0"

semn :: [Integer] -> String
semn [] = ""
semn (x:xs)
    | x <= -9 = semn xs
    | x < 0 = '-' : semn xs
    | x == 0 = "0" ++ semn xs
    | x <= 9 = '+' : semn xs
    | otherwise = semn xs

-- Aplicam algoritmul: 
-- g [] = ""
-- g (x:xs) = if x < -9 then semn xs 
--            else (if x < 0 then '-' : semn xs
--                  else ...)
-- => 
-- g [] = ""
-- f x (g xs) = if x < -9 then ... 
-- => 
-- g [] = ""
-- f x u = if x < -9 then ... 
--     (notam (g xs) cu u)

unit :: String
unit = ""

f :: Integer -> String -> String
f = \x u -> if x < -9 then u 
           else (if x < 0 then '-' : u
                 else (if x == 0 then "0" ++ u
                       else (if x <= 9 then '+' : u 
                             else u)))

semnFoldr :: [Integer] -> String
semnFoldr = foldr f unit 

semnFoldrExplicit :: [Integer] -> String
semnFoldrExplicit = foldr f i 
                    where 
                        i :: String
                        i = ""
                        f :: Integer -> String -> String
                        f = \x u -> if x < -9 then u 
                                else (if x < 0 then '-' : u
                                        else (if x == 0 then "0" ++ u
                                            else (if x <= 9 then '+' : u 
                                                    else u)))

