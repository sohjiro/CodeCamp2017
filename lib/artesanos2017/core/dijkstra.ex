defmodule Artesanos2017.Core.Dijkstra do

  def dijkstrafy(graph, start, ended) when is_map(graph) do
    shortest_path(graph, [{0, [start]}], ended, %{})
  end

  defp shortest_path(_graph, [], _end, _visited) do
    {0, []}
  end

  defp shortest_path(_graph, [{cost, [ended | _] = path} | _ ], ended, _visited) do
    {cost, :lists.reverse(path)}
  end

  defp shortest_path(graph, [{cost, [node | _ ] = path} | routes], ended, visited) do
    new_routes = for {new_cost, new_node} <- Map.get(graph, node), (not Map.get(visited, new_node, false)) do
      {cost + new_cost, [new_node | path]}
    end
    visited = Map.put(visited, node, true)
    shortest_path(graph, :lists.sort(new_routes ++ routes), ended, visited)
  end
end
