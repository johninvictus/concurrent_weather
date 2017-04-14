defmodule ConcurrentWeather.Coordinator do

  @moduledoc """
  The main task of this module is to maintain state and receive messages from workers
  """

    def loop(state \\[], expected_count) do
      receive do
        {:ok, response} ->
          new_state = [response|state]

          if expected_count == Enum.count(new_state) do
            send self(), :exit
          end
          loop(new_state, expected_count)

        :exit ->
          results =
            state
            |> Enum.sort
            |> Enum.join(", ")

          IO.puts results

          _->
          loop(state, expected_count)
      end
    end

end
