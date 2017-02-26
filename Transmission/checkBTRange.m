function inBTRange = checkBTRange(node1,node2)
% Function to check whether two nodes are within Bluetooth 
% transmission range

% Inputs: Transmission node objects
% Output: Boolean true if nodes are in range

dist_vec = node2.position - node1.position;
dist = sqrt(dist_vec(1)^2 + dist_vec(2)^2);

if dist <= 10
    inBTRange = true;
else
    inBTRange = false;
end