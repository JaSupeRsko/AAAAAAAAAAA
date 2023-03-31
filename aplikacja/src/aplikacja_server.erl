-module(aplikacja_server).
-behaviour(gen_server).

-export([start_link/0]).
-export([init/1, handle_call/3, handle_cast/2, calculate/3]).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init([]) ->
    io:format("Started"),
    {ok, started}.

handle_call(A,B,C) ->
    io:format("A:~p~n:B~p~n:C~p~n",[A, B, C]),
    io:format("Received call"),
    {reply, a(lists:nth(1, A), lists:nth(2, A), lists:nth(3, A)), ok}.
a(A, B, '+') ->
    A + B;
a(A, B, '-') ->
    A - B;
a(A, B, '*') ->
    A * B;
a(A, B, '/') ->
    A / B.

handle_cast(A,B) ->
    io:format("Received cast"),
    {noreply, ok}.
calculate(A,B,C) ->
    gen_server:call(?MODULE, [A,B,C]).