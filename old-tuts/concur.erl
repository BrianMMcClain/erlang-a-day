-module(concur).
-export([say_something/2, start_ping/1, ping/2, pong/0, ping_registered/1, pong_registered/0, start_registered_ping/1]).

say_something(_, 0) ->
  done;
say_something(Phrase, N) ->
  io:format("~p~n", [Phrase]),
  say_something(Phrase, N-1).

ping(0, _) ->
  io:format("Ping Finished~n", []);
ping(N, Pong_Pid) ->
  Pong_Pid ! {ping, self()},
  receive
    pong ->
      io:format("Pong received from ping ~w~n", [Pong_Pid])
  end,
  ping(N-1, Pong_Pid).

pong() ->
  receive
    finished ->
      io:format("Pong finished~n", []);
    {ping, Ping_Pid} ->
      io:format("Ping received from pong ~w~n", [Ping_Pid]),
      Ping_Pid ! pong,
      pong()
  end.

start_ping(Count) ->
  Pong_Pid = spawn(concur, pong, []),
  spawn(concur, ping, [Count, Pong_Pid]).



ping_registered(0) ->
  io:format("Ping Finished~n", []);
ping_registered(N) ->
  pong_pid ! {ping, self()},
  receive
    pong ->
      io:format("Pong received from ping~n", [])
  end,
  ping_registered(N-1).

pong_registered() ->
  receive
    finished ->
      io:format("Pong finished~n", []);
    {ping, Ping_Pid} ->
      io:format("Ping received from pong~n", []),
      Ping_Pid ! pong,
      pong_registered()
  end.

start_registered_ping(Count) ->
  register(pong_pid, spawn(concur, pong_registered, [])),
  spawn(concur, ping_registered, [Count]).