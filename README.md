# Adjust Code challenge
<h3>The application is built with Elixir 1.8 and Postgresql 10 is used for the Database</h3>
<br/><h4>The dependency libraries used are:- </h4>

```
{:postgrex, ">= 0.0.0"}
```
 
```
{:plug_cowboy, "~> 2.0"}
```

<br/><h3>The application needs to its dependencies and has to be built prior to execution.</h3>

<br/><h4>Before building the app, if there any Database or Cowboy configuration you need to change,
    please use the</h4>
    
```
config/config.exs
```     

<h4>For the database, You can alter the values username:, password:, hostname: and port: . 
    And for the Cowboy you can alter the port number
</h4> 

<br/><h4>To get the dependencies and compile the files run:</h4>

```
mix do deps.get, compile
```

<br/><h4>To run the test case run:</h4>

```
mix test
```

<br/><h4>To execute the app you can either run:</h4>

```
mix run --no-halt
``` 

<br/><h4>or if you prefer to have a <u>iex ></u> prompt run:</h4>

```
iex -S mix
```  

<br/><h4>To view the table by using a <u>GET</u> request run: </h4>

```
curl -h http://localhost:4000/dbs/foo/tables/source
``` 

<h4>or</h4>

```
curl -h http://localhost:4000/dbs/bar/tables/dest
```

<br/><h4>And the output produced is as below. The result is trimmed due to the length of the output</h4>

```
$ curl -v http://localhost:4000/dbs/foo/tables/source
*   Trying 127.0.0.1...
* TCP_NODELAY set
* Connected to localhost (127.0.0.1) port 4000 (#0)
> GET /dbs/foo/tables/source HTTP/1.1
> Host: localhost:4000
> User-Agent: curl/7.58.0
> Accept: */*
> 
< HTTP/1.1 200 OK
< cache-control: max-age=0, private, must-revalidate
< date: Sun, 17 Feb 2019 11:23:14 GMT
< server: Cowboy
< transfer-encoding: chunked
< 
1,1,1
2,2,2
3,0,3
4,1,4
5,2,0
6,0,1
7,1,2
8,2,3
9,0,4
10,1,0
11,2,1
12,0,2
13,1,3
14,2,4
15,0,0
.
.
.
.
999991,1,1
999992,2,2
999993,0,3
999994,1,4
999995,2,0
999996,0,1
999997,1,2
999998,2,3
999999,0,4
1000000,1,0
* Connection #0 to host localhost left intact
```

<br/><h4>It can also be run on the browser from this url</h4>

```
http://localhost:4000/
```

<h4>A basic html page is displayed with 2 links i.e. <u>Foo Page</u> and <u>Bar Page</u><h4>

<br/><h4>The <u>Foo Page</u> link redirects you to</h4> 

```
http://localhost:4000/dbs/foo/tables/source
```

<h4>and the <u>Bar Page</u> link redirects you to </h4>

```
http://localhost:4000/dbs/bar/tables/dest
```
