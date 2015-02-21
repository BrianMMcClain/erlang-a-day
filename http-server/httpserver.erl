% Simple inets HTTP server

% Prereq: Must run "inets:start()" prior to running the server
-module(httpserver).
-export([serve/0, serve/1]).

% If not port is defined, serve on port 8081
serve() ->
  serve(8081).
% Start inets httpd server on specified port
serve(Port) ->
  {ok, Pid} = inets:start(httpd, [
    {port,Port}, % Port to listen on
    {server_name,"Erlang HTTPD Server"}, % Server name
    {server_root,"log"}, % Log directory 
    {document_root,"public"}, % Document root (HTML, JS, CSS)
    {bind_address,{127,0,0,1}}, % Interface to bind on. NOTE: Defining "localhost" doesn't work here
    {directory_index, ["index.html"]} % Index file
  ]),
  % Return httpd Pid and Port that it is listening on
  {Pid, Port}.