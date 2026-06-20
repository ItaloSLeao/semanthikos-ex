import Phoenix.LiveView.Helpers
import Phoenix.LiveView

socket = %Phoenix.LiveView.Socket{assigns: %{__changed__: %{}, streams: %{}}}

try do
  socket = stream(socket, :messages, [%{id: 1, message: "Hello"}])
  IO.puts("Stream mount OK")
rescue
  e -> IO.puts("Stream mount CRASH: #{inspect e}")
end
