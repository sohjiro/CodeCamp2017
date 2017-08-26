defmodule Artesanos2017.Core.XMLParser do

  def find_line_by_name(name) do
    xml = File.read!("/Users/sohjiro/artesanos2017/lib/artesanos2017/data/Metro_CDMX.kml")
    doc = Exml.parse xml

    IO.inspect doc

    Exml.get(doc, "//Placemark/@name")
    |> IO.inspect
  end

end
