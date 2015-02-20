% TCP Echo
%
% This module will listen on the given port (default 9999 if no port is given)
% and echo back to the user what they had entered

-module(tcpecho).
-export([serve/0, serve/1]).

serve() ->
	serve(9999).
serve(Port) ->
	{ok, LSock} = gen_tcp:listen(Port, [binary, {packet, 0}, {active, false}]),
	listen_loop(LSock).

listen_loop(LSock) ->
	{ok, Sock} = gen_tcp:accept(LSock),
	do_recv(Sock),
	listen_loop(LSock).	

do_recv(Sock) ->
	case gen_tcp:recv(Sock, 0) of
		{ok, B} ->
			io:fwrite("~s", [binary_to_list(B)]),
			do_recv(Sock);
		{error, closed} ->
			gen_tcp:close(Sock)
	end.