-module(revprox_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    revprox_sup:start_link(),
    {ok, Pid} = elli:start_link([{callback, revprox_callback}, {port, 3000}]).

stop(_State) ->
    ok.
