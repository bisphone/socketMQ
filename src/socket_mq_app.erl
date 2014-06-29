-module(socket_mq_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
   application:start(crypto),
   application:start(ranch),
   application:start(cowlib),
   application:start(cowboy),
   Dispatch = cowboy_router:compile([
      %% {URIHost, [{URIPath, Handler, Opts}]}
      %% '_' is wildcard, means all URLs
      %% maps to this handler
      {'_',
         [
            {"/", socket_mq_root_handler, []}
         ]
      }
   ]),
   %% Name, NumOfAcceptors, TransOpts, ProtoOpts
   cowboy:start_http(socket_mq_http_listener, 100,
      [{port, 8080}],
      [{env, [{dispatch, Dispatch}]}]
   ),
   socket_mq_sup:start_link().

stop(_State) ->
    ok.
