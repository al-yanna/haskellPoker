module Poker where
    -- TO DO: 
    --  1. isStraight 
    --      check for:
    --      1a. low ace straight (A2345) - lowest possible straight
    --      2a. high ace straight (10JQKA) - highest possible straight

    hand::[Int]
    hand = [27, 45, 3,  48, 44, 43, 41, 33, 12] -- flush wins
    royalFlush :: [Int]
    royalFlush = [ 40, 41, 42, 43, 48, 49, 50, 51, 52 ]
    royal::[Int]
    royal = [1, 10, 11, 12, 13] 
    flush::[Int]
    flush = [41, 44, 47, 48, 50, 10, 9]
    fourkind::[Int]
    fourkind = [40, 41, 27, 28, 1,  14, 15, 42, 29] -- 4 aces wins
    fullHouse::[Int]
    fullHouse = [ 17, 39, 30, 52, 44, 25, 41, 51, 12 ] 
    fullHouse1::[Int]
    fullHouse1 = [ 1, 5, 14, 5, 47, 25, 41, 51, 12 ] -- 12 12 12 4 4 vs 12 12 12 5 5 
    twoPair :: [Int]
    twoPair = [ 1, 7, 1, 7, 39, 28, 21, 48, 52 ] -- 1 1 13 13 vs 7 7 13 13
    twoPair1 :: [Int]
    twoPair1 = [ 12, 11, 8, 7, 25, 24, 20, 48, 21 ] -- 12 12 8 8 vs 11 11 7 7
    straight :: [Int]
    straight = [ 11, 25, 9,  39, 50, 48, 3,  49, 45 ]
    
    deal :: [Int] -> [[Char]]
    deal hand = 
        let p1 = snd $ evalHand $ fst $ shuf hand
            p2 = snd $ evalHand $ snd $ shuf hand
            p1Rank = fst $ evalHand $ fst $ shuf hand
            p2Rank = fst $ evalHand $ snd $ shuf hand
        in  
        if p1Rank /= p2Rank then if p1Rank < p2Rank then p1 else p2
        else if tieBreaker (p1, p2) then p1 else p2
  
    tieBreaker :: ([[Char]], [[Char]]) -> Bool
    tieBreaker hands =
        let ace = (containsAce $ map getRank $ fst hands, containsAce $ map getRank $ snd hands)
            highestRank = (map getRank $ highestCard $ map getRank $ fst hands, map getRank $ highestCard $ map getRank $ snd hands)
            secondHighest = (map getRank $ highestCard $ filter (<((fst highestRank)!!0)) $ map getRank $ fst hands, map getRank $ highestCard $ filter (<((snd highestRank)!!0)) $ map getRank $ snd hands)
        in  if (fst ace && not (snd ace)) then True
            else if (not (fst ace) && snd ace) then False
            else if (fst highestRank) > (snd highestRank) then True
            else if (fst highestRank) < (snd highestRank) then False
            else if (fst secondHighest) > (snd secondHighest) then True
            else False

    shuf :: [Int] -> ([Int], [Int])
    shuf hand = 
        let sharePool = drop (length hand - 5) hand
            p1 = hand!!0:[] ++ hand!!2:[] ++ sharePool
            p2 = hand!!1:[] ++ hand!!3:[] ++ sharePool
        in (p1, p2)

    convertHand :: [Int] -> [[Char]]
    convertHand hand = 
        let cards = ["", "1C", "2C", "3C", "4C", "5C", "6C", "7C", "8C", "9C", "10C", "11C", "12C", "13C", "1D", "2D", "3D", "4D", "5D", "6D", "7D", "8D","9D", "10D", "11D", "12D", "13D", "1H", "2H", "3H", "4H", "5H", "6H", "7H", "8H","9H", "10H", "11H", "12H", "13H", "1S", "2S", "3S", "4S", "5S", "6S", "7S", "8S","9S", "10S", "11S", "12S", "13S"]
            int2Card num = cards!!num 
        in (map int2Card hand)

    evalHand :: [Int] -> (Int, [[Char]])
    evalHand hand = 
        -- 1. royal flush
        -- 2. straight flush
        -- if (length $ sameSuit $ isStraight hand) == 5 then (2, sameSuit hand) 
        -- 3. four of a kind
        if ((length $ largestList $ sameRank hand) == 4) then (3, largestList $ sameRank hand) 
        -- 4. full house  
        else if ((length $ twoLargest $ sameRank hand) == 5) then (4, twoLargest $ sameRank hand)
        -- 5. flush 
        else if ((length $ sameSuit hand) == 5) then (5, sameSuit hand)
        -- 6. straight
        -- if ((length $ isStraight hand) == 5 then (6, isStraight hand) 
        -- 7. 3 of a kind
        else if ((length $ largestList $ sameRank hand) == 3) then (7, largestList $ sameRank hand) 
        -- 8. Two Pair
        else if ((length $ twoLargest $ sameRank hand) == 4) then (8, twoLargest $ sameRank hand) 
         -- 9. pair
        else if ((length $ largestList $ sameRank hand) == 2) then (9, largestList $ sameRank hand)
        -- 10. high card
        else (10, highestCard hand) 
 
    -- helper functions -------------------------------------------------

    -- isStraight :: [Int] -> [[Char]]
    -- 1. remove duplicates (done)
    -- 2. sort w/o duplicates (done)
    -- 3. check for 10 11 12 13 1, return straight ace
    -- 4. else return straight
    isStraight :: [Int] -> [[Char]]
    isStraight hand =
        let remDuplicates hand = map head $ group $ reverseRank $ convertHand hand
            noDuplicates =  remDuplicates hand
        in  noDuplicates -- temporary return
            
    sameSuit :: [Int] -> [[Char]]
    sameSuit hand =
        let splitSuits hand = [filter isHeart hand, filter isDiamond hand, filter isClub hand, filter isSpade hand]
            largestSuit = largestList $ splitSuits $ convertHand hand
        in dropTo5 largestSuit

    sameRank :: [Int] -> [[[Char]]]
    sameRank hand = group $ reverseRank $ convertHand hand

    containsAce :: [Int] -> Bool
    containsAce hand = 
        let find ace [] = False
            find ace (card:hand) = if card == ace then True else find ace hand
        in  if (find 1 hand) then True else if (find 14 hand) then True
            else if (find 27 hand) then True else if (find 40 hand) then True else False

    highestCard :: [Int] -> [[Char]]
    highestCard hand = 
        if containsAce hand then take 1 (sortRank $ convertHand hand)
        else drop ((length hand)-1) (sortRank $ convertHand hand)

    -- other functions -------------------------------------------------

    getSuit card = card!!(length card - 1)
    getRank card = let toInt tmp = read tmp::Int in if length card == 3 then toInt $ take 2 card else toInt $ take 1 card
    isHeart card = getSuit card == 'H'
    isDiamond card = getSuit card == 'D'
    isClub card = getSuit card == 'C'
    isSpade card = getSuit card == 'S'

    dropTo5 :: [[Char]] -> [[Char]]
    dropTo5 list = 
            if length list == 7 then drop 2 list else if length list == 6 then drop 1 list else list

    group [] = []
    group (x:xs) = group_loop [x] x xs
        where
        group_loop acc c [] = [acc]
        group_loop acc c (y:ys) 
         | getRank y == getRank c = group_loop (acc ++ [y]) c ys
         | otherwise = acc : group_loop [y] y ys

    largestList :: [[[Char]]] -> [[Char]]
    largestList [] = []
    largestList (x:xs) = let l = largestList xs in if length l > length x then l else x

    twoLargest :: [[[Char]]] -> [[Char]]
    twoLargest hand = 
        let s = filter (/= largestList hand) hand
            l = largestList hand
        in l ++ largestList s 

    sortRank :: [[Char]] -> [[Char]]
    sortRank [] = []
    sortRank (x:xs) = sortRank [y | y <- xs, getRank y <= getRank x] ++ [x] ++ sortRank [y | y <- xs, getRank y > getRank x]

    reverseRank :: [[Char]] -> [[Char]]
    reverseRank [] = []
    reverseRank (x:xs) = reverseRank [y | y <- xs, getRank y > getRank x] ++ [x] ++ reverseRank [y | y <- xs, getRank y <= getRank x]

    -- Made some unique thing for checking isStraight
    -- console: sortRank $ uniqueRank [] [] $ convertHand straight
    uniqueRank x y [] = x 
    uniqueRank x y (a:xs) = 
        if length a == 2 then 
            if (take 1 a) `elem` y then uniqueRank x y xs 
            else uniqueRank (a:x) (take 1 a:y) xs
        else if (take 2 a) `elem` y then uniqueRank x y xs 
        else uniqueRank (a:x) (take 2 a:y) xs
