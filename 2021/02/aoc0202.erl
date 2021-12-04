-module(aoc0202).
-export([run/0]).

run() ->
  {ok, RawContents} = file:read_file("input-01"),
  Contents = binary:split(RawContents, <<"\n">>, [global]),
  DistanceTravelled = countDistanceTravelled(Contents),
  DistanceTravelled.

countDistanceTravelled([]) -> 0;
countDistanceTravelled(Lines) when is_list(Lines) ->
	countDistanceTravelled(Lines, 0, 0, 0).

countDistanceTravelled([], Vert, Horiz, _) -> Vert*Horiz;
countDistanceTravelled([<<>>], Vert, Horiz, _) -> Vert * Horiz;
countDistanceTravelled([<<"down ", RawDist/binary>>|T], Vert, Horiz, Aim) ->
  {Distance, <<>>} = string:to_integer(RawDist),
	countDistanceTravelled(T, Vert, Horiz, Aim + Distance);
countDistanceTravelled([<<"up ", RawDist/binary>>|T], Vert, Horiz, Aim) ->
  {Distance, <<>>} = string:to_integer(RawDist),
	countDistanceTravelled(T, Vert, Horiz, Aim - Distance);
countDistanceTravelled([<<"forward ", RawDist/binary>>|T], Vert, Horiz, Aim) ->
  {Distance, <<>>} = string:to_integer(RawDist),
	countDistanceTravelled(T, Vert + (Aim * Distance), Horiz + Distance, Aim).
