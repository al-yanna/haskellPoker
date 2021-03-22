module Poker where
    hand = [1,2,3,4,5,6,7,8,9]  
    winner = []

    -- main deal function (WIP)
    deal hand = 
        let p1 = fst (shuf hand)
            p2 = snd (shuf hand)
        in winner

    -- 1. shuffle hand
    shuf hand = 
        let sharePool = drop (length hand - 5) hand
            p1 = hand!!0:[] ++ hand!!2:[] ++ sharePool
            p2 = hand!!1:[] ++ hand!!3:[] ++ sharePool
        in (p1, p2)

    -- 2. convert hand (int -> cards)
    convertHand hand = 
        let cards = ["", "1C", "2C", "3C", "4C", "5C", "6C", "7C", "8C", "9C", "10C", "11C", "12C", "13C", "1D", "2D", "3D", "4D", "5D", "6D", "7D", "8D","9D", "10D", "11D", "12D", "13D", "1H", "2H", "3H", "4H", "5H", "6H", "7H", "8H","9H", "10H", "11H", "12H", "13H", "1S", "2S", "3S", "4S", "5S", "6S", "7S", "8S","9S", "10S", "11S", "12S", "13S"]
            int2Card num = cards!!num 
        in (map int2Card hand)

    -- 3. evaluate hand
    -- evalHand hand =


    -- ! EVALHAND HELPERS ! ------------

    -- sameSuit

    -- sameRank

    -- isStraight

    -- highestCard

    -- ! TIE BREAKER HELPERS !----------
        