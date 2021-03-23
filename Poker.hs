module Poker where
    winner = []
    playingHand = []
    aces = [1, 14, 27, 40]

    -- tester hands
    hand::[Int]
    hand = [1, 2, 3, 4, 5, 6, 7, 8, 9]  
    royalFlush::[Int]
    royalFlush = [1, 10, 11, 12, 13] 
    flush::[Int]
    flush = [41, 44, 47, 48, 50, 10, 9]

    deal :: [Int] -> [[Char]]
    deal hand = 
        let p1 = evalHand (fst (shuf hand))
            p2 = evalHand (snd (shuf hand))
            -- pseudo
            -- if p1Rank /= p2Rank
            --     if p1Rank > p2Rank
            --         winner = p1
            --     else winner = p2
            -- else winner = (highestCard p1 p2)
        in winner

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
        -- 3. four of a kind
        -- 4. full house
        -- 5. flush
        if ((length $ sameSuit hand) == 5) then (5, sameSuit hand)
        -- 6. straight
        -- 7. 3 of a kind
        -- 8. two pair
        -- 9. pair
        -- 10. high card
        else (0, ["", ""])
 
    -- helper functions ------------

    sameSuit :: [Int] -> [[Char]]
    sameSuit hand =
        let splitSuits hand = [(filter isHeart hand),(filter isDiamond hand), filter isClub hand, filter isSpade hand]
        in largestList $ splitSuits $ convertHand hand

    -- sameRank :: [Int] -> ([[Char]], [[Char]])

    -- isStraight :: [Int] -> [[Char]]

    -- helpers for the helper functions lol ------------
    getSuit card = card!!(length card - 1)
    getRank card = if length card == 3 then take 2 card else take 1 card
    
    isHeart card = getSuit card == 'H'
    isDiamond card = getSuit card == 'D'
    isClub card = getSuit card == 'C'
    isSpade card = getSuit card == 'S'

    largestList :: [[[Char]]] -> [[Char]]
    largestList [] = []
    largestList (x:xs) = 
        let l = largestList xs
        in if length l > length x then l else x