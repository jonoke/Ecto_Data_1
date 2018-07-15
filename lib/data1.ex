defmodule Data1 do
  @moduledoc """
  Documentation for Data1.
  """

  import Ecto.Schema
  import Ecto.Query
  import Ecto.Changeset

  alias Data1.{Cmpny}

  def string_to_date(aDate) do
    aDate = case aDate do
      "?" -> "01/01/00"
      _ -> aDate
    end
    [day, month, year] = String.split(aDate, "/")
    [day, month, year] = [String.to_integer(day), String.to_integer(month), String.to_integer(year)]
    year = case year < 100 do
        true -> year + 2000
        false -> year
    end
    {:ok, aDate} = Date.new(year, month, day)
    aDate
  end
  def csv_stream(file_name, prune_function) do
    file_name
    |> File.stream!()
    |> CSV.decode(headers: :true)
    |> Enum.map(prune_function)
  end

  def update_control(item) do
    IO.puts "key is #{item.id} : #{inspect item.starts_on}"
    change =
      %Cmpny{id: item.id}
      |> cast(item, [:starts_on, :ends_on ])
    Data1.Repo.update(change)
  end
  def control({:ok,item}) do
    %{
      id: item["co-id"],
      starts_on: string_to_date(item["start-date"]),
      ends_on: string_to_date(item["end-date"])
    }
  end
  def load_control() do
    data = csv_stream("../sycontrol.csv", &control/1)
    Enum.each(data, &update_control/1)
  end

  def upd_cmpny(item) do
    Data1.Repo.insert(item)
  end
  def add_cmpny(item) do
    Data1.Repo.insert(item)
  end
  def cmpny({:ok,item}) do
    %Cmpny{
      id: item["co-id"],
      name: item["name"],
    }
  end
  def load_company() do
    data = csv_stream("../sycompany.csv", &cmpny/1)
    Enum.each(data, &add_cmpny/1)
#TestDB.Repo.insert_all("company", data)
  end
end
