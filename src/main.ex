defmodule Compression do
  alias DialyxirVendored.Warnings.NoReturn
  @spec readFile() :: String
  defp readFile() do
    file = File.read("data/test.txt")
  end

  @spec readFile(String) :: String
  defp readFile(path) do
    file = File.read(path)
  end

  @spec saveFile(String) :: NoReturn
  defp saveFile(content) do
    File.write("data/compressed_text.txt", content)
  end

  @spec saveFile(String, String) :: NoReturn
  defp saveFile(path, content) do
    File.write(path, content)
  end

  @spec compress(String) :: String
  defp compress(content) do
    IO.puts("Stage 1")
    charList = content |> String.graphemes() |> Enum.reduce(%{}, fn char, acc -> 
      Map.put(acc, char, (acc[char] || 0) + 1)
    end) |> Enum.sort_by(fn {_k, v} -> v end)
    IO.inspect(charList)
    # Pick first two elements
    # put them into left and right
    # sum their frequency
    # if next element is less than that
    # put next element to right
    [{char1, occurance1}, {char2, occurance2} | rest] = charList
    [left, right, sum] = if occurance1 <= occurance2 do [char1, char2, occurance1 + occurance2] else [char2, char1, occurance1 + occurance2] end
    compress(left, right, sum, rest)
  end

  @spec compress(String, String, Number, Map) :: String
  defp compress(leftNode, rightNode, sumPrev, charList) do
    IO.puts("Stage 2")
    IO.inspect(leftNode)
    IO.inspect(rightNode)
    IO.inspect(sumPrev)
    IO.inspect(charList)
    [{char, occurance} | rest] = charList
    [left, right, sum] = if occurance >= sumPrev do [char, [leftNode, rightNode], occurance + sumPrev] else [[leftNode, rightNode], char, occurance + sumPrev] end
    compress(left, right, sum, rest)
  end

  @spec compress(String, String, Number, Empty) :: String
  defp compress(leftNode, rightNode, sumPrev, _) do
    # This function should now go through the list
    # and assign binary values
    # to each of the leafs
    IO.puts("Stage 3, final round")
    IO.inspect(leftNode)
    IO.inspect(rightNode)
    IO.inspect(sumPrev)
  end

  defp encoding(tree) do
    tree
  end

  @spec run(String, String) :: NoReturn
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
