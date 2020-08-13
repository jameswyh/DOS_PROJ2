defmodule Proj2 do

    def main(args) do

      numOfNodes = String.to_integer(Enum.at(args, 0))
      topology = Enum.at(args, 1)
      algorithm = Enum.at(args, 2)
      start_time = System.monotonic_time(:millisecond)

      IO.inspect numOfNodes
      IO.inspect topology
      IO.inspect algorithm
      IO.inspect start_time

      if algorithm == "gossip" do
        GossipDriver.start_link({numOfNodes, topology, start_time})
      else
        PushSumDriver.start_link({numOfNodes, topology, start_time})
      end

      :timer.sleep(:infinity)

    end


end
