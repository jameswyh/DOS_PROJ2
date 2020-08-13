defmodule PushSumDriver do
  use GenServer

  def start_link(args) do
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  def init({numOfNodes, topology, startTime}) do
    IO.puts("PushSumDriver start")
    IO.inspect({numOfNodes, topology, startTime})

    PushSumSupervisor.start_link({numOfNodes, topology})

    PushSumNode.receiveMessage(intToAtom(1), 0, 0)
    # GenServer.cast(intToAtom(1), {:next, 1.0, 1.0})
    {:ok, {numOfNodes, topology, startTime}}
  end

  def finish(nodeId) do
    #IO.inspect(nodeId)
    GenServer.cast(__MODULE__, {:finish, nodeId})
  end

  def handle_cast({:finish, nodeId}, {nodeCount, topology, startTime}) do
    #IO.puts("node#{nodeId} is end")
    #IO.puts("nodeCount is #{nodeCount}")

    if nodeCount <= 1 do
      endTime = System.monotonic_time(:millisecond)
      timeSpan = endTime - startTime
      IO.puts("PushSum Time taken is #{timeSpan}")
      System.halt(0)
    end

    {:noreply, {nodeCount - 1, topology, startTime}}
  end

  def intToAtom(integer) do
    integer |> Integer.to_string() |> String.to_atom()
  end
end
