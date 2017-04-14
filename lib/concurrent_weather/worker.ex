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
            send(sender_pid, "city: #{temp}")

          {:error, reason} ->
            Logger.error "Error occured getting temparature of:: #{city} reason:: #{reason}"
            send sender_pid, "not found"
        end
      end
  end

end
