-module(tcpecho).
-export([serve/0, serve/1]).

serve() ->
	serve(9999).
serve(Port) ->
	{ok, LSock} = gen_tcp:listen(Port, [binary, {packet, 0}, {active, false}]),
	{ok, Sock} = gen_tcp:accept(LSock),
	{ok, Bin} = do_recv(Sock, []),
	ok = gen_tcp:close(Sock),
	Bin.

do_recv(Sock, Bs) ->
	case gen_tcp:recv(Sock, 0) of
		{ok, B} ->
			do_recv(Sock, [Bs, B]);
		{error, closed} ->
			{ok, Bs}
	end.