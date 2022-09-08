defmodule Exapi.Github.Response do
  @moduledoc """
  Response format for Github API data
  """
  @derive Jason.Encoder
  defstruct [:id, :name, :description, :html_url, :stargazers_count]

  def build_response(%{
        "id" => id,
        "name" => name,
        "description" => description,
        "html_url" => html_url,
        "stargazers_count" => stargazers_count
      }) do
    %__MODULE__{
      id: id,
      name: name,
      description: description,
      html_url: html_url,
      stargazers_count: stargazers_count
    }
  end
end
