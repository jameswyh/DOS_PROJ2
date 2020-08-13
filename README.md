# Proj2

### Steps to run code
1. Open the Terminal and go to the directory of the project.
2. Type in the following command:
```
./proj2 numNodes topology algorithm
```
Where numNodes is the number of actors involved.
Options for toppology: full, line, rand2D, torus3D, honeycomb, randhoneycomb
Options for algorithm: gossip, pushsum

Example
```
./proj2 100 line gossip
```
This command to implement gossip algorithm with 100 nodes using "line" topology.
3. The result (Time spend to finish the algorithm) will be shown on the screen.

## 1. Group members
Yihui Wang UFID# 8316-4355   
Wei Zhao UFID# 9144-4835

## 2. What is working

We are able to implement all algorithms with all topologies with diferent number of nodes.
For algorithm, we implement 2 different algorithms, include Gossip Algorithm and Push Sum Alogorithm.
For topology, we implement 6 different Topologies, include Full Network, Line, rand2D, torus3D, honeycomb, randhoneycomb.

## 3. How time is measured

We record the start time point with Elixir's build in function "System.monotonic_time(:millisecond)". The time recorded is in millisecond unit. After all nodes/actors terminated, we use the same function to record the finish time point so that the difference between the finish time point and start time ponint represent the time spent to run the algorithm with given number of nodes/actors and topology.

## 4. What is the largest network we managed to deal with for each type of topology and algorithm

Topology         |Gossip   |Push Sum
Full             |5000     |9000
Line             |20000    |20000
Random 2D        |2000     |2000
3D Torus         |1500     |1500
Honeycomb        |16900    |14400
Random Honeycomb |16900    |14400  


