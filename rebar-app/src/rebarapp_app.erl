-module(rebarapp_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    lager:info("Child process started"),
    rebarapp_sup:start_link().

stop(_State) ->
    ok.
