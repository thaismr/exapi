defmodule ExapiWeb.DataView do
  use ExapiWeb, :view

  def render("data.json", %{data: data, token: token}) do
    %{data: data, token: token}
  end
end
