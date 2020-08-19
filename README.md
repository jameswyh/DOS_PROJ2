# Gossip_Simulator

## Group members
Yihui Wang UFID# 8316-4355   
Wei Zhao UFID# 9144-4835

## Problem definition
Gossip type algorithms can be used both for group communication and for aggregate computation. The goal of this project is to determine the convergence of such algorithms through a simulator based on actors written in Elixir. Since actors in Elixir are fully asynchronous, the particular type of Gossip implemented is the so-called Asynchronous Gossip.<br/>
### Gossip Algorithm for information propagation: 
The Gossip algorithm involves the following:<br/>
- Starting: A participant(actor) it told/sent a rumor(fact) by the main process
- Step: Each actor selects a random neighbor and tells it the rumor
- Termination: Each actor keeps track of rumors and how many times it has
heard the rumor. It stops transmitting once it has heard the rumor 10 times (10 is arbitrary, you can play with other numbers or other stopping criteria).<br/>
### Push-Sum algorithm for sum computation:
- State: Each actor Ai maintains two quantities: s and w. Initially, s = xi = i (that is actor number i has value i, play with other distribution if you so desire) and w=1.
- Starting: Ask one of the actors to start from the main process.
- Receive: Messages sent and received are pairs of the form (s, w). Upon receive, an actor should add received pair to its own corresponding values.
Upon receive, each actor selects a random neighbor and sends it a message.
- Send: When sending a message to another actor, half of s and w is kept by
the sending actor and half is placed in the message.
- Sum estimate: At any given moment of time, the sum estimate is s/w where
s and w are the current values of an actor.
- Termination: If an actor ratio s/w did not change more than 10-10 in 3
consecutive rounds the actor terminates. WARNING: the values s and w independently never converge, only the ratio does.
### Topologies: 
The actual network topology plays a critical role in the dissemination speed of Gossip protocols. As part of this project you have to experiment with various topologies. The topology determines who is considered a neighbor in the above algorithms.
- Full Network: Every actor is a neighbor of all other actors. That is, every actor can talk directly to any other actor.
- Line: Actors are arranged in a line. Each actor has only 2 neighbors (one left and one right, unless you are the first or last actor).
- Random 2D Grid: Actors are randomly position at x, y coordinates on a [0- 1.0] x [0-1.0] square. Two actors are connected if they are within .1 distance to other actors.
- 3D torus Grid: Actors form a 3D grid. The actors can only talk to the grid neighbors. And, the actors on outer surface are connected to other actors on opposite side, such that degree of each actor is 6.
- Honeycomb: Actors are arranged in form of hexagons. Two actors are connected if they are connected to each other. Each actor has maximum degree 3.
- Honeycomb with a random neighbor: Actors are arranged in form of hexagons (Similar to Honeycomb). The only difference is that every node has one extra connection to a random node in the entire network.
## Steps to run code
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

## What is working

We are able to implement all algorithms with all topologies with diferent number of nodes.
For algorithm, we implement 2 different algorithms, include Gossip Algorithm and Push Sum Alogorithm.
For topology, we implement 6 different Topologies, include Full Network, Line, rand2D, torus3D, honeycomb, randhoneycomb.

## How time is measured

We record the start time point with Elixir's build in function "System.monotonic_time(:millisecond)". The time recorded is in millisecond unit. After all nodes/actors terminated, we use the same function to record the finish time point so that the difference between the finish time point and start time ponint represent the time spent to run the algorithm with given number of nodes/actors and topology.

## What is the largest network we managed to deal with for each type of topology and algorithm

Topology         |Gossip   |Push Sum
Full             |5000     |9000
Line             |20000    |20000
Random 2D        |2000     |2000
3D Torus         |1500     |1500
Honeycomb        |16900    |14400
Random Honeycomb |16900    |14400  


