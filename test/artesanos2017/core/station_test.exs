defmodule Artesanos2017.Core.StationTest do
  use ExUnit.Case, async: true
  alias Artesanos2017.Core.Station

  test "should return neighbours" do
    station_coord = "-99.0056777,19.3647171,0"
    station = Station.find_neighbours_for_station(station_coord)
    assert station
    assert length(station.neighbours) == 2

    station_coord = "-99.1194999,19.4953987,0"
    station = Station.find_neighbours_for_station(station_coord)
    assert station
    assert length(station.neighbours) == 1
    assert station.neighbours == ["-99.1209751134766,19.4906856228133,0"]

    station_coord = "-99.214788,19.4634108,0"
    station = Station.find_neighbours_for_station(station_coord)
    assert station
    assert length(station.neighbours) == 1
  end

end
