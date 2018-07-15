defmodule Data1.Cmpny do
  use Ecto.Schema
  import Ecto.Changeset
  alias Data1.{Cmpny}

  @primary_key {:id, :string, []}
  schema "cmpny" do
    field(:name,      :string)
    field(:starts_on, :date)
    field(:ends_on,   :date)

    timestamps()
  end
end
