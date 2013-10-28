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
