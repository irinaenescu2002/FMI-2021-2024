-- Laboratorul 2

-- 1. Să se scrie o functie poly2 care are patru argumente de tip Double, a,b,c,x s, i calculează a*xˆ2+b*x+c.
-- Scrieti si signatura functiei (poly :: ceva).

poly :: Double -> Double -> Double -> Double -> Double
poly a b c x = a*x*x+b*x+c

-- 2. Să se scrie o functie eeny care întoarce “eeny” pentru input par s, i “meeny” pentru input impar. Hint:
-- puteti folosi functia even (puteti căuta pe https://hoogle.haskell.org/).
-- eeny :: Integer -> String
-- eeny = undefined

eeny :: Integer -> String
eeny x = if mod x 2 == 0 then "eeny" else "meeny"

eeny2 :: Integer -> String
eeny2 x = if even x then "eeny" else "meeny"

eeny3 :: Integer -> String
eeny3 x 
    | even x = "eeny"
    |otherwise = "meeny"

-- Să se scrie o functie fizzbuzz care întoarce “Fizz” pentru numerele divizibile cu 3, “Buzz” pentru
-- numerele divizibile cu 5 si “FizzBuzz” pentru numerele divizibile cu ambele. Pentru orice alt număr se
-- întoarce sirul vid. Pentru a calcula modulo a două numere puteti folosi functia mod. Să se scrie această
-- functie în 2 moduri: folosind if si folosind gărzi (conditii).

fizbuzz :: Integer -> String
fizbuzz x 
    | mod x 3 == 0 && mod x 5 == 0 = "fizbuzz"
    | mod x 3 == 0 = "fizz"
    | mod x 5 == 0 = "buzz"
    | otherwise = ""

fizbuzz2 :: Integer -> String
fizbuzz2 x 
    | mod x 15 == 0 = "fizbuzz"
    | mod x 3 == 0 = "fizz"
    | mod x 5 == 0 = "buzz"
    | otherwise = ""

fizbuzz3 :: Integer -> String
fizbuzz3 x = if mod x 15 == 0 then "fizbuzz"
else if mod x 3 == 0 then "fizz"
else if mod x 5 == 0 then "buzz"
else ""

-- Un foarte simplu exemplu de recursie este acela al calculării 
-- unui element de index dat din secventa numerelor Fibonacci.

fibonacciCazuri :: Integer -> Integer
fibonacciCazuri n
    | n < 2 = n
    | otherwise = fibonacciCazuri (n - 1) + fibonacciCazuri (n - 2)

fibonacciEcuational :: Integer -> Integer
fibonacciEcuational 0 = 0
fibonacciEcuational 1 = 1
fibonacciEcuational n = fibonacciEcuational (n - 1) + fibonacciEcuational (n - 2)

-- 4. Numerele tribonacci sunt definite de ecuatt, ia
-- Tn =
------- 1 dacă n = 1
------- 1 dacă n = 2
------- 2 dacă n = 3
------- Tn-1 + Tn-2 + Tn-3 dacă n > 3
-- Să se implementeze functia tribonacci atât cu cazuri cât si ecuational.

tribonacci :: Integer -> Integer
tribonacci 1 = 1
tribonacci 2 = 1
tribonacci 3 = 2
tribonacci n = tribonacci(n-1) + tribonacci(n-2) + tribonacci(n-3)

tribonacci2 :: Integer -> Integer
tribonacci2 n
    | n == 1 = 1
    | n == 2 = 1
    | n == 3 = 2
    | otherwise = tribonacci2(n-1) + tribonacci2(n-2) + tribonacci2(n-3)

-- 5. Să se scrie o functie care calculează coeficientii binomiali, folosind recursivitate. Acestia sunt determinati
-- folosind urmatoarele ecuatii.
-- B(n,k) = B(n-1,k) + B(n-1,k-1)
-- B(n,0) = 1
-- B(0,k) = 0

binomial :: Integer -> Integer -> Integer
binomial n k 
    | n == 0 = 0
    | k == 0 = 1
    | otherwise = binomial (n-1) k + binomial (n-1) k-1

binomial2 :: Integer -> Integer -> Integer
binomial2 n 0 = 1
binomial2 0 k = 1
binomial2 n k = binomial (n-1) k + binomial2 (n-1) k+1 

---------------- FUNCTII -----------------
-- 1. head -- primul element al unei liste 
----- tail -- restul listei 
----- head :: [a] -> a
----- head(h:t) = h
----- tail:: [a] -> a
----- tail(h:t) = t
----- "abc" --> head-ul este a si tail-ul este restul listei
-- 2. take -- primele n elemente din lista l
----- take :: [a] -> a
----- take n l (apel)
-- 3. drop -- scapam de primele k elemente din lista
----- drop :: [a] -> [a]
----- drop 2 "abcd" -> "cd" (am scapat de primele 2)
-- 4. length -- lungimea listei
----- length "abcd" -> 4 

-- Să se implementeze următoarele functii folosind liste:
-- a) verifL - verifică dacă lungimea unei liste date ca parametru este pară
-- verifL :: [Int] -> Bool
-- verifL = undefined

verifL :: [Int] -> Bool
verifL a = if even(length a) then True else False

verifL2 :: [Int] -> Bool
verifL2 a 
    | even (length a) = True
    |otherwise = False

-- b) takefinal - pentru o listă dată ca parametru si un număr n, întoarce lista cu ultimele n elemente.
-- Dacă lista are mai putin de n elemente, se intoarce lista nemodificată.
-- takefinal :: [Int] -> Int -> [Int]
-- takefinal = undefined
-- Cum trebuie să modificăm prototipul functiei pentru a putea fi folosită si pentru siruri de caractere?

takefinal :: [Int] -> Int -> [Int]
takefinal l n = if (length l) < n then l else drop ((length l) - n) l

takefinall :: [Int] -> Int -> [Int]
takefinall l n 
    | length l < n = l
    | otherwise = drop(length l - n) l

-- c) remove - pentru o listă si un număr n se întoarce lista din care se sterge elementul de pe pozitia n.
-- (Hint: puteti folosi functiile take si drop). Scriti si prototipul functiei.
-- ++ este folosit pentru a aduna doua liste 

remove :: [Int] -> Int -> [Int]
remove l n = take(n-1) l ++ drop n l

