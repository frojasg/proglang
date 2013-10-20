
val test1_1 = all_except_option("a", ["a", "b"]) = SOME ["b"]

val test1_2 = all_except_option("a", ["a"]) = NONE

val test2_1 = get_substitutions1([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], "Fred") =  ["Fredrick","Freddie","F"]

val test2_2 = get_substitutions1([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]], "Jeff") =  ["Jeffrey","Geoff","Jeffrey"]

val test3_1 = get_substitutions2([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], "Fred") =  ["Fredrick","Freddie","F"]

val test3_2 = get_substitutions2([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]], "Jeff") =  ["Jeffrey","Geoff","Jeffrey"]

val test4_1 = similar_names([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], {first="Fred", middle="W", last="Smith"}) =  [{first="Fred", last="Smith", middle="W"}, {first="Fredrick", last="Smith", middle="W"}, {first="Freddie", last="Smith", middle="W"}, {first="F", last="Smith", middle="W"}]
