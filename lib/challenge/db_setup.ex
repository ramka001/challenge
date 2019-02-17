defmodule Challenge.DbSetup do
  require Logger

  @doc """
   This function is to create the databases foo and bar.
   And also create the tables source in the foo database and the table dest in the bar database
  """
  def setup_database() do
    {:ok, pid_1} = connect_to_db("postgres")
    pid_1 |> Postgrex.query!("DROP DATABASE IF EXISTS foo",[])
    pid_1 |> Postgrex.query!("DROP DATABASE IF EXISTS bar",[])
    pid_1 |> Postgrex.query!("CREATE DATABASE foo",[])
    pid_1 |> Postgrex.query!("CREATE DATABASE bar",[])
    pid_1 |> GenServer.stop()
    Logger.info("Databases foo and bar have been created")

    {:ok, pid_2} = connect_to_db("foo")
    pid_2 |> Postgrex.query!("CREATE TABLE IF NOT EXISTS source(a numeric, b numeric, c numeric)",[])
    pid_2 |> GenServer.stop()
    Logger.info("source table in foo database has been created")

    {:ok, pid_3} = connect_to_db("bar")
    pid_3 |> Postgrex.query!("CREATE TABLE IF NOT EXISTS dest (a numeric, b numeric, c numeric)",[])
    pid_3|> GenServer.stop()
    Logger.info("dest table in bar database has been created")
  end



  @doc """
    This is to insert 1,000,000 rows into the source table in the foo database
  """
  def insert_into_source() do
    {:ok, pid_1} = connect_to_db("foo")
    query_1 = "INSERT INTO source (a,b,c)
               SELECT generate_series(1,1000000),
               mod(generate_series(1,1000000),3),
               mod(generate_series(1,1000000),5);"
    pid_1 |> Postgrex.query!(query_1, [])
    pid_1 |> GenServer.stop()
    Logger.info("Insertion to source table completed")
  end


  @doc """
   This function is to copy the 1,000,000 rows from the source table in the foo database
   and store in into the dest table of the bar database.
  """
  def copy_from_source_to_dest() do
    file_name = "source"
    file = file_name |> Path.expand() |> Path.absname()

    {:ok, pid_1} = connect_to_db("foo")
    pid_1 |> Postgrex.transaction(fn(conn) ->
      query_1 = conn |> Postgrex.prepare!("", "COPY source TO STDOUT DELIMITER ','")
      stream = conn |> Postgrex.stream(query_1, [])
      result_to_iodata = fn(%Postgrex.Result{rows: rows}) -> rows end
      stream |> Enum.into(file_name |> File.stream!(), result_to_iodata)
    end)
    pid_1 |> GenServer.stop()

    {:ok, pid_2} = connect_to_db("bar")
    query_2 = "COPY dest(a,b,c) FROM '#{file}' DELIMITER ','";
    pid_2 |> Postgrex.query!(query_2,[])
    pid_2 |> GenServer.stop()
    file |> File.rm()

    Logger.info("Data copied from source table to dest table completed")
  end

  @doc """
    This is database connection function, where the only value to be unique is the database name i.e. db_name.
    If the other values i.e. hostname, username, password, port_number need to be modified, use the
    config.exs file
  """
  def connect_to_db(db_name) do
    Postgrex.start_link(
      hostname: db_hostname(),
      username: db_username(),
      password: db_password(),
      database: db_name,
      port: port_number(),
      pool: DBConnection.ConnectionPool,
      pool_size: 10
    )
  end

  defp db_username, do: Application.get_env(:challenge, :postgrex) |> Keyword.get(:username)

  defp db_password, do: Application.get_env(:challenge, :postgrex) |> Keyword.get(:password)

  defp db_hostname, do: Application.get_env(:challenge, :postgrex) |> Keyword.get(:hostname)

  defp port_number, do: Application.get_env(:challenge, :postgrex) |> Keyword.get(:port)

end