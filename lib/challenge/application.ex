defmodule Challenge.Application do
  use Application
  require Logger
  alias Challenge.DbSetup

  def start(_type, _args) do

    DbSetup.setup_database()
    DbSetup.insert_into_source()
    DbSetup.copy_from_source_to_dest()

    children = [
      {Plug.Cowboy, scheme: :http, plug: ChallengeWeb.Router, options: [port: cowboy_port()]}
    ]

    opts = [strategy: :one_for_one, name: Challenge.Supervisor]

    Logger.info("Starting application...")
    Supervisor.start_link(children, opts)
  end


  # This is to invoke the port to access the cowboy web server.
  # If the port number is to be changed please use the config.exs
  # file to update the value
  defp cowboy_port, do: Application.get_env(:challenge, :cowboy) |> Keyword.get(:cowboy_port)

end
