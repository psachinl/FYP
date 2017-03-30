clear
close all

number_of_nodes = 10;
nodes{1,number_of_nodes} = []; % Cell array to store all nodes
grid_size = 10;
% positions = randi(grid_size,number_of_nodes,2);
load positions

for n = 1:number_of_nodes
    nodes{n} = DREAMNode;
    nodes{n}.id = n;
    nodes{n}.location_table{1,number_of_nodes} = [];
    nodes{n}.message_table{1,number_of_nodes} = [];
    nodes{n}.position = [positions(n,1),positions(n,2)];
    
    if ~mod(n,5) % Seed message to every 5th node 
        nodes{n}.message_to_transmit = true;
    end
end

clear n

% Set node attributes

% nodes{1}.position = [2,2];
% nodes{1}.message_to_transmit = true;
% 
% nodes{2}.position = [0,0];
% 
% nodes{3}.position = [-1,-1];
% 
% nodes{4}.position = [1,-1];
% 
% nodes{5}.position = [21,-1];
% nodes{5}.message_to_transmit = true;
% 
% nodes{6}.position = [21,-2];

% Plot node positions

figure
hold on
for n=1:number_of_nodes
    plot(nodes{n}.position(1),nodes{n}.position(2),'*')
end
hold off
grid on

% Fill location tables

% Update packets contain new position and/or new message status values
% TODO: If the node has moved, transmit update messages to neighbouring
% nodes

for i=1:number_of_nodes
    for j=1:number_of_nodes
        if nodes{i}.checkBTRange(nodes{j})
            nodes{i}.location_table{j} = nodes{j}.position;
            nodes{i}.message_table{j} = nodes{j}.message_to_transmit;
            nodes{i}.table_updates = nodes{i}.table_updates + 1;
            nodes{j}.update_packets_transmitted = nodes{j}.update_packets_transmitted + 1;
        end
    end
end

clear i j

% Transmit message packets

% Transmission occurs if a given node has a message to transmit, if the
% destination node is within BLE range and if the destination node has not
% received the message already. If the destination node already has the
% message, the message tables are updated by the destination node sending
% an update packet to the source node

for src=1:number_of_nodes
    if nodes{src}.message_to_transmit
        for dest=1:number_of_nodes
            if dest ~= src
                if nodes{src}.checkBTRange(nodes{dest}) && ~nodes{dest}.message_to_transmit
                    [nodes{src},nodes{dest}] = nodes{src}.transmit(nodes{dest});
                elseif nodes{src}.checkBTRange(nodes{dest}) && nodes{dest}.message_to_transmit
                    nodes{src}.message_table{dest} = true;
                    nodes{src}.table_updates = nodes{src}.table_updates + 1;
                    nodes{dest}.update_packets_transmitted = nodes{dest}.update_packets_transmitted + 1;
                end
            end
        end
    end
end

clear src dest
    
% TODO: Model packet movement in a 2D plane
% TODO: Turn this script into a transmit then move loop
% TODO: Add ack packets if required
