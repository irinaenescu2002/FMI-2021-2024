-- Laboratorul 2 (Macovei) 

-- 1. Integer -> numerele pot fi oricat de mari, putem face
-- operatii cu numere oricat de mari 
-- ex: myInt = 99999...999

-- 2. Haskell nu suporta abordari iterative.
-- Implementarea operatiilor pentru structuri repetitive se face prin recursie. 

-- 3. Prelucrarea listelor de elemente 

-- [Int] -> lista de Int-uri
-- [Char] -> lista de Char-uri, echivalent cu un String 

-- [1, 2, 3, 4] are un head [1] si un tail [2, 3, 4] si se noteaza (h:t)

-- Denumim functia lenght deoarece daca o denumim corect, length, aceasta
-- va coincide cu functia predefinita din Haskell si va genera 
-- eroare deoarece nu o putem suprascrie. 

lenght :: [Integer] -> Integer
lenght [] = 0
lenght (h:t) = 1 + lenght t

-- lenght [1, 2, 3, 4] =
--    1 + lenght [2, 3, 4]
--        1 + lenght [3, 4]
--            1 + lenght [4]
--                1 + lenght []
--                    0

--  4. Scrieti functia semiPare care primeste o lista de intregi ca parametru.  
-- Aceasta elimina numerele impare si imparte la 2 numerele pare.
-- semiPare [0, 2, 1, 7, 8, 56, 17, 18] = [0, 1, 4, 28, 9]

-- Functia odd -> daca un elemnt este impar
-- Functia even -> daca un element este par 

semiPare :: [Integer] -> [Integer]
semiPare [] = []
semiPare (h:t) 
    | odd h = semiPare t
    | otherwise = div h 2 : semiPare t

-- [0, 2, 1, 7, 8, 56, 17, 18]
-- 0/2 = 0 : semiPare [2, 1, 7, 8, 56, 17, 18]
--         2/2 = 1 : semiPare [1, 7, 8, 56, 17, 18]
--                 : semiPare [7, 8, 56, 17, 18]
--                 : semiPare [8, 56, 17, 18]
--                 8/2 = 4 : semiPare [56, 17, 18]
--                           56/2 = 28 : semiPare [17, 18]
--                                       semiPare [18]
--                                       18/2 = 9 : semiPare[]
--                                                  []
                                    
semiPare2 :: [Integer] -> [Integer]
semiPare2 list 
    | null list = list
    | even h = div h 2 : t'
    | otherwise = t'
    where h = head list
          t = tail list
          t' = semiPare2 t

-- Listele definite prin Comprehensiune
-- {0, 2, 4, 6, 8, 10} => {x | x apartine {1, .. 10}, x par}
-- [0, 2, 4, 6, 8, 10] = [x | x<-[0..10], even x]
--                     = [2*x | x<-[0..5]]

-- Pentru a accesa elementul de pe o pozitie dintr-o lista: lista !! pozitie
-- De exemplu, pentru a extrage mijlocul unei liste folosim:
-- lista !! (div (lenght lista) 2)

semiPareCom :: [Integer] -> [Integer]
semiPareCom list = [div x 2 | x<-list, even x]

-- div x 2 = x `div` 2

-- 5. Scrieti o functie care primeste ca parametri doi intregi (limita inferioara 
-- si superioara a unui interval) si o lista (o multime de numere) si intoarce elementele care 
-- apartin multimii date si se incadreaza in limitele intervalului.
-- inInterval 5 10 [1..15] = [5, 6, 7, 8, 9, 10]

inIntervalRec :: Int -> Int -> [Int] -> [Int]
inIntervalRec _ _ [] = []
inIntervalRec inf sup (h:t) 
    | h >= inf && h <= sup = h : inIntervalRec inf sup t
    | otherwise = inIntervalRec inf sup t

inIntervalComp :: Int -> Int -> [Int] -> [Int]
inIntervalComp inf sup list = [x | x<-list, x >= inf && x <= sup]

-- 6. Scrieti o functie care nnumara cate elemente strict pozitive sunt intr-o lista.

pozitiveRec :: [Int] -> Int
pozitiveRec [] = 0
pozitiveRec (h:t) = if h >= 0 then 1 + pozitiveRec t else pozitiveRec t

pozitiveRec2 :: [Int] -> Int
pozitiveRec2 [] = 0
pozitiveRec2 (h:t) 
    | h >= 0 = 1 + pozitiveRec t 
    | otherwise = pozitiveRec t

pozitiveComp :: [Int] -> Int
pozitiveComp list = length [x | x<-list, x>=0]

-- 7. Problema 7 laboratorul 3 

-- pozitiiImpare [0, 1, 2, 3] 0
--     pozitiiImpare [1, 2, 3] 1 
--         1 : pozitiiImpare [2, 3] 2
--                 pozitiiImpare [3] 3
--                     3 : pozitiiImpare [] 4
--                             []

-- Tratam String ca [Char] si folosim tot (h:t) pentru a parcurge. 
-- In cazul in care aveam [Char] in signatura functiei, "" devenea []. 