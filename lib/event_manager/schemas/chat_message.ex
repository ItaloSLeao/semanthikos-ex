defmodule EventManager.Schemas.ChatMessage do
  @moduledoc """
  ChatMessage schema for real-time event chat.
  Tracks messages and Q&A status.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "chat_messages" do
    field :message, :string
    field :sent_at, :utc_datetime
    field :is_question, :boolean, default: false
    field :is_answered, :boolean, default: false

    belongs_to :event, EventManager.Schemas.Event
    belongs_to :user, EventManager.Schemas.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(chat_message, attrs) do
    chat_message
    |> cast(attrs, [:message, :event_id, :user_id, :is_question, :is_answered])
    |> validate_required([:message, :event_id, :user_id])
    |> validate_length(:message, min: 1, max: 1000)
    |> default_sent_at()
    |> foreign_key_constraint(:event_id)
    |> foreign_key_constraint(:user_id)
  end

  defp default_sent_at(changeset) do
    if get_field(changeset, :sent_at) do
      changeset
    else
      put_change(changeset, :sent_at, DateTime.utc_now() |> DateTime.truncate(:second))
    end
  end

  @doc "Changeset for marking a question as answered"
  def answer_changeset(chat_message) do
    change(chat_message, is_answered: true)
  end
end
