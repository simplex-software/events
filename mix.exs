defmodule Events.Mixfile do
  use Mix.Project

  def project do
    [app: :events,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     escript: escript(),
     aliases: aliases()
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger],
    mod: {Events, []}]
  end

  def escript do
    [main_module: Events.CLI,
    app: nil,
    emu_args: "-setcookie events"]
  end

  # Aliases. Check https://hexdocs.pm/mix/Mix.html#module-aliases for more information
  defp aliases do
    [
      test: "test --no-start" #needed to avoid buldog to start when running tests
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    []
  end
end
