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
        id
        position
        packets_transmitted = 0;
        packets_received = 0;
        message_to_transmit = false;
        location_table
        message_table
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
            % Method to transmit a message from node to dst node
            self.packets_transmitted = self.packets_transmitted + 1;
            dst.packets_received = dst.packets_received + 1;
            dst.message_to_transmit = true;
            self.message_table{dst.id} = true;
        end
        
        function inBTRange = checkBTRange(node1,node2)
        % Function to check whether two nodes are within Bluetooth 
        % transmission range

        % Inputs: Transmission node objects
        % Output: Boolean true if nodes are in range

            dist = calculateDistance(node1,node2);

            if dist <= 10 % 10m range for Class 2 BLE radios
                inBTRange = true;
            else
                inBTRange = false;
            end
        end
    end
end
        