defmodule Challenge.RouterTest do
 use ExUnit.Case
 use Plug.Test

 alias ChallengeWeb.Router

 @opts Router.init([])


 test "returns welcome" do
   conn =
     conn(:get, "/", "")
     |> Router.call(@opts)
   assert conn.state == :sent
   assert conn.status == 200
 end

 test "returns source" do
   conn =
     conn(:get, "/dbs/foo/tables/source")
     |> Router.call(@opts)

   assert conn.state == :chunked
   assert conn.status == 200
 end

 test "returns destination" do
   conn =
     conn(:get, "/dbs/bar/tables/dest")
     |> Router.call(@opts)

   assert conn.state == :chunked
   assert conn.status == 200
 end


 test "returns 404" do
   conn =
     conn(:get, "/missing", "")
     |> Router.call(@opts)

   assert conn.state == :sent
   assert conn.status == 404
 end

end
