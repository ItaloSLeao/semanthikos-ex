import Ecto.Query

messages_to_delete = [
  "Teste Manual",
  "Test message from server simulation",
  "Test message from script"
]

query = from m in EventManager.Schemas.ChatMessage,
        where: m.message in ^messages_to_delete

{count, _} = EventManager.Repo.delete_all(query)
IO.puts("Deleted #{count} test messages.")
