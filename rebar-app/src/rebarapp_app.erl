-module(rebarapp_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    lager:info("Child process started"),
    ok = serve(),
    rebarapp_sup:start_link().

stop(_State) ->
    ok.

%% ===================================================================
%% Internal methods
%% ===================================================================

serve() ->
  {ok, _} = inets:start(httpd, [
    {port,8081}, % Port to listen on
    {server_name,"Erlang HTTPD Server"}, % Server name
    {server_root,"log"}, % Log directory 
    {document_root,"public"}, % Document root (HTML, JS, CSS)
    {bind_address,{127,0,0,1}}, % Interface to bind on. NOTE: Defining "localhost" doesn't work here
    {directory_index, ["index.html"]} % Index file
  ]),
  ok.