-module(dist).
-export([ping/2, pong/0, start_ping/2, start_pong/0]).

ping(0, Pong_Node) ->
  {pong, Pong_Node} ! finished,
  io:format("Ping finished~n");
ping(N, Pong_Node) ->
  {pong, Pong_Node} ! {ping, self()},
  receive
    pong ->
      io:format("Pong received~n")
  end,
  ping(N-1, Pong_Node).

pong() ->
  receive
    {ping, Ping_Node} ->
      io:format("Ping received~n"),
      Ping_Node ! pong,
      pong();
    finished ->
      io:format("Ping finished")
  end.

start_ping(Count, Pong_Node) ->
  spawn(dist, ping, [Count, Pong_Node]).

start_pong() ->
  register(pong, spawn(dist, pong, [])).