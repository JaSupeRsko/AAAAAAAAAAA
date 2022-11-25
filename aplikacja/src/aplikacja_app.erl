%%%-------------------------------------------------------------------
%% @doc aplikacja public API
%% @end
%%%-------------------------------------------------------------------

-module(aplikacja_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    aplikacja_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
