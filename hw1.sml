
fun is_older(newest: (int * int * int), older: (int * int * int)) = 
   (#1 older) > (#1 newest) andalso (#2 older) > (#2 newest) andalso (#3 older) > (#3 newest);

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
  else (if #2 (hd(dates)) = month then hd(dates):: dates_in_month(tl(dates), month) else dates_in_month(tl(dates), month));

fun dates_in_months(dates: (int * int * int) list, months: int list) = 
  if null months
  then []
  else dates_in_month(dates, hd(months)) @ dates_in_months(dates, tl(months));


