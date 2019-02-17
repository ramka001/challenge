# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# third-party users, it should be done in your "mix.exs" file.

# You can configure your application as:
#
#     config :challenge, key: :value
#
# and access this configuration in your application as:
#
#     Application.get_env(:challenge, :key)
#
# You can also configure a third-party app:
#
     config :logger, level: :info
#

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
#     import_config "#{Mix.env()}.exs"

config :challenge, :cowboy, cowboy_port: 4000


#  Do not change the value for database: as the values are already set in the code
#  You can alter the values username:, password:, hostname: and port:
config :challenge, :postgrex,
       database: "postgres",
       username: "postgres",
       password: "Qwerty@123#",
       hostname: "localhost",
       port: 5432,
       pool: DBConnection.ConnectionPool,
       pool_size: 8

config :challenge, :postgrex,
       database: "foo",
       username: "postgres",
       password: "Qwerty@123#",
       hostname: "localhost",
       port: 5432,
       pool: DBConnection.ConnectionPool,
       pool_size: 8

config :challenge, :postgrex,
       database: "bar",
       username: "postgres",
       password: "Qwerty@123#",
       hostname: "localhost",
       port: 5432,
       pool: DBConnection.ConnectionPool,
       pool_size: 8



