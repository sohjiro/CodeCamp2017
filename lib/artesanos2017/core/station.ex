defmodule Artesanos2017.Core.Station do
  defstruct name: "", coordinates: "", lines: [], neighbours: []

  alias Artesanos2017.Core.XMLParser

  def find_neighbours_for_station(station_coord) do
    line_maps = XMLParser.get_lines_map()
    |> Enum.reduce(%{}, fn(line, acc) ->
      Map.put(acc, line.name, line)
    end)

    map_stations = XMLParser.subway_stations_map()

    station = Map.get(map_stations, station_coord)
    [line_for_station] = station.lines

    line = line_maps |> Map.get(line_for_station)
    neighbours = find_neighbours(station_coord, line.coordinates)
    %{station | neighbours: neighbours}
  end

  defp find_neighbours(station_coord, coordinates) do
    index = Enum.find_index(coordinates, fn(coordinate) ->
      station_coord == coordinate
    end)

    total = length(coordinates) - 1

    case index do
      0 -> [Enum.at(coordinates, 1)]
      ^total -> [Enum.at(coordinates, index - 1)]
      _ ->
        [Enum.at(coordinates, index - 1), Enum.at(coordinates, index + 1)]
    end
  end

end
