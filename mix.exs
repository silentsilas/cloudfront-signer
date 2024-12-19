defmodule CloudfrontSigner.MixProject do
  use Mix.Project

  def project do
    [
      app: :cloudfront_signer,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      package: package(),
      description: description(),
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {CloudfrontSigner.Application, []}
    ]
  end

  defp deps do
    [
      {:poison, "~> 6.0"},
      {:timex, "~> 3.7"},
      {:ex_doc, "~> 0.35", only: :dev}
    ]
  end

  defp description() do
    "Elixir implementation of Cloudfront's url signature algorithm."
  end

  defp package() do
    [
      # These are the default files included in the package
      files: ~w(lib config .formatter.exs mix.exs README* LICENSE*),
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/silentsilas/cloudfront-signer"}
    ]
  end
end
