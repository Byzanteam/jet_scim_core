defmodule JetScimCore.MixProject do
  use Mix.Project

  def project do
    [
      app: :jet_scim_core,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:ecto, "~> 3.8"},
      {:jet_ext, github: "byzanteam/jet-ext"},
      {:urn, "~> 1.0"},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false}
    ]
  end
end
