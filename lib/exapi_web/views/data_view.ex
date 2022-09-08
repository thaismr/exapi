defmodule ExapiWeb.DataView do
  use ExapiWeb, :view

  def render("data.json", %{data: data}) do
    data
  end
end
