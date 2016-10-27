defmodule Phd2ctrl.CLI do

  def main(argv) do
    argv
    |> parse_args
    |> process
  end

  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])
    case parse do
      {[help: true], _, _} -> :help
      {_, [command], _} -> {command}
      {_, _, _} -> :help
    end
  end

  def process(:help) do
    IO.puts """
    usage: phd2ctrl [--help, -h]      Show this help message
           phd2ctrl <command>         Send a command to PHD2, print response
"""
    System.halt 0
  end

  def process({command}) do
    {status, response} = Phd2ctrl.Phd2Communicator.send_command(command)
    case status do
      :ok ->
        IO.puts response
        System.halt 0
      :error ->
        case response do
          :invalid_command ->
            IO.puts "Invalid command: #{command}"
          _ ->
            IO.puts "Unknown error"
        end
        System.halt 1
    end
  end
end
