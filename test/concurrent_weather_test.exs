defmodule ConcurrentWeatherTest do
  use ExUnit.Case
  import  ConcurrentWeather.CLI, only: [parse_argv: 1]

  test "help will be returned if provided with -h or --help" do
      assert parse_argv(["-h", "anything"]) == :help
      assert parse_argv(["--help", "anything"]) == :help
  end

  test "nothing valid given" do
    assert parse_argv(["value"]) == :help
  end

  test "provide a list of cities" do
    assert parse_argv([["Nairobi", "Kisumu","Thika"]]) == {["Nairobi", "Kisumu","Thika"]}
  end
end
