-module(revprox_callback).
-export([handle/2, handle_event/3]).

-include_lib("elli/include/elli.hrl").
-behaviour(elli_handler).

handle(Req, _Args) ->
    %% Delegate to our handler function
    handle(Req#req.method, elli_request:path(Req), Req).

% handle('GET',[<<"hello">>, <<"world">>], _Req) ->
%     %% Reply with a normal response. 'ok' can be used instead of '200'
%     %% to signal success.
%     {ok, [], <<"Hello World!">>};

handle(Method, Path, _Req) ->
    print_headers(_Req#req.headers),
    NewURI = get_uri("https://api.github.com", Path),
    {ok, StatusCode, RespHeaders, ClientRef} = hackney:request(Method, NewURI, [], list_to_binary([]), []),
    {ok, Body} = hackney:body(ClientRef),
    {StatusCode, RespHeaders, Body}.

%% @doc: Handle request events, like request completed, exception
%% thrown, client timeout, etc. Must return 'ok'.
handle_event(_Event, _Data, _Args) ->
    ok.

%% ==========================
%% Private Methods
%% ==========================

get_uri(Host, []) ->
  Host;
get_uri(Host, Path) ->
  StrPath = lists:map(fun(X) -> binary_to_list(X) end, Path),
  Host ++ "/" ++ string:join(StrPath, "/").

print_headers([]) ->
  done;
print_headers([{Header, Value} | Rest]) ->
  io:format("~s: ~s~n", [binary_to_list(Header), binary_to_list(Value)]),
  print_headers(Rest).

