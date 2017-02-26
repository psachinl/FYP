function pos = getTimePosition(node_position_mat,time)

if time == 0
    pos = node_position_mat{1}(1,:); % Start point
elseif time == length(node_position_mat{3}) + 1
    pos = node_position_mat{1}(2,:); % End point
else
    pos = node_position_mat{3}(time,:);
end
    