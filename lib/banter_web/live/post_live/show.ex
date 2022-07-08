defmodule BanterWeb.PostLive.Show do
  use BanterWeb, :live_view

  alias Banter.Timeline

  @impl true
  def mount(_params, %{"current_user" => current_user} = _session, socket) do
    {:ok, assign(socket, :current_user, current_user)}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:post, Timeline.get_post!(id))}
  end

  defp page_title(:show), do: "Show Post"
  defp page_title(:edit), do: "Edit Post"
end
