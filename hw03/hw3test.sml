
val test1 = only_capitals(["Ola", "q", "ase"]) = ["Ola"]

val test2 = longest_string1(["ola", "q", "ase"]) = "ola"

val test3 = longest_string2(["ola", "q", "ase"]) = "ase"

val test4_1 = longest_string3(["ola", "q", "ase"]) = "ola"

val test4_2 = longest_string4(["ola", "q", "ase"]) = "ase"

val test5 = longest_capitalized(["Ola", "Q", "ase"]) = "Ola"

val test6 = rev_string("xita miller") = "rellim atix"

val test9a_1 = count_wildcards Wildcard = 1
val test9a_2 = count_wildcards (TupleP [Wildcard, Wildcard, ConstP(5)]) = 2
val test9a_3 = count_wildcards (ConstructorP ("dt", TupleP [Wildcard, Wildcard, Wildcard])) = 3
val test9a_4 = count_wildcards (TupleP [Wildcard, TupleP [Wildcard, Wildcard], ConstP 5]) = 3
val test9a_5 = count_wildcards (TupleP [ConstP 10, TupleP [Variable "str"], ConstP 5]) = 0

val test9b_1 = count_wild_and_variable_lengths Wildcard = 1
val test9b_2 = count_wild_and_variable_lengths (TupleP [Wildcard, Wildcard, ConstP(5)]) = 2
val test9b_3 = count_wild_and_variable_lengths (ConstructorP ("dt", TupleP [Wildcard, Wildcard, Wildcard])) = 3
val test9b_4 = count_wild_and_variable_lengths (TupleP [Wildcard, TupleP [Wildcard, Wildcard], ConstP 5]) = 3
val test9b_5 = count_wild_and_variable_lengths(TupleP [ConstP 10, TupleP [Variable "str"], ConstP 5]) = 3

val test9c_5 = count_some_var("str", TupleP [ConstP 10, TupleP [Variable "str"], ConstP 5]) = 1;

val test10_1 = check_pat (TupleP [ConstP 10, TupleP [Variable "str"], ConstP 5])

val test10_2 = check_pat (TupleP [ConstP 10, TupleP [Variable "str"], Variable "str"]) = false

val test11 = match (Const(1), UnitP) = NONEx
val test11_1 = match(Const 1, ConstP 1) = SOME[]
val test11_2 = match(Unit, Variable "test") = SOME[("test", Unit)]
