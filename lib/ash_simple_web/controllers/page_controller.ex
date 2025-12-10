defmodule AshSimpleWeb.PageController do
  use AshSimpleWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
