defmodule BrandoGeoIP do
  @moduledoc """
  Documentation for `BrandoGeoIP`.
  """
  import Plug.Conn

  def init(options), do: options

  def call(%{path_info: []} = conn, _opts) do
    case Plug.Conn.get_session(conn, "language") do
      nil ->
        case Geolix.lookup(conn.remote_ip, where: :country) do
          nil ->
            lang = Brando.config(:default_language)
            redirect_with_lang(conn, lang)

          %Geolix.Adapter.MMDB2.Result.Country{country: %{iso_code: iso_code}} ->
            found_lang = String.downcase(iso_code)

            valid_langs =
              :languages
              |> Brando.config()
              |> List.flatten()
              |> Keyword.get_values(:value)

            lang =
              if found_lang in valid_langs do
                found_lang
              else
                Brando.config(:default_language)
              end

            redirect_with_lang(conn, lang)
        end

      lang ->
        redirect_with_lang(conn, lang)
    end
  end

  def call(conn, opts) do
    Brando.Plug.I18n.put_locale(conn, opts)
  end

  defp redirect_with_lang(conn, lang) do
    localized_index_path =
      if Brando.config(:scope_default_language_routes) do
        "/#{lang}"
      else
        if Brando.config(:default_language) == lang do
          "/"
        else
          "/#{lang}"
        end
      end

    conn
    |> Phoenix.Controller.redirect(to: localized_index_path)
    |> halt()
  end
end
