# Rebar App

Example application built using rebar

Rebar Usage
-----------

Download rebar and generate a new app
```
wget https://raw.github.com/wiki/rebar/rebar/rebar && chmod u+x rebar
./rebar create-app appid=rebarapp
```

Ensure it compiles
```
./rebar compile
```

Add dependencies to rebar.config, in this case, lager
```
{deps, [
  {lager, "2.1.1", {git, "https://github.com/basho/lager.git", "2.1.1"}}
]}.

{erl_opts, [{parse_transform, lager_transform}]}.
```

Pull down dependencies
```
./rebar get-deps
```

Compile
```
./rebar compile
```

And run it
```
$ erl -pa ebin/ -pa deps/lager/ebin deps/goldrush/ebin -s lager -config app.config
Erlang/OTP 17 [erts-6.3] [source] [64-bit] [smp:4:4] [async-threads:10] [hipe] [kernel-poll:false]

Eshell V6.3  (abort with ^G)
1> 23:24:02.241 [info] Application lager started on node nonode@nohost

1> inets:start().
ok
2> 23:24:11.529 [info] Application inets started on node nonode@nohost

2> application:start(rebarapp).
23:24:18.312 [info] Child process started
23:24:18.417 [info] Supervisor link started
ok
23:24:18.417 [info] Application rebarapp started on node nonode@nohost
```