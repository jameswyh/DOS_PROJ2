defmodule GetNeighbor do

  def full(nodeId,numOfNodes) do
    neighbor = 1..numOfNodes
    neighbor
    |> Enum.filter(fn(value) -> value != nodeId end)
    |> Enum.map(fn(filtered_value) -> filtered_value * 1 end)
  end

  def line(nodeId,numOfNodes) do
      neighbor =
        cond do
          nodeId == 1 -> [2]
          nodeId == numOfNodes -> [numOfNodes - 1]
          nodeId > 1 and nodeId < numOfNodes -> [nodeId - 1, nodeId + 1]
        end
        neighbor
    end

  def getrand2D(nodeId, numOfNodes, nodeMap) do
    range = 1..numOfNodes
    range
    |> Enum.filter(fn n ->
      {x1, y1} = elem(List.to_tuple(nodeMap), nodeId - 1)
      {x2, y2} = elem(List.to_tuple(nodeMap), n - 1)
      d = :math.sqrt( :math.pow((x2-x1),2) + :math.pow((y2-y1),2))
      d <= 0.1
    end)
  end

  def rand2D(nodeId, numOfNodes, nodeMap) do
    neighbor = getrand2D(nodeId, numOfNodes, nodeMap)
    #IO.inspect neighbor
    Enum.filter(neighbor, fn x -> x != nodeId end)
  end


  def torus3D(nodeId, numOfNodes) do
    row = round(:math.pow(numOfNodes, 1 / 3))
    col = row * row

    #IO.puts " nodeId is #{nodeId}, row is #{row}, and col is #{col}"

    neighborList = cond do
      nodeId == 1 ->
        #IO.puts "a"
        [nodeId + (row - 1) * row, nodeId + row, nodeId + (row - 1), nodeId + 1, nodeId + (row - 1) * col, nodeId + col]
      nodeId == row ->
        #IO.puts "b"
        [nodeId + (row - 1) * row, nodeId + row, nodeId - 1, nodeId - (row - 1) , nodeId + (row - 1) * col, nodeId + col]
      nodeId == col - (row - 1) ->
        #IO.puts "c"
        [nodeId - row, nodeId - (row - 1) * row, nodeId + (row - 1), nodeId + 1, nodeId + (row - 1) * col, nodeId + col]
      nodeId == col ->
        #IO.puts "d "
        [nodeId - row, nodeId - (row - 1) * row, nodeId - 1, nodeId - (row - 1), nodeId + (row - 1) * col, nodeId + col]
      nodeId == col * 2 + 1 ->
        #IO.puts "e"
        [nodeId + (row - 1) * row, nodeId + row, nodeId + (row - 1), nodeId + 1, nodeId - col, nodeId - (row - 1) * col]
      nodeId == col * 2 + row ->
        #IO.puts "f"
        [nodeId + (row - 1) * row, nodeId + row, nodeId - 1, nodeId - (row - 1), nodeId - col, nodeId - (row - 1) * col]
      nodeId == col * 3 - (row - 1) ->
        #IO.puts "g"
        [nodeId - row, nodeId - (row - 1) * row, nodeId + (row - 1), nodeId + 1, nodeId - col, nodeId - (row - 1) * col]
      nodeId == col * 3 ->
        #IO.puts "h"
        [nodeId - row, nodeId - (row - 1) * row, nodeId - 1, nodeId - (row - 1), nodeId - col, nodeId - (row - 1) * col]

      nodeId > 1 && nodeId < row ->
        #IO.puts "i"
        [nodeId + (row - 1) * row, nodeId + row, nodeId - 1, nodeId + 1, nodeId + (row - 1) * col, nodeId + col]
      nodeId > col - row + 1 && nodeId < col ->
        #IO.puts "j"
        [nodeId - row, nodeId - (row - 1) * row, nodeId - 1, nodeId + 1, nodeId + (row - 1) * col, nodeId + col]
      nodeId > col * 2 + 1 && nodeId < col * 2 + row ->
        #IO.puts "k"
        [nodeId + (row - 1) * row, nodeId + row, nodeId - 1, nodeId + 1, nodeId - col, nodeId - (row - 1) * col]
      nodeId > col * 3 - (row - 1) && nodeId < col * 3 ->
        #IO.puts "l"
        [nodeId - row, nodeId - (row - 1) * row, nodeId - 1, nodeId + 1, nodeId - col, nodeId - (row - 1) * col]

      rem(nodeId - 1, col) == 0 ->
        #IO.puts "m"
        [nodeId + (row - 1) * row, nodeId + row, nodeId + (row - 1), nodeId + 1, nodeId - col, nodeId + col]
      rem(nodeId - row, col) == 0 ->
        #IO.puts "n"
        [nodeId + (row - 1) * row, nodeId + row, nodeId - 1, nodeId - (row - 1) , nodeId - col, nodeId + col]
      rem(nodeId - (row - 1) * row - 1, col) == 0 ->
        #IO.puts "o"
        [nodeId - row, nodeId - (row - 1) * row, nodeId + (row - 1), nodeId + 1, nodeId - col, nodeId + col]
      rem(nodeId - (row - 1) * row - row, col) == 0 ->
        #IO.puts "p"
        [nodeId - row, nodeId - (row - 1) * row, nodeId - 1, nodeId - (row - 1), nodeId - col, nodeId + col]

      rem(nodeId - 1, row) == 0 && (nodeId - 1) / row <= row - 1 ->
        #IO.puts "q"
        [nodeId - row, nodeId + row, nodeId + (row - 1), nodeId + 1, nodeId + (row - 1) * col, nodeId + col]
      rem(nodeId, row) == 0 && nodeId / row <= row - 1->
        #IO.puts "r"
        [nodeId - row, nodeId + row, nodeId - 1, nodeId - (row - 1) , nodeId + (row - 1) * col, nodeId + col]
      (nodeId - (row - 1) * col - 1) > 0 && rem(nodeId - (row - 1) * col - 1, row) == 0 && (nodeId - (row - 1) * col - 1) / row <= row - 1 ->
        #IO.puts "s"
        [nodeId - row, nodeId + row, nodeId + (row - 1), nodeId + 1, nodeId - col, nodeId - (row - 1) * col]
      (nodeId - (row - 1) * col) > 0 && rem(nodeId - (row - 1) * col, row) == 0 && (nodeId - (row - 1) * col) / row <= row - 1->
        #IO.puts "t"
        [nodeId - row, nodeId + row, nodeId - 1, nodeId - (row - 1), nodeId - col, nodeId - (row - 1) * col]

      nodeId > 1 && nodeId < col ->
        #IO.puts "u"
        [nodeId - row, nodeId + row, nodeId - 1, nodeId + 1, nodeId + (row - 1) * col, nodeId + col]
      nodeId > col * (row - 1) + 1 && nodeId < col * row ->
        #IO.puts "v"
        [nodeId - row, nodeId + row, nodeId - 1 , nodeId + 1, nodeId - col, nodeId - (row - 1) * col]
      rem(nodeId - 1, col) > 0 && rem(nodeId - 1, col) < row - 1 ->
        #IO.puts "w"
        [nodeId + (row - 1) * row, nodeId + row, nodeId - 1, nodeId + 1, nodeId - col, nodeId + col]
      rem(nodeId - (row - 1) * row - 1, col) > 0 && rem(nodeId - (row - 1) * row - 1, col) < row - 1 ->
        #IO.puts "x"
        [nodeId - row, nodeId - (row - 1) * row, nodeId - 1, nodeId + 1, nodeId - col, nodeId + col]
      rem(nodeId - 1, row) == 0 ->
        #IO.puts "y"
        [nodeId - row, nodeId + row, nodeId + (row - 1), nodeId + 1, nodeId - col, nodeId + col]
      rem(nodeId - (row - 1) - 1, row) == 0 ->
        #IO.puts "z"
        [nodeId - row, nodeId + row, nodeId - 1, nodeId - (row - 1), nodeId - col, nodeId + col]
      true ->
          [nodeId - row, nodeId + row, nodeId - 1, nodeId + 1, nodeId - col, nodeId + col]
    end
    #IO.inspect neighborList
    list = Enum.map(neighborList, fn x -> if x < 0 do -x else x end end)
    list2 = Enum.map(list, fn x -> if x > numOfNodes do numOfNodes else x end end)
    list3 = Enum.map(list2, fn x -> if x == 0 do 1 else x end end)

    list3
  end


  def honeycomb(nodeId, numOfNodes) do
    x = trunc(:math.ceil(:math.sqrt(numOfNodes)))
    neighborList = cond do
      nodeId == 1 ->
        [nodeId + x] #first node
      nodeId == x && rem(x, 2) == 1 ->
        [nodeId - 1, nodeId + x] #first row last node odd x
      nodeId == x && rem(x, 2) == 0 ->
        [nodeId + x] #first row last node even x
      nodeId < x && rem(nodeId, 2) == 0 ->
        [nodeId + x, nodeId + 1] #first row even nodes
      nodeId < x && rem(nodeId, 2) == 1 ->
        [nodeId + x, nodeId - 1] #first row odd nodes
      rem(trunc(Float.ceil(nodeId / x)), x) == 0 && rem(nodeId - 1, x) == 0 && rem(x, 2) == 1 ->
        [nodeId - x] #last row first node odd x
      rem(trunc(Float.ceil(nodeId / x)), x) == 0 && rem(nodeId - 1, x) == 0 && rem(x, 2) == 0 ->
        [nodeId - x, nodeId + 1]  #last row first node even x

      rem(trunc(Float.ceil(nodeId / x)), x)== 0 && rem(rem(nodeId, x), 2) == 0 && rem(x, 2) == 1 ->
        [nodeId - x, nodeId + 1] #last row even node odd x
      rem(trunc(Float.ceil(nodeId / x)), x)== 0 && rem(rem(nodeId, x), 2) == 0 && rem(x, 2) == 0 ->
        [nodeId - x, nodeId - 1] #last row even node even x
      rem(trunc(Float.ceil(nodeId / x)), x) == 0 && rem(rem(nodeId, x), 2) == 1 && rem(x, 2) == 1 ->
        [nodeId - x, nodeId - 1] #last row odd node odd x
      rem(trunc(Float.ceil(nodeId / x)), x) == 0 && rem(rem(nodeId, x), 2) == 1 && rem(x, 2) == 0 ->
        [nodeId - x, nodeId + 1] #last row odd node odd x

      nodeId == numOfNodes ->
        [nodeId - 1, nodeId - x] #last node odd x

      rem(trunc(Float.ceil(nodeId / x)), 2) == 1 && rem(nodeId - 1, x) == 0 ->
        [nodeId - x, nodeId + x] #first column odd row
      rem(trunc(Float.ceil(nodeId / x)), 2) == 0 && rem(nodeId - 1, x) == 0 ->
        [nodeId - x, nodeId + x, nodeId + 1] #first column even row

      rem(nodeId, x) == 0 ->
        [nodeId - x, nodeId + x] #last column
      rem(trunc(Float.ceil(nodeId / x)), 2) == 0 && rem(rem(nodeId, x), 2) == 0 ->
        [nodeId - 1, nodeId - x, nodeId + x] #even row, even column
      rem(trunc(Float.ceil(nodeId / x)), 2) == 0 && rem(rem(nodeId, x), 2) == 1 ->
        [nodeId + 1, nodeId - x, nodeId + x] #even row, odd column
      rem(trunc(Float.ceil(nodeId / x)), 2) == 1 && rem(rem(nodeId, x), 2) == 0 ->
        [nodeId + 1, nodeId - x, nodeId + x] #odd row, even column
      rem(trunc(Float.ceil(nodeId / x)), 2) == 1 && rem(rem(nodeId, x), 2) == 1 ->
        [nodeId - 1, nodeId - x, nodeId + x] #odd row, odd column
    end
    #IO.inspect neighborList
    neighborList
  end

  def randhoneycomb(nodeId, numOfNodes) do
    x = trunc(:math.ceil(:math.sqrt(numOfNodes)))
    neighborList = cond do
      nodeId == 1 -> [nodeId + x, Enum.random(1..numOfNodes)] #first node
      nodeId == x && rem(x, 2) == 1 ->
        [nodeId - 1, nodeId + x, Enum.random(1..numOfNodes)] #first row last node odd x
      nodeId == x && rem(x, 2) == 0 ->
        [nodeId + x, Enum.random(1..numOfNodes)] #first row last node even x
      nodeId < x && rem(nodeId, 2) == 0 ->
        [nodeId + x, nodeId + 1, Enum.random(1..numOfNodes)] #first row even nodes
      nodeId < x && rem(nodeId, 2) == 1 ->
        [nodeId + x, nodeId - 1, Enum.random(1..numOfNodes)] #first row odd nodes
      rem(trunc(Float.ceil(nodeId / x)), x) == 0 && rem(nodeId - 1, x) == 0 && rem(x, 2) == 1 ->
        [nodeId - x, Enum.random(1..numOfNodes)] #last row first node odd x
      rem(trunc(Float.ceil(nodeId / x)), x) == 0 && rem(nodeId - 1, x) == 0 && rem(x, 2) == 0 ->
        [nodeId - x, nodeId + 1, Enum.random(1..numOfNodes)]  #last row first node even x

      rem(trunc(Float.ceil(nodeId / x)), x)== 0 && rem(rem(nodeId, x), 2) == 0 && rem(x, 2) == 1 ->
        [nodeId - x, nodeId + 1, Enum.random(1..numOfNodes)] #last row even node odd x
      rem(trunc(Float.ceil(nodeId / x)), x)== 0 && rem(rem(nodeId, x), 2) == 0 && rem(x, 2) == 0 ->
        [nodeId - x, nodeId - 1, Enum.random(1..numOfNodes)]  #last row even node even x
      rem(trunc(Float.ceil(nodeId / x)), x) == 0 && rem(rem(nodeId, x), 2) == 1 && rem(x, 2) == 1 ->
        [nodeId - x, nodeId - 1, Enum.random(1..numOfNodes)] #last row odd node odd x
      rem(trunc(Float.ceil(nodeId / x)), x) == 0 && rem(rem(nodeId, x), 2) == 1 && rem(x, 2) == 0 ->
        [nodeId - x, nodeId + 1, Enum.random(1..numOfNodes)] #last row odd node odd x

      nodeId == numOfNodes ->
        [nodeId - 1, nodeId - x, Enum.random(1..numOfNodes)] #last node odd x

      rem(trunc(Float.ceil(nodeId / x)), 2) == 1 && rem(nodeId - 1, x) == 0 ->
        [nodeId - x, nodeId + x, Enum.random(1..numOfNodes)] #first column odd row
      rem(trunc(Float.ceil(nodeId / x)), 2) == 0 && rem(nodeId - 1, x) == 0 ->
        [nodeId - x, nodeId + x, nodeId + 1, Enum.random(1..numOfNodes)] #first column even row

      rem(nodeId, x) == 0 -> [nodeId - x, nodeId + x] #last column
      rem(trunc(Float.ceil(nodeId / x)), 2) == 0 && rem(rem(nodeId, x), 2) == 0 ->
        [nodeId - 1, nodeId - x, nodeId + x, Enum.random(1..numOfNodes)] #even row, even column
      rem(trunc(Float.ceil(nodeId / x)), 2) == 0 && rem(rem(nodeId, x), 2) == 1 ->
        [nodeId + 1, nodeId - x, nodeId + x, Enum.random(1..numOfNodes)] #even row, odd column
      rem(trunc(Float.ceil(nodeId / x)), 2) == 1 && rem(rem(nodeId, x), 2) == 0 ->
        [nodeId + 1, nodeId - x, nodeId + x, Enum.random(1..numOfNodes)] #odd row, even column
      rem(trunc(Float.ceil(nodeId / x)), 2) == 1 && rem(rem(nodeId, x), 2) == 1 ->
        [nodeId - 1, nodeId - x, nodeId + x, Enum.random(1..numOfNodes)] #odd row, odd column
    end
    #IO.inspect neighborList
    neighborList
  end

end
