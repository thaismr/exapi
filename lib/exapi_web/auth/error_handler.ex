defmodule ExapiWeb.Auth.ErrorHandler do
  alias Guardian.Plug.ErrorHandler
  alias Plug.Conn

  @behaviour ErrorHandler

  def auth_error(_conn, {error, _reason}, _opts) do
    body = Jason.encode!(%{message: to_string(error)})
  end
end
