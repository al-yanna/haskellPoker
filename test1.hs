hand::[Int]
hand = [27, 45, 3,  48, 44, 43, 41, 33, 12] -- flush wins
royal::[Int]
royal = [1, 10, 11, 12, 13] 
flush::[Int]
flush = [41, 44, 47, 48, 50, 10, 9]
fourkind::[Int]
fourkind = [40, 41, 27, 28, 1,  14, 15, 42, 29] -- 4 aces wins

convertHand :: [Int] -> [[Char]]
convertHand hand = 
    let cards = ["", "1C", "2C", "3C", "4C", "5C", "6C", "7C", "8C", "9C", "10C", "11C", "12C", "13C", "1D", "2D", "3D", "4D", "5D", "6D", "7D", "8D","9D", "10D", "11D", "12D", "13D", "1H", "2H", "3H", "4H", "5H", "6H", "7H", "8H","9H", "10H", "11H", "12H", "13H", "1S", "2S", "3S", "4S", "5S", "6S", "7S", "8S","9S", "10S", "11S", "12S", "13S"]
        int2Card num = cards!!num 
    in (map int2Card hand)

getRank card = let toInt tmp = read tmp::Int in if length card == 3 then toInt $ take 2 card else toInt $ take 1 card

sortRank :: [[Char]] -> [[Char]]
sortRank [] = []
sortRank (x:xs) = sortRank [y | y <- xs, getRank y <= getRank x] ++ [x] ++ sortRank [y | y <- xs, getRank y > getRank x]

group [] = []
group (x:xs) = group_loop [x] x xs
    where
    group_loop acc c [] = [acc]
    group_loop acc c (y:ys) 
     | getRank y == getRank c = group_loop (acc ++ [y]) c ys
     | otherwise = acc : group_loop [y] y ys

-- largestList $ group $ sortRank $ convertHand fourkind

largestList :: [[[Char]]] -> [[Char]]
largestList [] = []
largestList (x:xs) = 
    let l = largestList xs 
    in  if length l > length x then l else x