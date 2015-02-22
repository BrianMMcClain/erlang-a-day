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