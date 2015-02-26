-module(revprox_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    revprox_sup:start_link(),

    % Start required applications
    ensure_started(crypto),
    ensure_started(asn1),
    ensure_started(public_key),
    ensure_started(ssl),
    ensure_started(idna),
    ensure_started(hackney),

    % Start Elli link
    {ok, Pid} = elli:start_link([{callback, revprox_callback}, {port, 3000}]).

stop(_State) ->
    ok.

ensure_started(App) ->
  case application:start(App) of
    ok ->
      ok;
    {error, {already_started, App}} ->
      ok
  end.