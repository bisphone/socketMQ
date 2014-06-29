-module(socket_mq_root_handler).
-behaviour(cowboy_http_handler).

-export([init/3,
         handle/2,
         terminate/3]).

init(_Type, Req, _Opts) ->
   {ok, Req, undefined_state}.

handle(Req, State) ->
   io:format("~nRequest Log:~n ~p~n", [Req]),
   {ok, Rep} = cowboy_req:reply(200, [
      {<<"content-type">>, <<"text/plain">>}
   ], <<"Hello socketMQ!">>, Req),
   {ok, Rep, State}.

terminate(_Reason, _Req, _State) ->
   ok.
