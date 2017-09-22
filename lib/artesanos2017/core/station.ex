defmodule Artesanos2017.Core.Station do
  defstruct name: "", coordinates: "", lines: [], neighbours: []

  alias Artesanos2017.Core.XMLParser

  def find_neighbours_for_station(map_stations, line_maps, station_coord) do
    station = Map.get(map_stations, station_coord)

    neighbours = Enum.map(station.lines, fn(line_for_station) ->
      line = line_maps |> Map.get(line_for_station)
      find_neighbours(station_coord, line.coordinates)
    end)
    |> List.flatten

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

  def parse_into_dijkstra_graph(stations, line_maps) do
    stations
    |> Map.keys
    |> Enum.reduce(%{}, fn(k, acc) ->
      station = find_neighbours_for_station(stations, line_maps, k)
      neighbours = Enum.map(station.neighbours, fn(neighbour) -> {1, neighbour} end)
      Map.put(acc, k, neighbours)
    end)
  end

end
