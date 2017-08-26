defmodule Artesanos2017.Core.XMLParser do
  @metro_path "/Users/sohjiro/artesanos2017/lib/artesanos2017/data/Metro_CDMX.kml"

  def find_line_by_name(name) do
    @metro_path
    |> File.read!
    |> Exml.parse
    |> Exml.get("//Placemark/name[text()='#{name}']/../LineString/coordinates")
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> Enum.filter(&(&1 != ""))
  end

end
