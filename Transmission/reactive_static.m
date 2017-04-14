clear
close all

number_of_nodes = 3;

for i = 1:number_of_nodes
    nodes{i} = ReactiveNode;
    nodes{i}.id = i;
    nodes{i}.location_table{1,number_of_nodes} = [];
    nodes{i}.message_table{1,number_of_nodes} = [];
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
            fprintf('Sending reply message with position for transmission \n');
            
            % Send reply and update tables
            [nodes{i},nodes{node_id}] = nodes{i}.sendReply(nodes{node_id});
            
            % TODO: Introduce movement and the delays associated with the
            % route discovery step e.g. route discovery step takes 1s so
            % the transmission must occur in the next time slice. This is
            % the tradeoff of speed vs power consumption for active vs
            % reactive routing
            
            % In the next time slice, update location tables if required,
            % then transmit if the nodes are still within range. 
            % Repeat broadcast process every n seconds where n can be
            % varied to find the optimal power consumption.
            
            % Transmit message
            fprintf('Transmitting message \n');
            [nodes{node_id},nodes{i}] = nodes{node_id}.transmit(nodes{i});
        else
            inBTRange = false;
        end
    end
end
