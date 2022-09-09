defmodule Exapi.Factory do
  use ExMachina.Ecto, repo: Exapi.Repo

  alias Exapi.User

  def user_params_factory do
    %{
      "password" => "123456"
    }
  end

  def user_factory do
    %User{
      password: "123456",
      id: "d48a7772-daae-4e51-bb9c-698133331a73"
    }
  end
end
