main :: IO ()
main = interact $ show . longTable . map (map read . words) . lines
 
longTable :: [[Int]] -> Int
longTable ([n, _] : xs) = sum $ foldl update (replicate n 0) xs
    where
    update xs [a, b]
        | sum ys > 0 = xs
        | otherwise = take n $ drop (n-b+1) $ xs' ++ xs'
        where
        (ys, zs) = splitAt a $ take n $ drop (b-1) $ xs ++ xs
        xs' = replicate a 1 ++ zs
