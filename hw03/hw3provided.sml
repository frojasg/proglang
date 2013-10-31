(* Coursera Programming Languages, Homework 3, Provided Code *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let
	val r = g f1 f2
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)

fun only_capitals(words: string list) =
  List.filter (fn x => Char.isUpper(String.sub(x, 0))) words

fun longest_string1(words: string list) =
  List.foldl (fn (biggest: string, word:string) => if(String.size biggest <= String.size word) then word else biggest) "" words

fun longest_string2(words: string list) =
  List.foldl (fn (biggest: string, word:string) => if(String.size biggest < String.size word) then word else biggest) "" words

fun longest_string_helper f words =
  List.foldl (fn (biggest: string, word:string) => if(f(String.size biggest, String.size word)) then word else biggest) "" words

fun longest_string3(words: string list) =
  longest_string_helper (fn (x, y) => x <= y) words

fun longest_string4(words: string list) =
  longest_string_helper (fn (x, y) => x < y) words

fun longest_capitalized(words: string list) =
  (longest_string2 o only_capitals) words

fun rev_string(word: string) =
  (String.implode o List.rev o String.explode) word

exception NoAnswer

fun first_answer f q = case q of
                 [] => raise NoAnswer
              |  x::xs => case f(x) of
                       NONE => first_answer f xs
                     | SOME v => v

fun all_answers f q =
    let fun helper q1 acc = case q1 of
            [] => SOME acc
         | x :: xs => case f(x) of
                        NONE => NONE
                     | SOME v => helper xs  (v @ acc)
    in
      helper q []
end


fun count_wildcards(p: pattern) = g (fn x => 1) (fn x => 0) p

fun count_wild_and_variable_lengths(p: pattern) = g (fn x => 1) (fn x => String.size x) p

fun count_some_var(s:string, p: pattern) = g (fn x => 0) (fn x => if x=s then 1 else 0) p


fun get_vars(p:pattern) =
  case p of
      Wildcard		=> []
    | Variable x 	=> [x]
    | TupleP ps		=> List.foldl (fn (r, i) => (get_vars(r)) @ i ) [] ps
    | ConstructorP(_, p) => get_vars p
    | _		      	=> []


fun check_pat(p:pattern) =
  let fun dup(v: string list) =
    List.exists (fn x => List.length(List.filter (fn y => y = x) v) > 1) v
  in
     not ((dup o get_vars) p)
  end

fun match (_, Wildcard) = SOME []
  | match (v, Variable s) = SOME [(s, v)]
  | match (Unit, UnitP) = SOME []
  | match (Const a, ConstP b) = if a = b then SOME [] else NONE
  | match (Tuple vs, TupleP ps) = if List.length vs = List.length ps
                                then all_answers match (ListPair.zip(vs, ps))
                                else NONE
  | match (Constructor (s2, v), ConstructorP (s1, p)) = if s1 = s2 then match (v, p) else NONE
  | match _ = NONE

fun first_match v p =
  SOME (first_answer( fn x => match (v, x)) p)
  handle NoAnswer => NONE
