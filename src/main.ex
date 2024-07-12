defmodule Compression do
  @spec readFile() :: String
  defp readFile() do
    file = File.read("data/test.txt")
  end

  @spec readFile(String) :: String
  defp readFile(path) do
    file = File.read(path)
  end

  @spec saveFile(String)
  defp saveFile(content) do
    File.write("data/compressed_text.txt", content)
  end

  @spec saveFile(String, String)
  defp saveFile(path, content) do
    File.write(path, content)
  end

  @spec compress(String) :: String
  defp compress(content) do
    IO.puts("Yes")
    charList = content |> String.graphemes() |> Enum.reduce(%{}, fn char, acc -> 
      Map.put(acc, char, (acc[char] || 0) + 1)
    end) |> Enum.sort_by(fn {_k, v} -> v end)
    IO.inspect(charList)
    # Pick first two elements
    # put them into left and right
    # sum their frequency
    # if next element is less than that
    # put next element to right
  end

  defp encoding(tree) do
    tree
  end

  @spec run(String, String)
  def run(filePath, compressedPath) do
    %{size: size} = File.stat!(filePath)
    IO.puts("#{size} bites")
    {status, file} = readFile(filePath)
    compressedFile = compress(file)
    saveFile(compressedPath, compressedFile)
    IO.puts("File compressed successfully.")
    # %{size: size} = File.stat!(compressedPath)
    # IO.puts("#{size} bites")
  end
end

Compression.run("data/text.txt", "data/compressed_text.txt")
