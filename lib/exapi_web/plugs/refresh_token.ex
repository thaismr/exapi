defmodule ExapiWeb.Plug.RefreshToken do
  @moduledoc """
  Guardian plug to refresh auth token. Must be placed after all needed token validation.
  """
  import Guardian.Plug

  alias ExapiWeb.Auth.Guardian

  def init(opts), do: opts

  def call(conn, opts) do
    with token <- current_token(conn, opts),
         token <- refresh_token(token),
         conn <- put_current_token(conn, token, opts) do
      conn
    else
      _ -> conn
    end
  end

  def refresh_token(token) do
    case Guardian.refresh(token, ttl: {1, :minute}) do
      {:ok, _, {new_token, _}} -> new_token
      _ -> nil
    end
  end
end
