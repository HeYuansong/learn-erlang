-module(tcp_server).
-compile(export_all).
start_nano_server()->
    {ok, Listen} = gen_tcp:listen(2345,
				[binary,
				{packet,0},
				{reuseaddr,true},
				{active,true}
				]),
    {ok, Socket} = gen_tcp:accept(Listen),
    gen_tcp:close(Listen),
    loop(Socket).
loop(Socket)->
    receive
	{tcp, Socket, Bin} ->
	    io:format("Server receive binary = ~p~n",[Bin]),
	    %Str = binary_to_term(Bin),
	    %io:format("server (unpacked) ~p~n",[Str]),
	    Reply = "hello\n",
	    io:format("server replying ~n"),
	    gen_tcp:send(Socket,term_to_binary(Reply)),
	    loop(Socket);
	{tcp_closed, Socket} ->
	    io:format("server socket closed ~n")
    end.
