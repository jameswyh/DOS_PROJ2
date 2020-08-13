defmodule PushSumNode do
  use GenServer

  # Client
  def start_link(x, numOfNodes, topology, nodeMap) do
      GenServer.start_link(__MODULE__, {x, numOfNodes, topology, nodeMap}, name: PushSumDriver.intToAtom(x))
      #IO.inspect {:ok, pid}
  end

  # receive value from previous actor
  def receiveMessage(pid, s, w) do
    GenServer.cast(pid, {:next, s, w})
  end

  # Server
  # initial state, s=i, w=1, s/w = i/1,
  def init({x, numOfNodes, topology, nodeMap}) do
    # IO.puts("in worker")
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

    # IO.inspect neighborList
    {:ok, {x, neighborList, x, 1, x / 1, 0}}
  end

  def handle_cast(
        {:next, sReceived, wReceived},
        {nodeId, neighborList, sExisting, wExisting, sumEst, numChanges}
      ) do
    # Upon receive, an actor should add received pair to its own corresponding values.
    sNew = sExisting + sReceived
    wNew = wExisting + wReceived
    #IO.puts("id #{nodeId} sexisting #{sExisting} + wExisting #{wExisting}")

    # When sending a message to another actor, half of s and w is kept by the sending actor and half is placed in the message.
    sToBeSent = sNew / 2
    wToBeSent = wNew / 2

    # At any given moment of time, the sum estimate is s/w where s and w are the current values of an actor.
    newSumEst =
    if wToBeSent != 0 do
      sToBeSent / wToBeSent
    else
      0
    end

    # If an actor ratio s/w did not change more than 10^-10 in 3 consecutive rounds the actor terminates.
    swDifference = abs(newSumEst - sumEst)
    #IO.puts "Node #{nodeId} difference is #{swDifference}"

    #IO.inspect newSumEst

    numChanges =
      if(swDifference < :math.pow(10, -10) && numChanges == 2) do
        PushSumDriver.finish(nodeId)
        Enum.each(neighborList, fn neighbour ->
          receiveMessage(PushSumDriver.intToAtom(neighbour), 0, 0)
        end)
        numChanges
      else
        nextNode = Enum.random(neighborList)
        GenServer.cast(PushSumDriver.intToAtom(nextNode), {:next, sNew, wNew})

        if(swDifference < :math.pow(10, -10)) do
          numChanges + 1
        else
          0
        end
      end

    {:noreply, {nodeId, neighborList, sToBeSent, wToBeSent, newSumEst, numChanges}}
  end
end
