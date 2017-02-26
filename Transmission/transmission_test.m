clear

nodes = {}; % Cell array to store all nodes
number_of_nodes = 4;

for n = 1:number_of_nodes
    nodes{n} = LMRNode;
end

node1 = LMRNode;
node1.position = [2,2];
node1.message_to_transmit = true;

node2 = LMRNode;
node2.position = [0,0];

node3 = LMRNode;
node3.position = [-1,-1];

node4 = LMRNode;
node4.position = [1,-1];

if checkBTRange(node1,node2) && node1.message_to_transmit
    transmitted=true;
end

