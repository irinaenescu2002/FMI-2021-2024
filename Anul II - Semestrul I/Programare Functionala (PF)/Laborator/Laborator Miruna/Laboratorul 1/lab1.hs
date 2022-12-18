-- Laborator 1

-- Observam ca myInt nu se mai poate modifica, e constanta.
-- Definirea unei functii 
--------- (a -> a): de la un anume tip de date a la acelasi tip de date) 
--------- folosim =

import Data.List
myInt = 5555555555555555555555555555555555555555555555555555555555555555555555555555555555555 
double :: Integer -> Integer 
double x = x+x   

-- Scrieti o functie ce determina maximul dintre doua numere, respectiv trei.

maxim :: Integer -> Integer -> Integer
maxim x y = if (x > y)
               then x
          else y

max3 x y z = let
             u = maxim x y
             in (maxim  u z)


-- 6. Să se scrie următoarele functii:
-- a) functie cu 2 parametri care calculeaza suma pătratelor celor două numere;

patrate :: Integer -> Integer -> Integer
patrate x y = x*x + y*y

-- b) functie cu un parametru ce întoarce mesajul “par” dacă parametrul este par si “impar” altfel;

paritate :: Integer -> String 
paritate p = if mod p 2 == 1
                then "impar"
            else "par"

-- c) functie care calculează factorialul unui număr;

factorial :: Integer -> Integer 
factorial x = if x == 0 
                then 1 
            else x*factorial(x-1)

-- d) functie care verifică dacă un primul parametru este mai mare decât dublul celui de-al doilea
-- parametru.

dublu :: Integer -> Integer -> Bool
dublu x y = if x>2*y 
                then True
            else False
