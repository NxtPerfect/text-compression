defmodule Compression do
  defp readFile() do
    file = File.read("data/test.txt")
  end
  defp readFile(path) do
    file = File.read(path)
  end
  defp saveFile(content) do
    File.write("data/compressed_text.txt", content)
  end
  defp saveFile(path, content) do
    File.write(path, content)
  end
  defp compress(content) do
    IO.puts("Yes")
    charList = content |> String.graphemes() |> Enum.reduce(%{}, fn char, acc -> 
      Map.put(acc, char, (acc[char] || 0) + 1)
    end) |> Enum.sort_by(fn {_k, v} -> v end, :desc)
  end
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
