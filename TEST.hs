module TEST where
    -- tester hands
    hand::[Int]
    hand = [27, 45, 3,  48, 44, 43, 41, 33, 12] -- flush wins
    royal::[Int]
    royal = [1, 10, 11, 12, 13] 
    flush::[Int]
    flush = [41, 44, 47, 48, 50, 10, 9]
    fourkind::[Int]
    fourkind = [40, 41, 27, 28, 1,  14, 15, 42, 29] -- 4 aces wins

    deal :: [Int] -> [[Char]]
    deal hand = 
        let p1 = snd $ evalHand $ fst $ shuf hand
            p2 = snd $ evalHand $ snd $ shuf hand
            p1Rank = fst $ evalHand $ fst $ shuf hand
            p2Rank = fst $ evalHand $ snd $ shuf hand
        in  if p1Rank /= p2Rank then
                if p1Rank < p2Rank then p1 else p2
            else
                p1 -- change to tiebreaker winner when implemented
        
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
        -- if ((length $ sameSuit $ isStraight hand) == 5 then (2, sameSuit hand) 
        -- 3. four of a kind
        -- if ((length $ fst sameRank hand) == 4) then (3, sameRank hand)
        -- 4. full house
        -- if ((length $ fst sameRank hand) + (length $ snd sameRank hand) == 5) then (4, sameRank      hand)
        -- 5. flush 
        if ((length $ sameSuit hand) == 5) then (5, sameSuit hand)
        -- 6. straight
        -- 7. 3 of a kind
        -- if ((length $ fst sameRank hand) == 3) then (7, sameRank hand)
        -- 8. two pair
        -- if ((length $ fst sameRank hand) + (length $ snd sameRank hand) == 4) then (8, sameRank      hand)
        -- 9. pair
        -- if ((length $ fst sameRank hand) == 2) then (9, sameRank hand)
        -- 10. high card
        -- else (10, (highestCard hand:[])) 
        else (10, highestCard hand)
 
    -- helper functions ------------
    sameSuit :: [Int] -> [[Char]]
    sameSuit hand =
        let splitSuits hand = [filter isHeart hand, filter isDiamond hand, filter isClub hand, filter isSpade hand]
            largestSuit = largestList $ splitSuits $ convertHand hand
        in dropTo5 largestSuit

    -- sameRank :: [Int] -> ([[Char]], [[Char]])
    -- ^ ([largest of ranks], [second largest ranks])
    -- ^ need largest and second "largest" for full house and two pair
    -- result is a tuple, so we can use fst and snd


    sortRank :: [[Char]] -> [[Char]]
    sortRank [] = []
    sortRank (x:xs) = sortRank [y | y <- xs, getRank y <= getRank x] ++ [x] ++ sortRank [y | y <- xs, getRank y > getRank x]

    ----------------------------------

    -- splitByRank :: [[Char]] -> [[[Char]]]

    -- isStraight :: [Int] -> [[Char]]
    
    containsAce :: [Int] -> Bool
    containsAce hand = 
        let find ace [] = False
            find ace (card:hand) = if card == ace then True else find ace hand
        in  if (find 1 hand) then True
            else if (find 14 hand) then True
            else if (find 27 hand) then True
            else if (find 40 hand) then True
            else False

    highestCard :: [Int] -> [[Char]]
    highestCard hand = 
        if containsAce hand then take 1 (sortRank $ convertHand hand)
        else drop ((length hand)-1) (sortRank $ convertHand hand)

    -- helpers for the helper functions lol ------------
    getSuit card = card!!(length card - 1)
    getRank card = 
        let toInt tmp = read tmp::Int
        in  if length card == 3 then toInt $ take 2 card
            else toInt $ take 1 card

    isHeart card = getSuit card == 'H'
    isDiamond card = getSuit card == 'D'
    isClub card = getSuit card == 'C'
    isSpade card = getSuit card == 'S'

    dropTo5 :: [[Char]] -> [[Char]]
    dropTo5 list =
        if length list == 7 then drop 2 list
        else if length list == 6 then drop 1 list
        else list

    largestList :: [[[Char]]] -> [[Char]]
    largestList [] = []
    largestList (x:xs) = 
        let l = largestList xs
        in if length l > length x then l else x
    

  

    




   -- sort1 list = [fst x | x <- (zip [0..] list), fst(snd x)] 

    -- sort1 $ sortRank ["1H","6S","3C","9S","14S","13S","2S","7H","12C"]

-- ur super nice w haskell i rate it
-- ay thanks