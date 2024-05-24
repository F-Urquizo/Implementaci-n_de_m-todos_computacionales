# Francisco Urquizo Schnaas
#
# 18/05/24
# Syntax Highlighter for Python Programs

defmodule Highlighter do
  def get_info(in_filename) do
    # Construct the output file name
    regex = ~r/\.[^.]+$/
    file_name_without_ext = Regex.replace(regex, in_filename, "")
    out_filename = file_name_without_ext <> ".html"

    # Open the output file for writing
    {:ok, out_fd} = File.open(out_filename, [:write])

    # Write the HTML header
    IO.write(out_fd, "<html>\n<head>\n<title>File Content</title>\n<link rel=\"stylesheet\" href=\"out_fd.css\"></head>\n<body>\n<pre>\n")

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
        match = Regex.run(~r/#.*$/, line) ->
          length = String.length(hd(match))
          write_out(out_fd, hd(match), "comment")
          {_first_part, second_part} = String.split_at(line, length)
          filter_regex(second_part, out_fd)

        match = Regex.run(~r/^(""".*""")|('''.*''')/, line) ->
          length = String.length(hd(match))
          write_out(out_fd, hd(match), "multiline_comment")
          {_first_part, second_part} = String.split_at(line, length)
          filter_regex(second_part, out_fd)

        match = Regex.run(~r/^\s+/, line) ->
          length = String.length(hd(match))
          write_out(out_fd, hd(match), "space")
          {_first_part, second_part} = String.split_at(line, length)
          filter_regex(second_part, out_fd)

        match = Regex.run(~r/^\b(?:if|else|while|elif|for|def|return|is|not)\b/, line) ->
          length = String.length(hd(match))
          write_out(out_fd, hd(match), "reserved_word")
          {_first_part, second_part} = String.split_at(line, length)
          filter_regex(second_part, out_fd)

        match = Regex.run(~r/^\w+(?=\()/, line) ->
          length = String.length(hd(match))
          write_out(out_fd, hd(match), "function_name")
          {_first_part, second_part} = String.split_at(line, length)
          filter_regex(second_part, out_fd)

        match = Regex.run(~r/^[0-9]+(\.[0-9]+)?/, line) ->
          length = String.length(hd(match))
          write_out(out_fd, hd(match), "number")
          {_first_part, second_part} = String.split_at(line, length)
          filter_regex(second_part, out_fd)

        match = Regex.run(~r/^\b\w+\b/, line) ->
          length = String.length(hd(match))
          write_out(out_fd, hd(match), "variable")
          {_first_part, second_part} = String.split_at(line, length)
          filter_regex(second_part, out_fd)



        match = Regex.run(~r/^[\+\-\*\/=<>!]+/, line) ->
          length = String.length(hd(match))
          write_out(out_fd, hd(match), "operator")
          {_first_part, second_part} = String.split_at(line, length)
          filter_regex(second_part, out_fd)

        match = Regex.run(~r/^[{}[\]();,]/, line) ->
          length = String.length(hd(match))
          write_out(out_fd, hd(match), "symbol")
          {_first_part, second_part} = String.split_at(line, length)
          filter_regex(second_part, out_fd)

        match = Regex.run(~r/(['"])(?:(?=(\\?))\2.)*?\1/, line) ->
          length = String.length(hd(match))
          write_out(out_fd, hd(match), "string")
          {_first_part, second_part} = String.split_at(line, length)
          filter_regex(second_part, out_fd)


        true ->
          write_out(out_fd, line, "default")
      end
    end
  end

  defp write_out(out_fd, match, type) do
    IO.write(out_fd, "<span class=\"#{type}\">#{match}</span>")
  end
end

{:ok, new_file} = Highlighter.get_info("test.py")
IO.puts("Created HTML file: #{new_file}")
