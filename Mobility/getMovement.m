%%
function [endpoints,waypoints,main_path] = getMovement(path,min_speed,max_speed,map_node_positions,map_path)

if ~exist('map_path','var')
    % map_path parameter does not exist, so calculate it here
    for node = 1:length(path)
        map_path(node,:) = [map_node_positions(path(node),1), map_node_positions(path(node),2)];
    end
end

loop_pos=[];
number_of_legs = length(path)-1;
leg_speeds = (max_speed - min_speed).*rand(1,number_of_legs)+min_speed;

for leg = 1:number_of_legs
    
    start_pos = [map_path(leg,1), map_path(leg,2)];
    end_pos = [map_path(leg+1,1), map_path(leg+1,2)];

    current_pos = start_pos;
    speed = leg_speeds(leg);

    distance_x = end_pos(1) - start_pos(1);
    distance_y = end_pos(2) - start_pos(2);
    if distance_x == 0
        resultant = distance_y;
    elseif distance_y == 0
        resultant = distance_x;
    else
        resultant = sqrt(distance_x^2 + distance_y^2);
    end
    angle = acos(distance_x/resultant);
    movement_x = speed*cos(angle);
    movement_y = speed*sin(angle) * sign(distance_y);

    new_pos = [start_pos(1) + movement_x, start_pos(2) + movement_y];
    node_pos = [start_pos;new_pos];

    step = 1;

        while new_pos(1) ~= end_pos(1) || new_pos(2) ~= end_pos(2)
            step = step + 1;
            current_pos = [node_pos(step,1),node_pos(step,2)];
            distance_x = end_pos(1) - current_pos(1);
            distance_y = end_pos(2) - current_pos(2);
            resultant = sqrt(distance_x^2 + distance_y^2);
            angle = acos(distance_x/resultant);
            movement_x = speed*cos(angle);
            movement_y = speed*sin(angle) * sign(distance_y);

            if current_pos(1) + movement_x <= end_pos(1) && movement_x > 0
                new_pos(1) = current_pos(1) + movement_x;
            elseif current_pos(1) + movement_x >= end_pos(1) && movement_x < 0
                  new_pos(1) = current_pos(1) + movement_x;  
            else
                new_pos(1) = end_pos(1);
            end

            if current_pos(2) + movement_y <= end_pos(2) && movement_y > 0
                new_pos(2) = current_pos(2) + movement_y;
            elseif current_pos(2) + movement_y >= end_pos(2) && movement_y < 0
                new_pos(2) = current_pos(2) + movement_y;
            else
                new_pos(2) = end_pos(2);
            end

            node_pos = [node_pos;new_pos];
        end
        
        loop_pos = [loop_pos;node_pos];
end

main_path = [loop_pos(2:(end-1),1),loop_pos(2:(end-1),2)];
waypoints = [map_path(2:(end-1),1),map_path(2:(end-1),2)];
endpoints = [loop_pos(1,1),loop_pos(1,2);loop_pos(end,1),loop_pos(end,2)];
