
val test1_1 = all_except_option("a", ["a", "b"]) = SOME ["b"]

val test1_2 = all_except_option("a", ["a"]) = NONE
