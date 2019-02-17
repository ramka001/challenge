defmodule Challenge.MixProject do
  use Mix.Project

  def project do
    [
      app: :challenge,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :postgrex, :plug_cowboy],
      mod: {Challenge.Application, []},
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:postgrex, ">= 0.0.0"},
      {:plug_cowboy, "~> 2.0"}
    ]
  end
end
