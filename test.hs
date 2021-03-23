largest [] = []
largest (x:xs) = 
    let s = largest xs
    in if largest s > largest x then s else x