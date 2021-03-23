module Poker where
    winner = []
    aces = [1, 14, 27, 40]

    -- tester hands
    hand = [1, 2, 3, 4, 5, 6, 7, 8, 9]  
    royalFlush = [1, 10, 11, 12, 13] 

    deal hand = 
        let p1 = evalHand (fst (shuf hand))
            p2 = evalHand (snd (shuf hand))
            -- pseudo
            -- if p1Rank /= fst p2Rank
            --     if p1Rank > p2Rank
            --         winner = p1
            --     else winner = p2
            -- else winner = (tiebreaker p1 p2)
        in winner

    shuf hand = 
        let sharePool = drop (length hand - 5) hand
            p1 = hand!!0:[] ++ hand!!2:[] ++ sharePool
            p2 = hand!!1:[] ++ hand!!3:[] ++ sharePool
        in (p1, p2)
        
    convertHand hand = 
        let cards = ["", "1C", "2C", "3C", "4C", "5C", "6C", "7C", "8C", "9C", "10C", "11C", "12C", "13C", "1D", "2D", "3D", "4D", "5D", "6D", "7D", "8D","9D", "10D", "11D", "12D", "13D", "1H", "2H", "3H", "4H", "5H", "6H", "7H", "8H","9H", "10H", "11H", "12H", "13H", "1S", "2S", "3S", "4S", "5S", "6S", "7S", "8S","9S", "10S", "11S", "12S", "13S"]
            int2Card num = cards!!num 
        in (map int2Card hand)

    -- in: [hand]
    -- out: (rank, [playingHand])
    evalHand hand = (1, convertHand hand)
        -- 1. royal flush
        if hand contains ace
            playingHand = highest 4
            if playingHand isStraight 
            playingHand = ace + playing Hand
            (royal flush, playingHand)
        -- 2. straight flush

        -- 5. flush
        
        if (length sameSuit) == 5: flush
        if (length sameRank) == 4: 4 of a kind
        if (length sameRank) == 3: 3 of a kind




    -- helper functions ------------

    -- sameSuit
    sameSuit hand = map getSuit hand
    [h], [d], [s], [c] max
    [h]
    [4H, 3H, 1H, 2H]



    -- sameRank

    -- isStraight

    -- highestCard

    -- tiebreaker

    -- getter functions ------------
    getSuit card = card!!(length card - 1)
    getRank card = 
        if length card == 3 then take 2 card
        else take 1 card
    