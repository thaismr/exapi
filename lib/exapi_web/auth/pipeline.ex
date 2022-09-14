defmodule ExapiWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :exapi

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
  plug ExapiWeb.Plug.RefreshToken
end
