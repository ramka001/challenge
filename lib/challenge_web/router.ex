defmodule ChallengeWeb.Router do
  use Plug.Router
  alias Challenge.DbSetup
  plug Plug.Parsers, parsers: [:urlencoded, :multipart]

  plug :match
  plug :dispatch


  # This is a basic home page with 2 links
  # i.e. Foo Page which links to /dbs/foo/tables/source url
  # and Bar Page which links to /dbs/bar/tables/dest url
  get "/" do
    page = EEx.eval_file("views/index.html.eex")
    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200,page)
  end



  # This GET function is to invoke either /dbs/foo/tables/source or /dbs/bar/tables/dest endpoint
  # and return the contents of the corresponding table serialized as CSV and using HTTP chunked encoding
  get "/dbs/:db/tables/:table" do
    {:ok, pid_1} = DbSetup.connect_to_db(conn.params["db"])
    chunk_1 = send_chunked(conn, 200)
    try do
      pid_1 |> Postgrex.transaction(fn(db) ->
        query_1 = db |> Postgrex.prepare!("", "COPY #{conn.params["table"]} TO STDOUT WITH DELIMITER ','")
        stream = db |> Postgrex.stream(query_1, [])
        result_to_iodata = fn(%Postgrex.Result{rows: rows}) -> {:ok, _conn} = chunk(chunk_1, Enum.join(rows, "")) end
        stream |> Enum.into([], result_to_iodata)
      end)
      chunk_1
    after
      pid_1 |> GenServer.stop()
    end
  end

  match _, do: conn |> send_resp(404, "Oops!\n")

end
