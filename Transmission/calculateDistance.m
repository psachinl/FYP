function dist = calculateDistance(node1,node2)
% Function to calculate straight line distance between two nodes

% Inputs: Transmission node objects
% Output: Distance between nodes

dist_vec = node2.position - node1.position;
dist = sqrt(dist_vec(1)^2 + dist_vec(2)^2);