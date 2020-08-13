defmodule GossipNode do
  use GenServer

  def start_link(x, numOfNodes, topology, nodeMap) do
    GenServer.start_link(__MODULE__, {x, numOfNodes, topology, nodeMap}, name: GossipDriver.intToAtom(x))
    #IO.inspect {:ok, pid}
  end

  def init({x, numOfNodes, topology, nodeMap}) do
    #IO.inspect x
    #IO.inspect topology

    neighborList =
      case topology do
        "full" ->
          GetNeighbor.full(x, numOfNodes)
        "line" ->
          GetNeighbor.line(x, numOfNodes)
        "rand2D" ->
          GetNeighbor.rand2D(x, numOfNodes, nodeMap)
        "3Dtorus" ->
          GetNeighbor.torus3D(x, numOfNodes)
        "honeycomb" ->
          GetNeighbor.honeycomb(x, numOfNodes)
        "randhoneycomb" ->
          GetNeighbor.randhoneycomb(x, numOfNodes)
        end
        #IO.inspect neighborList
        count = 0
    {:ok, {x, neighborList, count}}
  end

  def handle_cast(:next, {nodeId, neighborList, count}) do
    if(count >= 10) do
      #IO.puts "#{nodeId} is end"
      GossipDriver.finish(nodeId)
      Enum.each(neighborList, fn neighbour -> GenServer.cast(GossipDriver.intToAtom(neighbour), :next) end)
    end

    if(count <= 9) do
      #IO.puts "Node #{nodeId} counts #{count}"
      nextNode = Enum.random(neighborList)
      GenServer.cast(GossipDriver.intToAtom(nextNode), :next)
      #Enum.each(neighborList, fn neighbour -> GenServer.cast(GossipDriver.intToAtom(neighbour), :next) end)
    end

    #if(count > 10) do
    #Enum.each(neighborList, fn neighbour -> GenServer.cast(GossipDriver.intToAtom(neighbour), :next) end)
    #end

    {:noreply, {nodeId, neighborList, count + 1}}
  end

end
