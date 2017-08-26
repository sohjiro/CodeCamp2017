defmodule Artesanos2017.Core.XMLParserTest do
  use ExUnit.Case, async: true
  alias Artesanos2017.Core.{XMLParser, SubwayLine, Station}

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
    assert (lines_map |> hd |> value_of(:name)) == "Línea 1"
    assert (lines_map |> hd |> value_of(:coordinates) |> length) == 20
  end

  test "should find all subway stations and coordinates" do
    subway_stations = XMLParser.subway_stations

    assert subway_stations
    assert length(subway_stations) == 162
    assert (subway_stations |> Enum.at(12)) == %Station{name: "Balderas", lines: ["Línea 1", "Línea 3"], coordinates: "-99.149074,19.42741,0"}
  end

  test "should return stations as a map" do
    map_stations = XMLParser.subway_stations_map

    assert map_stations
    assert (map_stations |> Map.keys |> length ) == 162
    assert (map_stations |> Map.get("-99.149074,19.42741,0")) == %Station{name: "Balderas", lines: ["Línea 1", "Línea 3"], coordinates: "-99.149074,19.42741,0"}
  end

  test "should remove estación terminal" do
    subway_stations = XMLParser.subway_stations

    assert subway_stations
    assert length(subway_stations) == 162
    assert (subway_stations |> Enum.at(13)) == %Station{name: "Barranca del Muerto", lines: ["Línea 7"], coordinates: "-99.189586,19.3607037,0"}
  end

  test "should handle descriptions with 'y'" do
    subway_stations = XMLParser.subway_stations

    assert subway_stations
    assert length(subway_stations) == 162
    assert (subway_stations |> Enum.at(25)) == %Station{name: "Chabacano", lines: ["Línea 2", "Línea 8", "Línea 9"], coordinates: "-99.1357434,19.4084883,0"}
  end


  defp value_of(%SubwayLine{} = data, prop) do
    Map.get(data, prop)
  end

end
