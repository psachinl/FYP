function inBTRange = checkBTRange(node1,node2)
% Function to check whether two nodes are within Bluetooth 
% transmission range

% Inputs: Transmission node objects
% Output: Boolean true if nodes are in range

dist = calculateDistance(node1,node2);

if dist <= 10
    inBTRange = true;
else
    inBTRange = false;
end