fun is_older(date1:int*int*int, date2:int*int*int) = 
    if date1 = date2
        then false
    else if (#1 date1) < (#1 date2)
        then true
    else if (#1 date1) = (#1 date2) andalso (#2 date1) < (#2 date2)
        then true
    else if (#1 date1) = (#1 date2) andalso (#2 date1) = (#2 date2) andalso (#3 date1) < (#3 date2)
        then true
    else false;

is_older((2000,1,15),(2000,1,15)); (*false*)
is_older((1998,1,15),(1998,1,14)); (*false*)
is_older((1998,2,14),(1998,1,14)); (*false*)
is_older((1999,2,14),(1998,1,14)); (*false*)
is_older((1999,1,15),(1999,1,16)); (*true*)
is_older((1999,1,15),(1999,2,15)); (*true*)
is_older((1999,1,15),(2000,1,15)); (*true*)

fun number_in_month(dates : (int*int*int) list, month : int) =
    if null dates
        then 0
    else if ((#2 (hd dates)) = month)
        then number_in_month(tl dates,month) + 1
    else number_in_month(tl dates,month);

number_in_month([],2); (*0*)
number_in_month([(2000,1,1), (2000,1,2), (2000,1,3), (2000,2,1), (2000,2,2), (2000,3,1)],4); (*0*)
number_in_month([(2000,1,1), (2000,1,2), (2000,1,3), (2000,2,1), (2000,2,2), (2000,3,1)],1); (*3*)
number_in_month([(2000,1,1), (2000,1,2), (2000,1,3), (2000,2,1), (2000,2,2), (2000,3,1)],3); (*1*)
number_in_month([(2000,1,1), (2000,1,2), (2000,1,3), (2000,2,1), (2000,2,2), (2000,3,1)],2); (*2*)

fun number_in_months(dates : (int*int*int) list, monthes : int list) = 
    if null monthes
        then 0
    else number_in_month(dates, (hd monthes)) + number_in_months(dates, (tl monthes));

number_in_months([],[1,2]); (*0*)
number_in_months([(2000,1,1), (2000,1,2), (2000,1,3), (2000,2,1), (2000,2,2), (2000,3,1)],[]); (*0*)
number_in_months([],[]); (*0*)
number_in_months([(2000,1,1), (2000,1,2), (2000,1,3), (2000,2,1), (2000,2,2), (2000,3,1)],[1,2]); (*5*)

fun dates_in_month(dates : (int*int*int) list, month : int) = 
    if null dates
        then []
    else if ((#2 (hd dates)) = month)
        then (hd dates) :: dates_in_month(tl dates,month)
    else dates_in_month(tl dates,month);

dates_in_month([],1);
dates_in_month([(2000,1,1), (2000,1,2), (2000,1,3), (2000,2,1), (2000,2,2), (2000,3,1)],1);
dates_in_month([(2000,1,1), (2000,1,2), (2000,1,3), (2000,2,1), (2000,2,2), (2000,3,1)],3);
dates_in_month([(2000,1,1), (2000,1,2), (2000,1,3), (2000,2,1), (2000,2,2), (2000,3,1)],5);

fun dates_in_months (dates : (int*int*int) list, monthes : int list) = 
    if null monthes
        then []
    else dates_in_month(dates, (hd monthes)) @ dates_in_months(dates, (tl monthes));

dates_in_months([],[1,3]);
dates_in_months([(2000,1,1), (2000,1,2), (2000,1,3), (2000,2,1), (2000,2,2), (2000,3,1)],[]);
dates_in_months([(2000,1,1), (2000,1,2), (2000,1,3), (2000,2,1), (2000,2,2), (2000,3,1)],[1,3]);
dates_in_months([(2000,1,1), (2000,1,2), (2000,1,3), (2000,2,1), (2000,2,2), (2000,3,1)],[1,3,5]);

fun get_nth (text_lines : string list, n:int) = 
    if null text_lines
        then ""
    else if n = 1
        then (hd text_lines)
    else get_nth(tl text_lines, n-1);

get_nth([],2);
get_nth(["One","Two","Three","Four","Five"],3);

fun date_to_string(date : int*int*int) = 
    let 
        val monthes : string list = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    in
        get_nth(monthes,(#2 date)) ^ " " ^Int.toString(#3 date) ^ ", " ^ Int.toString(#1 date)
    end;

date_to_string((2000,1,1));

fun number_before_reaching_sum (sum : int, numbers : int list) = 
    if null numbers
        then 0
    else if (sum-(hd numbers)<=0)
        then 0
    else number_before_reaching_sum(sum - (hd numbers), (tl numbers))+1;

number_before_reaching_sum(10,[1,2,3,4,5,6]);
number_before_reaching_sum(10,[]);

fun what_month (day : int) = 
    let 
        val monthes_day = [31,28,31,30,31,30,31,31,30,31,30,31]
    in
        number_before_reaching_sum(day, monthes_day)+1
    end;

what_month(60);

fun month_range(day1 : int, day2 : int) =
    if (day1>day2) 
        then [] 
    else what_month(day1) :: month_range(day1+1, day2);

month_range(58,61);

fun oldest(dates : (int*int*int) list) = 
    if null dates
        then "NONE"
    else 
    let 
        fun greatest(dates : (int*int*int) list) = 
            if (null (tl dates))
                then (hd dates)
            else if (is_older((hd dates),greatest(tl dates)))
                then greatest(tl dates)
                else (hd dates)
    in
        "SOME " ^ date_to_string(greatest(dates))
    end;
    
oldest([]);
oldest([(2000,1,1), (2000,1,2), (2000,1,3), (2000,2,1), (2000,2,2), (2000,3,1)]);
oldest([(2000,1,1)]);
