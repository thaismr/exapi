defmodule Exapi.Github do
  @moduledoc false

  alias Exapi.Github.Client

  def call(%{"user" => user}) do
    Client.get_user_repos(user)
  end
end
