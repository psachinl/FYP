classdef NetworkNode
    % Class to describe nodes in a MANET
    properties (Constant)
        max_transmission_distance = 10; % Bluetooth transmission max 10m
        transmission_cost = 0.5;          % Power consumption in Watts
        transmission_speed = 5;
    end
    
    properties
        position
        packets_transmitted = 0;
        packets_received = 0;
    end
    
    properties (GetAccess=private)
        transmission_required
    end
    
    properties (Dependent)
        power_consumption
    end
end
        