args = System.argv()
numOfNodes = String.to_integer(Enum.at(args, 0))
topology = Enum.at(args, 1)
algorithm = Enum.at(args, 2)
start_time = System.monotonic_time(:millisecond)

Proj2.main(numOfNodes, topology, algorithm, start_time)
