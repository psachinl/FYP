clear
close all

for i = 1:3
    nodes{i} = ReactiveNode;
    nodes{i}.id = i;
end

broadcasts = {};

nodes{1}.current_position = [15,15];
nodes{1}.message_to_transmit=true;

nodes{2}.current_position = [10,15];

nodes{3}.current_position = [0,0];

[nodes{1},broadcast_position,node_id] = nodes{1}.broadcast;

% Check whether any nodes are within 10m of the broadcast location

for i=1:3
    if i~=node_id
        dist = calculateDistance(nodes{node_id},nodes{i});
        
        if dist <= 10 % 10m range for Class 2 BLE radios
            inBTRange = true;
            fprintf('Node %d is within BLE range of node %d \n',i,node_id);
            fprintf('Send reply message with position for transmission \n');
        else
            inBTRange = false;
        end
    end
end
