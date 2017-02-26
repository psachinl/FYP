classdef DREAMNode
    % Class to describe nodes in a MANET where transmission is via LMR
    
    % Constant object values
    properties (Constant)
        max_transmission_distance = 10; % Bluetooth transmission max 10m
        transmission_cost = 0.5;        % Power consumption in Watts
        transmission_speed = 5;
    end
    
    % Public variables
    properties
        position
        packets_transmitted = 0;
        packets_received = 0;
        message_to_transmit = false;
        location_table
    end
    
    % Private variables
    properties (GetAccess=private)
        transmission_required
    end
    
    % Values that are only calculated when required
    properties (Dependent)
        power_consumption
    end
    
    % Public methods
    methods
        function power_consumption=get.power_consumption(self)
            power_consumption = self.packets_transmitted * self.transmission_cost;
        end
    end
end
        