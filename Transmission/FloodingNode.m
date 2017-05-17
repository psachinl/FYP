classdef FloodingNode
    % Class to describe nodes in a MANET where transmission is via flooding
    
    % Constant object values
    properties (Constant)
        max_transmission_distance = 10; % Bluetooth transmission max 10m
        transmission_cost = 0.5;        % Power consumption in Watts
        table_update_cost = 0.25;
        transmission_speed = 5;
    end
    
    % Public variables
    properties
        id
        group
        position = {};
        current_position
        start_point
        end_point
        min_speed
        max_speed
        packets_transmitted = 0;
        packets_received = 0;
        message_to_transmit = false;
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
            % Method to calculate power consumption
            power_consumption = self.packets_transmitted * self.transmission_cost;
        end
        
        function [self,dst] = transmit(self,dst)
            % TODO: Implement transmission via flooding
        end
        
        function inBTRange = checkBTRange(self,node2)
        % Function to check whether two nodes are within Bluetooth 
        % transmission range

        % Inputs: Transmission node objects
        % Output: Boolean true if nodes are in range

            dist = calculateDistance(self,node2);

            if dist <= 10 % 10m range for Class 2 BLE radios
                inBTRange = true;
            else
                inBTRange = false;
            end
        end
    end
end
        