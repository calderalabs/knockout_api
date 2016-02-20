defmodule Parallel do
  @timeout_in_ms Application.get_env(:knockout_api, :api_timeout_in_ms)

  def map(list, function) do
    list
      |> Enum.map(fn (elem) -> Task.async(fn -> function.(elem) end) end)
      |> Enum.map(fn (task) -> Task.await(task, @timeout_in_ms) end)
  end
end
