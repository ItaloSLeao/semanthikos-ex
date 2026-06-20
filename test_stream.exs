defmodule StreamTest do
  import Phoenix.LiveView

  def test do
    socket = %Phoenix.LiveView.Socket{assigns: %{__changed__: %{}, streams: %{}}}
    messages = [%{id: 1, message: "Hello"}]
    socket = stream(socket, :messages, messages)
    IO.inspect(socket.assigns.streams.messages)
  end
end
StreamTest.test()
