defmodule Artesanos2017.Core.StationTest do
  use ExUnit.Case, async: true
  alias Artesanos2017.Core.{Station, XMLParser}

  test "should return neighbours" do
    stations = XMLParser.subway_stations_map()
    line_maps = XMLParser.get_lines_map()

    station_coord = "-99.0056777,19.3647171,0"
    station = Station.find_neighbours_for_station(stations, line_maps, station_coord)
    assert station
    assert length(station.neighbours) == 2

    station_coord = "-99.1194999,19.4953987,0"
    station = Station.find_neighbours_for_station(stations, line_maps, station_coord)
    assert station
    assert length(station.neighbours) == 1
    assert station.neighbours == ["-99.1209751134766,19.4906856228133,0"]

    station_coord = "-99.214788,19.4634108,0"
    station = Station.find_neighbours_for_station(stations, line_maps, station_coord)
    assert station
    assert length(station.neighbours) == 1

    station_coord = "-99.149074,19.42741,0"
    station = Station.find_neighbours_for_station(stations, line_maps, station_coord)
    assert station
    assert length(station.neighbours) == 4
    assert station.neighbours == ["-99.154653,19.425867,0", "-99.1422343,19.4267827,0", "-99.1505706,19.4195583,0", "-99.1478777,19.4332682,0"]

    station_coord = "-99.1552055,19.4066618,0"
    station = Station.find_neighbours_for_station(stations, line_maps, station_coord)
    assert station
    assert length(station.neighbours) == 4
  end

  test "should conver stations map into a Dijkstra's graph" do
    stations = XMLParser.subway_stations_map()
    line_maps = XMLParser.get_lines_map()
    graph = Station.parse_into_dijkstra_graph(stations, line_maps)

    assert graph
    assert Map.get(graph, "-99.149074,19.42741,0") == [
      {1, "-99.154653,19.425867,0"},
      {1, "-99.1422343,19.4267827,0"},
      {1, "-99.1505706,19.4195583,0"},
      {1, "-99.1478777,19.4332682,0"}]
  end

  test "should return path for two given nodes" do
    stations = XMLParser.subway_stations_map()
    line_maps = XMLParser.get_lines_map()
    graph = Station.parse_into_dijkstra_graph(stations, line_maps)
    result = Artesanos2017.Core.Dijkstra.dijkstrafy(graph, "-99.2005488,19.3982501,0", "-99.187097,19.4031605,0")

    assert result
    assert {1, ["-99.2005488,19.3982501,0", "-99.187097,19.4031605,0"]} == result

    result = Artesanos2017.Core.Dijkstra.dijkstrafy(graph, "-99.214788,19.4634108,0", "-99.2000628,19.5046121,0")
    assert result
    assert {6, ["-99.214788,19.4634108,0", "-99.203158,19.4587829,0", "-99.1870825,19.4586984,0", "-99.1905999,19.4700922,0", "-99.19016,19.479226,0", "-99.1948807,19.4905036,0", "-99.2000628,19.5046121,0"]} == result
  end


end
