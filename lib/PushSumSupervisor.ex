defmodule PushSumSupervisor do
  use Supervisor

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg)
  end

  def init({numOfNodes, topology}) do
    nodeMap = Enum.map(1..numOfNodes, fn(x) -> {Float.round(Enum.random(1..100)*0.01, 2), Float.round(Enum.random(1..100)*0.01, 2)} end )
    #IO.inspect nodeMap
    children = Enum.map(1..numOfNodes, fn(x) ->
      worker(PushSumNode, [x, numOfNodes, topology, nodeMap], [id: x, restart: :transient])
    end)
    supervise(children, strategy: :one_for_one)
  end
end
