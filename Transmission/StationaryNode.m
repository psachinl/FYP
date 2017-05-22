classdef StationaryNode
    % Class to describe stationary nodes e.g. station, bus stop etc.
    
    % Constant object values
    properties (Constant)
        max_transmission_distance = 10; % Bluetooth transmission max 10m
        transmission_speed = 5;
    end
    
    % Public variables
    properties
        id
        group
        position = {};
        current_position
        packets_transmitted = 0;
        message_to_transmit = false;
    end
    
    % Private variables
    properties (GetAccess=private)
        
    end
    
    % Values that are only calculated when required
    properties (Dependent)
        
    end
    
    % Public methods
    methods
        
        function self = initialise(self,n,group,map_node_positions,end_node)
            % Method to initialise stationary nodes for a simulation
            self.id = n;
            self.group = group;
            self.current_position = [map_node_positions(end_node(n),1),map_node_positions(end_node(n),2)];
        end
        
        function [self,dst] = transmit(self,dst)
            % Method to transmit a message from node to dst node
            self.packets_transmitted = self.packets_transmitted + 1;
            dst.packets_received = dst.packets_received + 1;
            dst.message_to_transmit = true;
            dst.message_table{dst.id} = true;
            dst.message_table{self.id} = true;
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
        