function in_range = checkBTRange(node1,node2)
% Function to check whether two nodes are within Bluetooth 
% transmission range
x_dist = abs(node1(1) - node2(1));
y_dist = abs(node1(2) - node2(2));
dist = sqrt(x_dist^2 + y_dist^2);

if dist <= 30
    in_range = true;
else
    in_range = false;
end