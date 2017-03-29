clear

nodes = {}; % Cell array to store all nodes
number_of_nodes = 4;

for n = 1:number_of_nodes
    nodes{n} = DREAMNode;
    nodes{n}.id = n;
end

clear n

% Set node attributes
nodes{1}.position = [2,2];
nodes{1}.message_to_transmit = true;

nodes{2}.position = [0,0];

nodes{3}.position = [-1,-1];

nodes{4}.position = [1,-1];

% % Plot node positions
% figure
% hold on
% for n=1:number_of_nodes
%     plot(nodes{n}.position(1),nodes{n}.position(2),'*')
% end
% hold off
% grid on

% Fill location tables
% TODO: If the node has moved, transmit update messages to neighbouring
% nodes
% TODO: Add energy cost of updating location table and message table

for i=1:number_of_nodes
    for j=1:number_of_nodes
        nodes{i}.location_table{j} = nodes{j}.position;
        nodes{i}.message_table{j} = nodes{j}.message_to_transmit;
    end
end

clear i j

% Transmit message packets

% Transmission occurs if a given node has a message to transmit, if the
% destination node is within BLE range and if the destination node has not
% received the message already
for src=1:number_of_nodes
    if nodes{src}.message_to_transmit
        for dest=1:number_of_nodes
            if dest ~= src
                if nodes{src}.checkBTRange(nodes{dest}) && ~nodes{dest}.message_to_transmit
                    [nodes{src},nodes{dest}] = nodes{src}.transmit(nodes{dest});
                end
            end
        end
    end
end

clear src dest
    
% TODO: Model packet movement in a 2D plane
% TODO: Add ack packets if required
