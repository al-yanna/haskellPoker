defmodule Poker do
  # def deal(list) do shuffle(list, []) end #call shuffle
  # def deal([], res) do res end

  def deal(list) do
    pool = for hands <- list, do: shuffle(hands)
     # IO.inspect pool
    p1 = (pool -- [Enum.at(pool,1)]) -- [Enum.at(pool,3)]
    # IO.inspect p1
    p2 = (pool -- [Enum.at(pool,0)]) -- [Enum.at(pool,2)]
    winner = outcome(p1, p2)

  end

  def shuffle(card) do
    if (card <= 13) do
      cond do
        rem(card,13) == 0 -> Integer.to_string(13) <> "C"
        rem(card,13) != 0 -> Integer.to_string(rem(card,13)) <> "C"
      end

    else
      cond do
        #Diamonds
        (card <= 26 && rem(card,13) == 0) -> Integer.to_string(13) <> "D"
        (card <= 26 && rem(card,13) != 0) -> Integer.to_string(rem(card,13)) <> "D"

        #Hearts
        (card <= 39 && rem(card,13) == 0) -> Integer.to_string(13) <> "H"
        (card <= 39 && rem(card,13) != 0) -> Integer.to_string(rem(card,13)) <> "H"

        #Spades
        (card <= 52 && rem(card,13) == 0) -> Integer.to_string(13) <> "S"
        (card <= 52 && rem(card,13) != 0) -> Integer.to_string(rem(card,13)) <> "S"
      end
    end
  end

  def outcome(p1, p2) do
    #calls ranks
    map =
      %{"royalFlush" => 10,
      "straightFlush" => 9,
      "fourOfAKind" => 8,
      "fullHouse" => 7,
      "flush" => 6,
      "straight" => 5,
      "threeOfAKind" => 4,
      "twoPairs" => 3,
      "pair" => 2,
      "highCard" => 1
    }

    rankType = typeOfRank(p1)
    rankResult = result(rankType, p1)

  end
  #
  def typeOfRank(hand) do
    is_highCard(hand)
    # is_pair(hand)
    is_twoPairs(hand)
    # is_threeOfKind(hand)
    # is_straight(hand)
    # is_flush(hand)
    # is_fullHouse(hand)
    # is_fourOfAKind(hand)
    # is_straightFlush(hand)
    # is_royalFlush(hand)
  end
  #
  def is_highCard(hand) do "highCard" end

  # def is_pair(hand) do
  #   # IO.inspect(hand)
  #   card1 = elem Integer.parse(hd hand), 0
  #   card2 = elem Integer.parse(hd (tl hand)), 0
  #   sharedPool = tl (tl hand)
  #   convertedPool = for card <- sharedPool do elem Integer.parse(card), 0 end
  #   valid = Enum.any?(convertedPool, fn x -> (x == card1) || (x == card2) end)
  #   if valid == true do "pair" end
  #
  #  end

  def duplicates(list) do duplicates(list, [], []) end
  def duplicates([], res1, res2) do List.to_tuple(res2) end
  def duplicates([h|t], res1, res2) do
    if (Enum.member?(res1, (elem h, 0))) == false do
      duplicates(t, res1 ++ [(elem h, 0)], res2)
    else
      duplicates(t, res1, res2 ++ [(elem h, 0 )])
    end
  end

  def is_twoPairs(hand) do
      # IO.inspect(hand)
      card1 = elem Integer.parse(hd hand), 0
      card2 = elem Integer.parse(hd (tl hand)), 0
      sharedPool = tl (tl hand)
      convertedPool = for card <- sharedPool do Integer.parse(card) end

      cond do
        card1 != card2
        ->   if (Enum.any?(convertedPool, fn x -> (elem x, 0) == card1 end)) && (Enum.any?(convertedPool, fn x -> (elem x, 0) == card2 end))do
          "twoPairs"
        else
          cond do
            card1 != card2
            -> if (Enum.any?(convertedPool, fn x -> (elem x, 0) != card1 end)) && (Enum.any?(convertedPool, fn x -> (elem x, 0) == card2 end)) do
                if (tuple_size(duplicates(convertedPool))) != 0 do
                  "twoPairs"
                end
            else
              if (tuple_size(duplicates(convertedPool))) != 0 do
                "twoPairs"
              end
            end
        end
      end

      card1 == card2 -> if (tuple_size(duplicates(convertedPool))) != 0 do
        "twoPairs"
      end

    end

      # val = duplicates(convertedPool)

  end


  #
  # def is_threeOfKind(hand) do
  #
  # end
  #
  # def is_straight(hand) do
  #
  # end
  #
  # def is_flush(hand) do
  #
  # end
  #
  # def is_fullHouse(hand) do
  #
  # end
  #
  # def is_fourOfAKind(hand) do
  #
  # end
  #
  # def is_straightFlush(hand) do
  #
  # end
  #
  # def is_royalFlush(hand) do
  #
  # end

  #
  def result(rankType, hand) do
    case rankType do
       "highCard" -> highCard(hand)
       # "pair" -> pair(hand)
      "twoPairs" -> twoPairs(hand)
      # # "threeOfAKind" -> threeOfAKind(hand)
      # # "straight" -> straight(hand)
      # # "flush" -> flush(hand)
      # # "fullHouse" -> fullHouse(hand)
      # # "fourOfAKind" -> fourOfAKind(hand)
      # # "straightFlush" -> straightFlush(hand)
      # # "royalFlush" -> royalFlush(hand)
      # _ -> "Error"
    end
  end

 def highCard(hand) do "ur in highCard method" end

 # def pair(hand) do
 #   IO.inspect(hand)
 #   card1 = Integer.parse(hd hand)
 #   card2 = Integer.parse(hd (tl hand))
 #   sharedPool = tl (tl hand)
 #   convertedListPool = for card <- sharedPool do Integer.parse(card) end
 #   valid1 = Enum.any?(convertedListPool, fn x -> (elem x, 0) == (elem card1, 0) end)
 #   valid2 = Enum.any?(convertedListPool, fn x -> (elem x, 0) == (elem card2, 0) end)
 #   result = List.to_tuple(Enum.reject(convertedListPool, fn x -> (elem x, 0) != (elem card1, 0) end))
 #   result2 = List.to_tuple(Enum.reject(convertedListPool, fn x -> (elem x, 0) != (elem card2, 0) end))
 #
 #   cond do
 #     valid1 == true && valid2 == false ->  [hd hand] ++ [to_string(elem (elem result, 0), 0) <> (elem (elem result, 0), 1)]
 #     valid1 == false && valid2 == true -> [hd (tl hand)] ++ [to_string(elem (elem result2, 0), 0) <> (elem (elem result2, 0), 1)]
 #     (elem card1, 0) > (elem card2, 0) -> [hd hand] ++ [to_string(elem (elem result, 0), 0) <> (elem (elem result, 0), 1)]
 #     (elem card2, 0) > (elem card1, 0) -> [hd (tl hand)] ++ [to_string(elem (elem result2, 0), 0) <> (elem (elem result2, 0), 1)]
 #                                                                      #value                                   #suit
 #   end
 #
 # end


 def twoPairs(hand) do
   card1 = Integer.parse(hd hand)
   card2 = Integer.parse(hd (tl hand))
   sharedPool = tl (tl hand)
   convertedPool = for card <- sharedPool do Integer.parse(card) end
   val = duplicates(convertedPool)
   check = tuple_size(val) != 0

   cond do
     (elem card1, 0) == (elem card2, 0) && check == true ->
       result = List.to_tuple(Enum.reject(convertedPool, fn x -> (elem x, 0) != (elem val, 0) end))
       [(hd hand), (hd (tl hand))] ++ [to_string(elem (elem result, 0), 0) <> (elem (elem result, 0), 1)] ++ [to_string(elem (elem result, 1), 0) <> (elem (elem result, 1), 1)]

     (elem card1, 0) != (elem card2, 0) && check == true ->
      valid1 = Enum.any?(convertedPool, fn x -> (elem x, 0) == (elem card1, 0) end)
      valid2 = Enum.any?(convertedPool, fn x -> (elem x, 0) == (elem card2, 0) end)

      if valid1 && valid2 do
        result = List.to_tuple(Enum.reject(convertedPool, fn x -> (elem x, 0) != (elem card1, 0) end))
        result2 = List.to_tuple(Enum.reject(convertedPool, fn x -> (elem x, 0) != (elem card2, 0) end))
        cond do
          (elem card1, 0) > (elem card2, 0) -> [(hd (t1 hand))] ++ [to_string(elem (elem result2, 0), 0) <> (elem (elem result2, 0), 1)]
          (elem card2, 0) > (elem card1, 0) -> [hd hand] ++ [to_string(elem (elem result, 0), 0) <> (elem (elem result, 0), 1)]
      end
    end

   end



 end


end
