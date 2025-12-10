defmodule AshSimpleWeb.EstimateLive do
  use AshSimpleWeb, :live_view
  alias AshSimple.Billing.Estimate

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    estimate =
      Estimate.create!(%{original_price: 100, discount_price: 10})

    form =
      estimate
      |> AshPhoenix.Form.for_update(:update)
      |> to_form()

    socket =
      socket
      |> assign(:form, form)

    {:ok, socket}
  end

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <div>
      <h1>Estimate</h1>

      <.form for={@form} phx-change="validate" phx-submit="save">
        <.input field={@form[:original_price]} label="Original Price" />
        <.input field={@form[:discount_price]} label="Discount Price" />
        <.input field={@form[:final_price]} label="Final Price" readonly />

        <div>
          <.button type="submit">Save Estimate</.button>
        </div>
      </.form>
    </div>
    """
  end

  @impl Phoenix.LiveView
  def handle_event("validate", %{"_target" => _target, "form" => form_params}, socket) do
    # form_params =
    #   case target do
    #     ["form", "final_price"] -> form_params
    #     _ -> form_params |> Map.delete("final_price")
    #   end

    form =
      socket.assigns.form
      |> AshPhoenix.Form.validate(form_params)
      |> to_form()

    socket =
      socket
      |> assign(:form, form)

    {:noreply, socket}
  end
end
