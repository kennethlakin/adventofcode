-module(aoc0102).
-export([run/0]).

run() ->
  {ok, RawContents}=file:read_file("input-01"),
  Contents=binary:split(RawContents, <<"\n">>, [global]),
  NumTimesWentDeeper=count_depth_increases(Contents),
  NumTimesWentDeeper.

count_depth_increases([]) -> 0;
count_depth_increases(List) when is_list(List) ->
  InitialWindow=[],
  count_depth_increases(List, InitialWindow, no_measurement, 0).

count_depth_increases([], _, _, Acc) -> Acc;
count_depth_increases([<<>>, <<>>], _, _, Acc) -> Acc;

count_depth_increases([H|T],  Window, M=no_measurement, Acc) when is_binary(H) andalso length(Window) < 2->
  {CurrDepth, <<>>}=string:to_integer(H),
  NewWindow=lists:append(Window, [CurrDepth]),
  count_depth_increases(T, NewWindow, M, Acc);
count_depth_increases([H|T],  Window, no_measurement, Acc) when is_binary(H) andalso length(Window) == 2->
  {CurrDepth, <<>>}=string:to_integer(H),
  NewWindow=lists:append(Window, [CurrDepth]),
  NewMeasurement=lists:foldl(fun(X, Sum) -> X + Sum end, 0, NewWindow),
  count_depth_increases(T, NewWindow, NewMeasurement, Acc);

count_depth_increases([H|T], Window, PrevMeasurement, Acc) when is_binary(H) andalso length(Window) == 3 ->
  {CurrDepth, <<>>}=string:to_integer(H),
  %Drop the oldest measurement and append the newest.
  NewWindow=lists:append(
              lists:nthtail(1, Window), [CurrDepth]),
  NewMeasurement=lists:foldl(fun(X, Sum) -> X + Sum end, 0, NewWindow),
  case NewMeasurement > PrevMeasurement of
    true -> NewAcc=Acc + 1;
    false -> NewAcc=Acc
  end,
  count_depth_increases(T, NewWindow, NewMeasurement, NewAcc).

