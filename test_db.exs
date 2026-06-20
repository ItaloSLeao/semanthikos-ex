import Ecto.Query

event_id = 4
user_id = 9

attrs = %{
  event_id: event_id,
  user_id: user_id,
  message: "Test message from script",
  is_question: false
}

IO.puts("Inserting chat message...")
case EventManager.Services.create_chat_message(attrs) do
  {:ok, msg} -> IO.puts("Successfully created message #{msg.id}")
  {:error, cs} -> IO.inspect(cs.errors, label: "Errors")
end

messages = EventManager.Services.list_event_chat_messages(event_id)
IO.puts("Total messages: #{length(messages)}")
