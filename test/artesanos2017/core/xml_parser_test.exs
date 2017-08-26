defmodule Artesanos2017.Core.XMLParserTest do
  use ExUnit.Case, async: true
  alias Artesanos2017.Core.XMLParser

  test "should return the complete coordinates for a subway line" do
    coordinates = XMLParser.find_line_by_name("Línea 1")

    assert coordinates
    assert length(coordinates) == 20
  end

  test "should return all subway line names" do
    line_names = XMLParser.find_all_line_names

    assert line_names
    assert length(line_names) == 12
    assert line_names == ["Línea 1", "Línea 2", "Línea 3", "Línea 4", "Línea 5", "Línea 6", "Línea 7", "Línea 8", "Línea 9", "Línea A", "Línea B", "Línea 12"]
  end


  test "should return a map of lines with coordinates" do
    lines_map = XMLParser.get_lines_map
    assert lines_map
    assert length(lines_map) == 12
    assert (lines_map |> hd |> Map.get(:name)) == "Línea 1"
    assert (lines_map |> hd |> Map.get(:coordinates) |> length) == 20
  end
end
