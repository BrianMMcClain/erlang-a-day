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
	{ok, Sock} = gen_tcp:accept(LSock),
	{ok, Bin} = do_recv(Sock, []),
	ok = gen_tcp:close(Sock),
	binary_to_list(Bin).

do_recv(Sock, Bs) ->
	case gen_tcp:recv(Sock, 0) of
		{ok, B} ->
			do_recv(Sock, lists:append(Bs, B));
		{error, closed} ->
			{ok, Bs}
	end.