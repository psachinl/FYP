clear

nodes = {}; % Cell array to store all nodes
number_of_nodes = 4;

for n = 1:number_of_nodes
    nodes{n} = DREAMNode;
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

for i=1:number_of_nodes
    for j=1:number_of_nodes
        nodes{i}.location_table{j} = nodes{j}.position;
    end
end

clear i j

if checkBTRange(nodes{1},nodes{2}) && nodes{1}.message_to_transmit
    % p = DREAMPacket;
    % p.source = 1;
    % p.destination = 2;

    % TODO: Implement the use of the location table

    src = 1;
    dst = 2;
    
    [nodes{src},nodes{dst}] = nodes{src}.transmit(nodes{dst});
    
    % TODO: Model packet movement in a 2D plane
    % TODO: Add ack packets if required
end

