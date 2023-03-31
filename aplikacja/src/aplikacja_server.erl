-module(aplikacja_server).
-behaviour(gen_server).

-export([start_link/0]).
-export([init/1, handle_call/3, handle_cast/2, calculate/3, service/3]).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init([]) ->
    io:format("Started"),
    inets:start(httpd, [{modules,
                        [
                            mod_alias,
                            mod_auth,
                            mod_esi,
                            mod_actions,
                            mod_cgi,
                            mod_dir,
                            mod_get,
                            mod_head,
                            mod_log,
                            mod_disk_log
                        ]},
                    {port, 8001},
                    {server_name, "localhost"},
                    {server_root, "./"},
                    {document_root, "./htdocs"},
                    {directory_index, ["index.html"]},
                    {erl_script_alias, {"/test", [aplikacja_server]}},
                    {bind_address, "localhost"},
                    {mime_types, 
                    [{"html", "text/html"}, {"css", "text/css"}, {"js", "application/x-javascript"}]}]),
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

service(SessionID, _Env, _Input) ->
    mod_esl:deliver(SessionID, ["Content - Type: text/html\r\n\r\n", "<html><head></head><body>aaaa</body></html>"]).