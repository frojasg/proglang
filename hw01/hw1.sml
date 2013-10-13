
fun is_older(newest: (int * int * int), older: (int * int * int)) = 
  (#1 older) > (#1 newest) orelse ((#1 older) >= (#1 newest) andalso (#2 older) > (#2 newest)) orelse
  ((#1 older) >= (#1 newest) andalso (#2 older) >= (#2 newest) andalso (#3 older) > (#3 newest));

fun number_in_month(dates: (int * int * int) list, month: int) = 
  if null dates
  then 0
  else (if #2 (hd(dates)) = month then 1 else 0) + number_in_month(tl(dates), month);

fun number_in_months(dates: (int * int * int) list, months: int list) = 
  if null months
  then 0
  else number_in_month(dates, hd(months)) + number_in_months(dates, tl(months));

fun dates_in_month(dates: (int * int * int) list, month: int) = 
  if null dates
  then []
  else if #2 (hd(dates)) = month
    then hd(dates):: dates_in_month(tl(dates), month)
    else dates_in_month(tl(dates), month);

fun dates_in_months(dates: (int * int * int) list, months: int list) = 
  if null months
  then []
  else dates_in_month(dates, hd(months)) @ dates_in_months(dates, tl(months));

fun get_nth(words:string list, n:int) =
  let fun aux_get_nth(words: string list, accu:int) =
    if n = accu
    then hd(words)
    else aux_get_nth(tl(words), accu + 1)
  in
    aux_get_nth(words, 1)
  end

fun date_to_string(date: (int * int * int)) =
  let val months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    val day = Int.toString(#3 date)
    val month = get_nth(months, #2 date)
    val year = Int.toString(#1 date)
  in
    month ^ " " ^ day ^ ", " ^ year
  end

fun number_before_reaching_sum(sum: int, numbers: int list) =
  let fun sum_list(accu: int, index: int, numbers: int list) =
    if accu + hd(numbers) < sum
    then sum_list(accu + hd(numbers), index + 1, tl(numbers))
    else index
  in
      sum_list(0, 0, numbers)
  end

fun what_month(day: int) =
  let val months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  in
    number_before_reaching_sum(day, months) + 1
  end

fun month_range(day1: int, day2: int) =
  if day1 > day2
  then []
  else what_month(day1) :: month_range(day1 + 1, day2)

fun oldest(dates: (int * int * int) list) =
  if null dates
  then NONE
  else
    let fun min_date(dates: (int * int * int) list) =
      if null (tl dates)
      then hd(dates)
      else
        let val tl_ans = min_date(tl(dates))
        in
          if is_older(hd(dates),  tl_ans)
          then hd(dates)
          else tl_ans
        end
    in
      SOME (min_date dates)
    end

fun number_in_months_challenge(dates: (int * int * int) list, months: int list) =
  let fun delete(numbers: int list, n: int) =
    if null numbers
    then []
    else if hd(numbers) = n then delete(tl(numbers), n) else hd(numbers) :: delete(tl(numbers), n)
  fun remove_duplicate(numbers: int list) =
    if null numbers
    then []
    else hd(numbers) :: remove_duplicate(delete(tl(numbers), hd(numbers)))
  in
   number_in_months(dates, remove_duplicate(months))
  end
