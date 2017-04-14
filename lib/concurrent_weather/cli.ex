defmodule ConcurrentWeather.CLI do

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
                                      alias: [h: :help])

    case parse do
      {[help: true], _, _} ->
        :help

      {_, {cities}, _} ->
        {cities}

      _ ->
        :help
    end
  end

  def process(:help) do
    IO.puts "provide a list of cities."
  end

  def process({cities}) do
    cities
  end

end