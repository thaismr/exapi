defmodule Exapi do
  @moduledoc """
  Exapi keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  alias Exapi.Github
  alias Exapi.Users.Create, as: CreateUser
  alias Exapi.Users.Get, as: GetUser

  defdelegate create_user(params), to: CreateUser, as: :call
  defdelegate get_user_by_id(id), to: GetUser, as: :by_id
  defdelegate github_data(params), to: Github, as: :call
end
