defmodule ExapiWeb.Auth.Guardian do
  use Guardian, otp_app: :exapi

  alias Exapi.User

  def subject_for_token(%User{id: id}, _claims), do: {:ok, id}

  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(%{"sub" => id}) do
    Exapi.get_user_by_id(id)
  end

  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end
end
