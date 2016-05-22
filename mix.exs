defmodule Euler_1.Mixfile do
  use Mix.Project

  def project do
    [app: :euler_1,
     version: "0.0.1",
     name: "Elixir Examples",
     elixir: "~> 1.2",
     source_url: "https://github.com/mcelaney/elixir_examples",
     homepage_url: "http://twitter.com/mcelaney",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps,
     docs: [extras: ["README.md"]]]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:bmark, "~> 1.0.0"},
     {:credo, "~> 0.3", only: [:dev, :test]},
     {:dialyxir, "~> 0.3", only: [:dev]},
     {:earmark, "~> 0.1", only: :dev},
     {:ex_doc, "~> 0.11", only: :dev}]
  end
end
