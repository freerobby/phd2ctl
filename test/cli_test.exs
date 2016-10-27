defmodule CLITest do
  use ExUnit.Case
  doctest Phd2ctrl.CLI

  import Phd2ctrl.CLI, only: [parse_args: 1]

  test "-h or --help returns :help" do
    assert parse_args(["-h"]) == :help
    assert parse_args(["--help"]) == :help
  end

  test "no arguments returns :help" do
    assert parse_args([]) == :help
  end

  test "-h and --help with extraneous values still returns :help" do
    assert parse_args(["-h", "23"]) == :help
    assert parse_args(["--help", "hi mom!"]) == :help
  end

  test "one value returned when one given" do
    assert parse_args(["pause"]) == { "pause" }
  end

  test ":help is returned when more than one value is given" do
    assert parse_args([27, 23]) == :help
  end

  test ":help is returned when an unhandled option is given" do
    assert parse_args(["--foo"]) == :help
  end
end
