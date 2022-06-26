defmodule BrandoGeoIP.MixProject do
  use Mix.Project

  def project do
    [
      app: :brando_geoip,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug, "> 0.0.0"},
      {:geolix, "~> 2.0"},
      {:geolix_adapter_mmdb2, "~> 0.6.0"},
      {:brando, github: "brandocms/brando", optional: true},
      {:phoenix, "> 0.0.0", optional: true}
    ]
  end
end
