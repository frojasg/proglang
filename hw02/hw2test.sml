
val test1_1 = all_except_option("a", ["a", "b"]) = SOME ["b"]

val test1_2 = all_except_option("a", ["a"]) = NONE

val test2_1 = get_substitutions1([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], "Fred") =  ["Fredrick","Freddie","F"]

val test2_2 = get_substitutions1([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]], "Jeff") =  ["Jeffrey","Geoff","Jeffrey"]

val test3_1 = get_substitutions2([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], "Fred") =  ["Fredrick","Freddie","F"]

val test3_2 = get_substitutions2([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]], "Jeff") =  ["Jeffrey","Geoff","Jeffrey"]

val test4_1 = similar_names([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], {first="Fred", middle="W", last="Smith"}) =  [{first="Fred", last="Smith", middle="W"}, {first="Fredrick", last="Smith", middle="W"}, {first="Freddie", last="Smith", middle="W"}, {first="F", last="Smith", middle="W"}]

val test5_1 = card_color(Hearts, Num(2)) = Red
val test5_2 = card_color(Spades, Num(2)) = Black

val test6_1 = card_value(Spades, Num(5)) = 5
val test6_2 = card_value(Spades, King) = 10
val test6_3 = card_value(Spades, Ace) = 11

val test7_1 = remove_card([(Hearts, Num 5), (Spades, Ace)], (Spades, Ace), IllegalMove) = [(Hearts, Num 5)]
(*val test7_2 = remove_card([(Hearts, Num 5), (Spades, Ace)], (Spades, King), IllegalMove) = IllegalMove*)
val test7_1 = remove_card([(Hearts, Num 5), (Spades, Ace), (Hearts, Num 5)], (Hearts, Num 5), IllegalMove) = [(Spades, Ace), (Hearts, Num 5)]
