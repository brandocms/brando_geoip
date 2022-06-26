# Brando Geo IP

Redirect root route based on GeoLite2 country lookups.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `brando_geoip` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:brando_geoip, "~> 0.1.0"}
  ]
end
```
Download the GeoLite2 database by creating a MaxMind account here:

https://www.maxmind.com/en/account/login

then go to "GeoIP2/GeoLite2 > Download Files" in the side menu and
download the GeoLite2 country db in mmdb format.

Place the file in `./media/GeoLite2-Country.mmdb`

Add to your `config.exs`:

```elixir
config :geolix,
  databases: [
    %{
      id: :country,
      adapter: Geolix.Adapter.MMDB2,
      source: "./media/GeoLite2-Country.mmdb"
    }
  ]
```

Finally add `BrandoGeoIP` to your `:browser` pipeline after 
`RemoteIP` in `router.ex`

```elixir
pipeline :browser do
  # ...
  plug RemoteIp
  plug BrandoGeoIP
  # ...
```