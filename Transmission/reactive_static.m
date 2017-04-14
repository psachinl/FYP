clear
close all

for i = 1:4
    nodes{i} = ReactiveNode;
end

broadcasts = {};

nodes{1}.current_position = [10,10];
nodes{1}.message_to_transmit=true;
[nodes{1},broadcast_position] = nodes{1}.broadcast;


