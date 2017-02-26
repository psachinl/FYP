clear

path = [2 6];
map_node_positions = [0,0; 80,90; 0,0; 0,0; 0,0; 100,100];
map_path = [0,0];
for node = 1:size(path,2)
    map_path(node,:) = [map_node_positions(path(node),1), map_node_positions(path(node),2)];
end

% TODO: Add for loop for each leg of the journey

% start_pos = [map_node_positions(path(1),1), map_node_positions(path(1),2)];
% end_pos = [map_node_positions(path(end),1), map_node_positions(path(end),2)];

node_pos = [map_path(1,1), map_path(1,2)];

start_pos = node_pos;
end_pos = [map_path(2,1), map_path(2,2)];

current_pos = start_pos;
% node_pos = current_pos;
speed = 2;

distance_x = end_pos(1) - current_pos(1);
distance_y = end_pos(2) - current_pos(2);
resultant = sqrt(distance_x^2 + distance_y^2);
angle = acos(distance_x/resultant);
movement_x = speed*cos(angle);
movement_y = speed*sin(angle);

new_pos = [start_pos(1) + movement_x, start_pos(2) + movement_y];
node_pos = [node_pos;new_pos];

step = 1;

    while new_pos ~= end_pos
        step = step + 1;
        current_pos = [node_pos(step,1),node_pos(step,2)];
        distance_x = end_pos(1) - current_pos(1);
        distance_y = end_pos(2) - current_pos(2);
        resultant = sqrt(distance_x^2 + distance_y^2);
        angle = acos(distance_x/resultant);
        movement_x = speed*cos(angle);
        movement_y = speed*sin(angle);

        if current_pos(1) + movement_x <= end_pos(1)
            new_pos(1) = current_pos(1) + movement_x;
        else
            new_pos(1) = end_pos(1);
        end

        if current_pos(2) + movement_y <= end_pos(2)
            new_pos(2) = current_pos(2) + movement_y;
        else
            new_pos(2) = end_pos(2);
        end

        node_pos = [node_pos;new_pos];
    end

figure(1)
plot(node_pos(:,1),node_pos(:,2),'-x')
xlim([0 100])
ylim([0 100])

% current_pos = [node_pos(3,1),node_pos(3,2)];
% distance_x = end_pos(1) - current_pos(1);
% distance_y = end_pos(2) - current_pos(2);
% resultant = sqrt(distance_x^2 + distance_y^2);
% angle = acos(distance_x/resultant);
% movement_x = speed*cos(angle);
% movement_y = speed*sin(angle);
% new_pos = [current_pos(1) + movement_x, current_pos(2) + movement_y];
% node_pos = [node_pos;new_pos];


% figure
% hold on
% scatter(start_pos(1),start_pos(2))
% scatter(new_pos(1),new_pos(2))
