module Poker where
    -- Made by Alyanna Santos [500962963] & Ralph Liton [500958086]

    deal :: [Int] -> [[Char]]
    deal hand = 
        let p1 = snd $ evalHand $ fst $ shuf hand
            p2 = snd $ evalHand $ snd $ shuf hand
            p1Rank = fst $ evalHand $ fst $ shuf hand
            p2Rank = fst $ evalHand $ snd $ shuf hand
            tieBreaker (p1,p2) = 
                if (getRank $ head p1) == 1 && ((getRank $ head p2) /= 1) then True
                else if (getRank $ head p1) /= 1 && (getRank $ head p2) == 1 then False
                else if (nextHighest (map getRank $ p1) (map getRank $ p2)) then True else False
        in  if p1Rank /= p2Rank then if p1Rank < p2Rank then p1 else p2
            else if p1Rank == 2 || p1Rank == 6 || p1Rank == 5 then if tieBreaker (p1, p2) then p1 else p2
            else if tieBreaker2 (p1, p2) then p1 else p2
  
    tieBreaker2 :: ([[Char]], [[Char]]) -> Bool
    tieBreaker2 hands =
        let ace = (containsAce $ map getRank $ fst hands, containsAce $ map getRank $ snd hands)
            highestRank = (map getRank $ highestCard $ map getRank $ fst hands, map getRank $ highestCard $ map getRank $ snd hands)
            secondHighest = (map getRank $ highestCard $ filter (/=((fst highestRank)!!0)) $ map getRank $ fst hands, map getRank $ highestCard $ filter (/=((snd highestRank)!!0)) $ map getRank $ snd hands)
        in  if (fst ace && not (snd ace)) then True else if (not (fst ace) && snd ace) then False
            else if (fst highestRank) > (snd highestRank) then True else if (fst highestRank) < (snd highestRank) then False
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
        if (length $ sameSuit $ isStraight hand) == 5  && (getRank $ head $ isStraight hand) == 1 then (1, sameSuit $ isStraight hand)
        -- 2. straight flush
        else if (length $ sameSuit $ isStraight hand) == 5 then (2, sameSuit $ isStraight hand)
        -- 3. four of a kind
        else if ((length $ largestList $ sameRank hand) == 4) then (3, largestList $ sameRank hand) 
        -- 4. full house  
        else if ((length $ twoLargest $ sameRank hand) == 5) then (4, twoLargest $ sameRank hand)
        -- 5. flush 
        else if ((length $ sameSuit1 $ convertHand hand) == 5) then (5, sameSuit1 $ convertHand hand)
        -- 6. straight
        else if ((length $ isStraight hand) == 5) then (6, isStraight hand)
        -- 7. three of a kind
        else if ((length $ largestList $ sameRank hand) == 3) then (7, largestList $ sameRank hand) 
        -- 8. two pair
        else if ((length $ twoLargest $ sameRank hand) == 4) then (8, twoLargest $ sameRank hand)
         -- 9. pair
        else if ((length $ largestList $ sameRank hand) == 2) then (9, largestList $ sameRank hand)
        -- 10. high card
        else (10, highestCard hand) 
    
    -- helper functions ------------------------------------------------------
    isStraight :: [Int] -> [[Char]]
    isStraight hand =
        let remDuplicates hand = map head $ groupRank $ reverseRank $ convertHand hand
            straight = reverseRank $ largestList $ groupSeq $ remDuplicates hand
        in  if (getRank $ head $ straight) == 13 && containsAce hand 
                then highestCard hand ++ (take 4 straight) 
            else take 5 straight
            
    sameSuit :: [[Char]] -> [[Char]]
    sameSuit hand =
        let splitSuits hand = [filter isHeart hand, filter isDiamond hand, filter isClub hand, filter isSpade hand]
            largestSuit = reverseRank $ largestList $ splitSuits hand
        in take 5 largestSuit

    sameSuit1 :: [[Char]] -> [[Char]]
    sameSuit1 hand =
        let splitSuits hand = [filter isHeart hand, filter isDiamond hand, filter isClub hand, filter isSpade hand]
            largestSuit = largestList $ splitSuits hand
        in  if ((containsAce $ map getRank $ largestSuit) && (length largestSuit) >= 5) 
                then (take 1 $ sortRank $ largestSuit) ++ (take 4 $ reverseRank $ largestSuit)
            else take 5 $ reverseRank $ largestSuit

    sameRank :: [Int] -> [[[Char]]]
    sameRank hand = groupRank $ reverseRank $ convertHand hand

    containsAce :: [Int] -> Bool
    containsAce hand = 
        let find ace [] = False
            find ace (card:hand) = if card == ace then True else find ace hand
        in  if (find 1 hand) then True else if (find 14 hand) then True
            else if (find 27 hand) then True else if (find 40 hand) then True 
            else False

    highestCard :: [Int] -> [[Char]]
    highestCard hand = 
        if containsAce hand then take 1 (sortRank $ convertHand hand)
        else drop ((length hand)-1) (sortRank $ convertHand hand)

    nextHighest :: Ord a => [a] -> [a] -> Bool
    nextHighest [] [] = False
    nextHighest (x:xs) (y:ys) =
        if (x > y) then True
        else if (x < y) then False
        else nextHighest xs ys

    -- other functions ------------------------------------------------------
    getSuit card = card!!(length card - 1)
    getRank card = 
        let toInt tmp = read tmp::Int 
        in if length card == 3 then toInt $ take 2 card else toInt $ take 1 card
    isHeart card = getSuit card == 'H'
    isDiamond card = getSuit card == 'D'
    isClub card = getSuit card == 'C'
    isSpade card = getSuit card == 'S'

    groupRank :: [[Char]] -> [[[Char]]]
    groupRank [] = []
    groupRank (x:xs) = groupLoop [x] x xs
        where
        groupLoop acc c [] = [acc]
        groupLoop acc c (y:ys) 
         | getRank y == getRank c = groupLoop (acc ++ [y]) c ys
         | otherwise = acc : groupLoop [y] y ys

    groupSeq :: [[Char]] -> [[[Char]]]
    groupSeq = foldr group []
        where
        group x [] = [[x]]
        group x acc@((h:t):hand)
         | getRank x - getRank h == 1 = (x:h:t):hand
         | otherwise = [x]:acc

    largestList :: [[[Char]]] -> [[Char]]
    largestList [] = []
    largestList (x:xs) = let l = largestList xs in if length l > length x then l else x

    twoLargest :: [[[Char]]] -> [[Char]]
    twoLargest hand = 
        let s = filter (/= largestList hand) hand
            p = sortRank1 $ filter (/= largestList hand) hand 
            l = largestList hand
        in if containsAce $ map getRank $ largestList p then take 5 (largestList p ++ l)
           else take 5 (l ++ largestList s)
    
    sortRank :: [[Char]] -> [[Char]]
    sortRank [] = []
    sortRank (x:xs) = sortRank [y | y <- xs, getRank y <= getRank x] ++ [x] ++ sortRank [y | y <- xs, getRank y > getRank x]

    sortRank1 :: [[[Char]]] -> [[[Char]]]
    sortRank1 [] = []
    sortRank1 (x:xs) = sortRank1 [y | y <- xs, length y <= length x] ++ [x] ++ sortRank1 [y | y <- xs, length y > length x]

    reverseRank :: [[Char]] -> [[Char]]
    reverseRank [] = []
    reverseRank (x:xs) = reverseRank [y | y <- xs, getRank y > getRank x] ++ [x] ++ reverseRank [y | y <- xs, getRank y <= getRank x]
