-module(tut).
-export([list_length/1, in_order/1, convert_temp/1, format_temps/1, list_max/1, reverse_list/1, smaller_value/2, 
    smaller_value_if/2, list_evens/1, square_list/1]).

% Get the length of the list
list_length([]) ->
  0;
list_length([_ | Rest]) ->
  1 + list_length(Rest).

% Determine if the list is in ascending order
in_order([]) ->
  true;
in_order([_]) ->
  true;
in_order([X, Y]) ->
  X =< Y;
in_order([X, Y | Rest]) ->
  X =< Y andalso in_order(lists:append([Y],Rest)).

% Convert between c and f
convert_temp({f, F}) ->
  {c, (F - 32) * (5/9)};
convert_temp({c, C}) ->
  {f, (C * (9/5))+ 32}.

% Print out a list of formated temps, provided in the format {CITY_NAME {[c/f], TEMP}}
format_temps([]) ->
  ok;
format_temps([{City, {Scale, Temp}} | Rest]) ->
  print_temp({City, temp_to_c({Scale, Temp})}),
  format_temps(Rest).

% Ensure the temp is in c
temp_to_c({c, C}) ->
  {c, C};
temp_to_c({f, F}) ->
  convert_temp({f, F}).

% Print the temp
print_temp({City, {_, Temp}}) ->
  io:format("~-15w ~w c~n", [City, Temp]).

% Get the max value of a list
list_max([Head | Rest]) ->
  list_max(Rest, Head).

list_max([], Res) ->
  Res;
list_max([Head | Rest], Res) when Head > Res ->
  list_max(Rest, Head);
list_max([_ | Rest], Res) ->
  list_max(Rest, Res).

% Reverse the order of a list_max
reverse_list(List) ->
  reverse_list(List, []).

reverse_list([Head | Rest], Reversed) ->
  reverse_list(Rest, [Head | Reversed]);
reverse_list([], Reversed) ->
  Reversed.

smaller_value(X, Y) when X =< Y ->
  X;
smaller_value(_, Y) ->
  Y. 

smaller_value_if(X, Y) ->
  if
    X =< Y ->
      X;
    X > Y ->
      Y 
  end.

list_evens([]) ->
  [];
list_evens(List) ->
  list_evens(List, []).

list_evens([], Results) ->
  Results;
list_evens([Head | Rest], Results) ->
  if
    Head rem 2 == 0 ->
      list_evens(Rest, lists:append(Results, [Head]));
    true -> % Works as the 'else' branch, meaning the value is odd
      list_evens(Rest, Results)
  end.

square_list([]) ->
  [];
square_list(List) ->
  SquareValue = fun(X) -> X * X end,
  lists:map(SquareValue, List).