# Francisco Urquizo

defmodule HighlighterBase do
  def get_info(in_filename, css_path) do
    # Construct the output file name
    regex = ~r/\.[^.]+$/
    file_name_without_ext = Regex.replace(regex, in_filename, "")
    out_filename = file_name_without_ext <> ".html"

    # Open the output file for writing
    {:ok, out_fd} = File.open(out_filename, [:write])

    # Write the HTML header with the correct path to the CSS file
    IO.write(out_fd, "<html>\n<head>\n<title>File Content</title>\n<link rel=\"stylesheet\" href=\"#{css_path}\"></head>\n<body>\n<pre>\n")

    # Stream the input file and write each line to the output file
    in_filename
    |> File.stream!()
    |> Enum.each(fn line -> filter_regex(line, out_fd) end)

    # Write the HTML footer
    IO.write(out_fd, "</pre>\n</body>\n</html>")

    # Close the output file
    File.close(out_fd)

    {:ok, out_filename}
  end

  def filter_regex(line, out_fd) do
    if String.length(line) > 0 do
      cond do
        match = Regex.run(~r/^#.*$/, line) -> execute(match, "comment", line, out_fd)
        match = Regex.run(~r/^(""".*""")|('''.*''')/, line) -> execute(match, "multiline_comment", line, out_fd)
        match = Regex.run(~r/^\s+/, line) -> execute(match, "space", line, out_fd)
        match = Regex.run(~r/^\b(?:if|else|while|elif|for|def|return|is|not)\b/, line) -> execute(match, "reserved_word", line, out_fd)
        match = Regex.run(~r/^\w+(?=\()/, line) -> execute(match, "function_name", line, out_fd)
        match = Regex.run(~r/^[0-9]+(\.[0-9]+)?/, line) -> execute(match, "number", line, out_fd)
        match = Regex.run(~r/^\b\w+\b/, line) -> execute(match, "variable", line, out_fd)
        match = Regex.run(~r/^[\+\-\*\/=<>!]+/, line) -> execute(match, "operator", line, out_fd)
        match = Regex.run(~r/^[{}[\]();,]/, line) -> execute(match, "symbol", line, out_fd)
        match = Regex.run(~r/(['"])(?:(?=(\\?))\2.)*?\1/, line) -> execute(match, "string", line, out_fd)
        true -> write_out(out_fd, line, "default")
      end
    end
  end

  def execute(match, type, line, out_fd) do
    length = String.length(hd(match))
    write_out(out_fd, hd(match), type)
    {_first_part, second_part} = String.split_at(line, length)
    filter_regex(second_part, out_fd)
  end

  defp write_out(out_fd, match, type) do
    IO.write(out_fd, "<span class=\"#{type}\">#{match}</span>")
  end
end