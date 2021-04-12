module PokerTester where

    import Poker (deal)
    import Data.Foldable (forM_)
    import Data.Text (pack, splitOn)
    import Data.List (sort, intersect)
    import System.IO (openFile, hGetContents, IOMode(ReadMode))

    -- https://ghostbin.com/paste/I6mSW (10000 testcases)
    testcases = []

    strToInt str =
        read (take ((length str) - 1) str) :: Int

    testPerm input ranking x = do
        let youSaidOrig = sort (deal input)
        let shouldBeOrig = sort x
        let commonOrig = intersect youSaidOrig shouldBeOrig
        let check = not (elem ranking ["royal_flush", "straight_flush", "flush"])
        let youSaid = if check then map strToInt youSaidOrig else []
        let shouldBe = if check then map strToInt shouldBeOrig else []
        let common = if check then intersect youSaid shouldBe else []
        let score =
                if check then (fromIntegral $ length common) / (fromIntegral $ length shouldBe)
                else (fromIntegral $ length commonOrig) / (fromIntegral $ length shouldBeOrig)
        let correct =
                if check then length common else length commonOrig
        (if (length youSaidOrig) > 5 then 0 else score, input, youSaidOrig, shouldBeOrig, correct)

    runTests = do
        x <- openFile "testcases.txt" ReadMode
        cont <- hGetContents x
        let fLines = lines cont
        let results = map (\line -> do
                let testcase = splitOn (pack " ") (pack line)
                let f = (\x -> do
                    let y = show x
                    take (length y - 2) (drop 1 y))
                let input = map (\x -> read x :: Int) (map f (splitOn (pack ",") (head testcase)))
                let ranking = f (testcase !! 1)
                let shouldBe = map f (splitOn (pack ",") (testcase !! 2))
                testPerm input ranking shouldBe
                ) fLines
        let scores = map (\(x, _, _, _, _) -> x) results
        let pct = 100*(sum scores) / (fromIntegral $ length scores)
        let pct2 = (fromIntegral $ round (pct*10)) / 10.0
        let nPts = (fromIntegral $ round ((sum scores)*10.0)) / 10.0
        let incorrect = filter (\(_, (x, _, _, _, _)) -> x /= 1.0) (zip [1..length scores] results)
        forM_ incorrect (\(test, (score, input, youSaid, shouldBe, correct)) -> do
                putStrLn $ "Test #" ++ show test ++ " DISCREPANCY: " ++ show input
                putStrLn $ "  You returned:   " ++ show youSaid
                putStrLn $ "  Should contain: " ++ show shouldBe
                putStrLn $ "  " ++
                        if length youSaid > 5 then "Returned more than five cards! Test FAILED!"
                        else show correct ++ " of " ++ show (length shouldBe) ++ " cards correct"
            )
        putStrLn $ show nPts ++ "/" ++ show (fromIntegral $ length scores) ++ " | " ++ show pct2 ++ "%"