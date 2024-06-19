# Francisco Urquizo

defmodule Highlighter do
  require HighlighterBase

  def process_directory(directory) do
    # Define the CSS file name and its path within the directory
    css_file = "out_fd.css"
    css_path = Path.join(directory, css_file)

    # Copy the CSS file to the directory if it does not exist
    unless File.exists?(css_path) do
      File.cp("out_fd.css", css_path)
    end

    directory
    |> File.ls!()
    |> Enum.filter(&String.ends_with?(&1, ".py"))
    |> Enum.map(fn file ->
      full_path = Path.join(directory, file)
      HighlighterBase.get_info(full_path, css_file)
    end)
  end
end

# Get the directory path from command line arguments
args = System.argv()

# Ensure a directory argument is provided
if length(args) == 0 do
  IO.puts("Usage: elixir proyecto2_secuencial.exs <directory_path>")
  System.halt(1)
end

directory = hd(args)

# Measure the execution time of the process_directory function
{time, _result} = :timer.tc(fn -> Highlighter.process_directory(directory) end)

IO.puts("Execution time: #{time} microseconds")
