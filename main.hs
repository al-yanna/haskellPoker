module Poker where
    hand = [1,2,3,4,5,6,7,8,9]  

    sharePool = drop (length hand - 5) hand
    p1 = (take 4 hand) even ) ++ (sharePool)
    p2 = take 4 hand ++ (sharePool)
