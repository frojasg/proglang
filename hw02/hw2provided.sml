(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)
fun all_except_option(s: string, words: string list) =
  let fun all_except(words: string list) =
     case words of
         [] => []
       | x :: xs' => if same_string(s, x)
       then all_except(xs')
       else x :: all_except(xs')
  in
    case all_except(words) of
        [] => NONE
      | x => SOME x
   end

fun get_substitutions1(subs: string list list, s: string) =
  case subs of
      [] => []
    | x :: xs' => case all_except_option(s, x) of
        NONE => get_substitutions1(xs', s)
      | SOME y => if x = y then get_substitutions1(xs', s)
        else y @ get_substitutions1(xs', s)

fun get_substitutions2(subss: string list list, s: string) =
  let fun substitution_inc(subs: string list list, inc: string list) =
    case subs of
        [] => inc
      | x :: xs' => case all_except_option(s, x) of
          NONE => substitution_inc(xs', inc)
        | SOME y => if x = y then substitution_inc(xs', inc)
          else substitution_inc(xs', ( inc @ y) )
  in
    substitution_inc(subss, [])
  end


fun similar_names(subs: string list list, {first=f,middle=m,last=l}) =
  let fun convert(names: string list) = case names of
      [] => []
    | x :: xs' => {first=x, middle=m, last=l} :: convert(xs')
  in
    convert(f :: get_substitutions2(subs, f))
end

(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)

fun card_color(s: suit, r: rank) =
   case s of
     Spades => Black
    | Clubs => Black
    | Diamonds => Red
    | Hearts => Red

fun card_value(s: suit, r: rank) =
  case r of
    Num i => i
   | Ace => 11
   |  _ => 10

fun remove_card(cards: card list, c: card, ex) =
  let fun remove(cards: card list, count: int) =
    case (count, cards) of
       (0, []) => raise ex
     | (1, []) => []
     | (_, x :: xs') => if x = c andalso count < 1 then remove(xs', count + 1)
                   else x :: remove(xs', count)
     | (_,_) => []
  in
   remove(cards, 0)
  end

fun all_same_color(cards: card list) =
  case cards of
      [] => true
   | _::[] => true
   | head::(neck::rest) => card_color(head) = card_color(neck) andalso all_same_color(rest)

fun sum_cards(cards: card list) =
  let fun sum_cards_aux(cards: card list, acc: int) =
    case cards of
        [] => acc
     | x::xs' => sum_cards_aux(xs', acc + card_value(x))
  in
    sum_cards_aux(cards, 0)
  end

fun score(cards: card list, goal: int) =
  let val score = sum_cards(cards)
      val all_cards_same_color = all_same_color(cards)
      val preliminar = if score > goal then (score - goal) * 3 else goal - score
  in
    if all_cards_same_color then preliminar div 2 else preliminar
  end

fun officiate(cards: card list, moves: move list, goal) =
  let val ex = IllegalMove
    fun officiate_aux(cards: card list, moves: move list, held: card list) =
    case (cards, moves, held) of
        (_, [], _) => score(held, goal)
     | ([], _, _) => score(held, goal)
     | (cs, Discard(c)::mvs, h) => officiate_aux(cs, mvs, remove_card(h, c, ex))
     | (c:: cs, Draw::mvs, h) => let val h2 = c::h
                                    val sum = sum_cards(h2)
        in
            if sum > goal then score(h2, goal) else officiate_aux(cs, mvs, h2)
        end
  in
     officiate_aux(cards, moves, [])
  end
