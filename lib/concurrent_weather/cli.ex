defmodule ConcurrentWeather.CLI do
  require Logger
  @moduledoc """
  This module will interact with the command line.
  """

  @doc """
  Module entry point.This function will receive a list of commands from the command line
  """
  def main(argv) do
    argv
    |> parse_argv
    |> process
  end


  @doc """
  match the arguments
  """
  def parse_argv(argv) do
    parse = OptionParser.parse(argv, switches: [help: :boolean],
                  aliases: [h: :help])

    parse
    |> parse
  end

  def parse({[help: true], _, _}), do: :help

  def parse({_, cities, _}) do
    {cities}
  end

  def parse(_), do: :help

  def process(:help) do
    IO.puts "provide a list of cities."
  end

  def process({cities}) do

    condinator = spawn(ConcurrentWeather.Coordinator, :loop, [[], Enum.count(cities)])
    cities
    |> Enum.each(fn city ->
        pid = spawn(ConcurrentWeather.Worker, :loop, [])
       send pid, {condinator, city}
     end)

     # receive the main
     receive do
       {:ok, results} ->
         IO.puts results

       after 5000 ->
          IO.puts "time out"
     end
  end
end
