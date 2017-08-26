defmodule Artesanos2017.Core.XMLParserTest do
  use ExUnit.Case, async: true
  alias Artesanos2017.Core.XMLParser

  test "should return the complete coordinates for a subway line" do
    coordinates = XMLParser.find_line_by_name("Línea 1")

    assert coordinates
    assert length(coordinates) == 20
  end

end
