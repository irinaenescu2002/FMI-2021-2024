import Data.Monoid

-- Laboratorul 12

-------------------------------------------------------
-- setup pentru tree (din curs)

data BinaryTree a = Leaf a | Node ( BinaryTree a ) ( BinaryTree a )
    deriving Show

foldTree :: ( a -> b -> b ) -> b -> BinaryTree a -> b
foldTree f i ( Leaf x ) = f x i
foldTree f i (Node l r ) = foldTree f ( foldTree f i r ) l

instance Foldable BinaryTree where
    foldr :: (a -> b -> b) -> b -> BinaryTree a -> b
    foldr = foldTree

-------------------------------------------------------
-- exemple pentru testare

none :: Maybe a
none = Nothing

one :: Maybe Integer
one = Just 3

tree :: BinaryTree Integer
tree = Node(Node( Leaf 1) ( Leaf 2) ) (Node ( Leaf 3) ( Leaf 4) )

-- Exercitii pentru Foldable

-- 1. Implementati următoarele functii folosind foldMap si/sau foldr din clasa Foldable,
-- apoi testati-le cu mai multe tipuri care au instantă pentru Foldable

elem1 :: (Foldable t, Eq a) => a -> t a -> Bool
elem1 x xs = getAny $ foldMap (\h -> Any(h==x)) xs

null1 :: (Foldable t) => t a -> Bool
null1 l = getAll $ foldMap (\h -> All(False)) l

length1 :: (Foldable t) => t a -> Int
length1 l = getSum $ foldMap (\h -> 1) l

toList1 :: (Foldable t) => t a -> [a]
toList1 = foldMap (\x -> [x])

-- fold combină elementele unei structuri folosind structura de monoid a acestora

fold1 :: (Foldable t, Monoid m) => t m -> m
fold1 = foldMap id

-- Hint: folositi foldMap

-- 2. Scrieti instante ale lui Foldable pentru următoarele tipuri, implementand 
-- functia foldMap.

data Constant a b = Constant b
instance Foldable (Constant a) where 
    foldMap :: forall k (a1 :: k) m a2.Monoid m =>(a2 -> m) -> Constant a1 a2 -> m
    foldMap f (Constant b) = f b

data Two a b = Two a b
instance Foldable (Two a) where 
    foldMap :: Monoid m => (a2 -> m) -> Two a1 a2 -> m
    foldMap f (Two a b) = f b

data Three a b c = Three a b c
instance Foldable (Three a b) where 
    foldMap :: Monoid m => (a2 -> m) -> Three a1 b a2 -> m
    foldMap f (Three a b c) = f c 

data Three' a b = Three' a b b
instance Foldable (Three' a) where 
    foldMap :: Monoid m => (a2 -> m) -> Three' a1 a2 -> m
    foldMap f (Three' a b1 b2) = f b1 <> f b2

data Four' a b = Four' a b b b
instance Foldable (Four' a) where 
    foldMap :: Monoid m => (a2 -> m) -> Four' a1 a2 -> m
    foldMap f (Four' a b1 b2 b3) = f b1 <> f b2 <> f b3

data GoatLord a = NoGoat | OneGoat a | MoreGoats (GoatLord a) (GoatLord a) (GoatLord a)
instance Foldable GoatLord where
    foldMap :: Monoid m => (a -> m) -> GoatLord a -> m
    foldMap f NoGoat = mempty
    foldMap f (OneGoat g) = f g
    foldMap f (MoreGoats g1 g2 g3) =  foldMap f g1 <> foldMap f g2 <> foldMap f g3


-- Happy Goat 
--                       ████        ████                                            
--                 ██▒▒██    ░░██▒▒██                                            
--               ██▒▒██    ██▓▓▒▒██                                              
--             ██▒▒██    ██▒▒▒▒██                                                
--             ██▒▒██    ██▒▒▒▒██                                                
--             ██▒▒██    ██▒▒▓▓██                                                
--             ██▒▒██    ██▒▒▓▓██                                                
--             ██████████████████                                                
--       ██████              ░░░░██                                              
--     ██  ██                    ████                                            
--   ██  ░░██                        ██                                          
-- ██░░░░██                      ██░░  ██                                        
--   ██████                      ████░░░░██                                      
--     ██                        ██  ████                                        
--     ██      ██    ██          ██                                    ████      
--     ██      ██    ██          ██                                  ██    ██    
--     ██                          ██                                  ██    ██  
--   ██░░                    ░░░░    ██████                            ██    ██  
--   ██  ░░        ░░░░░░░░░░░░░░░░░░      ██████░░          ██████████    ██    
--   ██            ░░░░░░░░░░▒▒██░░  ░░░░░░░░  ░░████████████  ░░        ██      
--   ██            ░░░░░░░░░░▒▒██░░░░░░░░░░░░░░░░  ░░  ░░░░░░░░░░░░░░      ██    
--   ██                  ░░██▒▒  ██░░            ░░                        ██    
--   ██    ▒▒▒▒▒▒▒▒      ██        ██                                        ██  
--     ██    ▒▒▒▒        ██        ██░░                                      ██  
--       ██            ██          ██░░░░                                    ██  
--         ██        ██            ██░░░░                                    ██  
--           ██████████              ██░░░░                                  ██  
--             ██░░░░██                ██░░░░                                ██  
--             ██░░██                  ████░░░░    ░░░░░░░░░░░░░░░░░░░░      ██  
--               ██                    ██░░████░░  ░░████████████████░░░░    ██  
--                                     ██░░██  ██  ██          ██░░░░██░░░░  ██  
--                                     ██░░██  ██  ██          ██░░░░░░██░░░░  ██
--                                     ██░░██  ██  ██            ██░░░░████░░  ██
--                                     ██░░██  ██  ██              ██░░██  ██  ██
--                                     ██░░██  ██  ██              ██░░██  ██░░██
--                                     ██░░██  ██  ██              ██░░██  ██░░██
--                                     ██████  ██████              ██████  ██████
--                                     ██░░██  ██▒▒██              ██▒▒██  ██▒▒██
                                                                                           

    
