defmodule Artesanos2017.Core.XMLParser do
  @metro_path "/Users/sohjiro/artesanos2017/lib/artesanos2017/data/Metro_CDMX.kml"

  alias Artesanos2017.Core.{SubwayLine, Station}

  defp find_path(path) do
    @metro_path
    |> File.read!
    |> Exml.parse
    |> Exml.get(path)
  end

  def find_line_by_name(name) do
    "//Placemark/name[text()='#{name}']/../LineString/coordinates"
    |> find_path
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> Enum.filter(&(&1 != ""))
  end

  def find_all_line_names do
    find_path("//Folder/name[text()='Líneas de Metro']/../Placemark/name")
  end

  def get_lines_map do
    find_all_line_names()
    |> Enum.map(fn(name) ->
      %SubwayLine{name: name, coordinates: find_line_by_name(name)}
    end)
  end

  defp parse_lines_from_description(description) do
    description
    |> String.split(".")
    |> hd
    |> String.split(", ")
    |> Enum.map(&complete_text/1)
  end

  def subway_stations do
    "//Folder/name[text()='Estaciones de Metro']/../Placemark"
    |> find_path
    |> Enum.map(fn([_, name, _, description, _, _, _, [_, coordinates | _rest], _]) ->
      %Station{
        name: name,
        coordinates: String.trim(coordinates),
        lines: parse_lines_from_description(description)
      }
    end)
  end

  def subway_stations_map do
    subway_stations
    |> Enum.reduce(%{}, fn(station, acc) ->
      Map.put(acc, station.coordinates, station)
    end)
  end

  defp complete_text("Línea " <> _n = text), do: text
  defp complete_text(n), do: "Línea #{n}"

end
