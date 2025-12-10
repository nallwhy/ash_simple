defmodule AshSimpleWeb.EstimateLive do
  use AshSimpleWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <h1>Estimate</h1>
    </div>
    """
  end
end
