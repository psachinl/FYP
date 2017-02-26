clear

path = [1 4 6];
number_of_legs = length(path)-1;
min_speed = 1;
max_speed = 2;
leg_speeds = (max_speed - min_speed).*rand(1,number_of_legs)+min_speed;
map_node_positions = [0,50; 80,90; 30,30; 50,10; 70,30; 100,100; 0,0];
map_path = [0,0];
for node = 1:size(path,2)
    map_path(node,:) = [map_node_positions(path(node),1), map_node_positions(path(node),2)];
end

loop_pos=[];

for leg = 1:number_of_legs
    

%     node_pos = [map_path(leg,1), map_path(leg,2)];
    start_pos = [map_path(leg,1), map_path(leg,2)];
    end_pos = [map_path(leg+1,1), map_path(leg+1,2)];

    current_pos = start_pos;
    % node_pos = current_pos;
%     speed = 2;
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

figure
% plot(node_pos(:,1),node_pos(:,2),'x')
hold on
grid on
plot(loop_pos(1,1),loop_pos(1,2),'^')
plot(loop_pos(end,1),loop_pos(end,2),'o')
plot(waypoints(:,1),waypoints(:,2),'mx')
plot(main_path(:,1),main_path(:,2),'.')
xlim([0 100])
ylim([0 100])
hold off
xlabel('X-axis coordinate')
ylabel('Y-axis coordinate')
title('Shortest Path Map Based Movement Mobility Model')
legend('Start Position', 'End Position', 'Waypoint', 'Node Path', 'Location', 'best')
