defmodule ConcurrentWeather.Worker do

  alias ConcurrentWeather.Weather
  require Logger

  @moduledoc """
  This will be responsible for receiving messages and sending messages into the main thread.
  """
  def loop do
    receive do
      {sender_pid, city} ->
        response =  Weather.temperature_of(city)

        case response do
          {:ok, temp} ->
            send sender_pid, {:ok, "#{city} : #{temp}"}
        
          {:error, _reason} ->
            send sender_pid, {:ok, "#{city} not found"}
        end
      end
  end

end
