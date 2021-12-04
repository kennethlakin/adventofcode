-module(aoc0101).
-export([run/0]).

run() ->
  {ok, RawContents} = file:read_file("input-01"),
  Contents = binary:split(RawContents, <<"\n">>, [global]),
  NumTimesWentDeeper = count_depth_increases(Contents),
  NumTimesWentDeeper.

count_depth_increases([]) -> 0;
count_depth_increases(List) when is_list(List) ->
  count_depth_increases(List, no_measurement,  0).

count_depth_increases([], _, Acc) -> Acc;
count_depth_increases([<<>>, <<>>], _, Acc) -> Acc;

count_depth_increases([H|T], PrevDepth, Acc) when is_binary(H) ->
  {CurrDepth, <<>>} = string:to_integer(H),
  case PrevDepth of
    no_measurement -> NewAcc = Acc;
    _ ->
      case CurrDepth > PrevDepth of
        true -> NewAcc = Acc + 1;
        false -> NewAcc = Acc
      end
  end,
  count_depth_increases(T, CurrDepth, NewAcc).

