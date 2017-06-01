classdef ReactiveDelayNode
    % Class to describe nodes in a MANET where transmission is via a
    % reactive routing protocol where a minimum delay period is enforced
    % between broadcasts
    
    % Constant object values
    properties (Constant)
        max_transmission_distance = 10;  % Bluetooth transmission max 10m
        transmission_cost = 0.05;        % Power consumption in Watts
        table_update_cost = 0.025;       % 0.5*transmission_cost
        broadcast_cost = 0.2;            % 4.0*transmission_cost
        reply_cost = 0.05;               % 1.0*transmission_cost
        transmission_speed = 5;
        transmissions_per_second = 1;    % Maximum number of transmissions per second
        broadcast_delay = 5;             % Minimum delay in seconds between broadcasts
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
        broadcast_count = 0;
        last_broadcast_time = 0;
        replies_sent = 0;
        message_to_transmit = false;
        ready_to_transmit = false;
        location_table
        message_table
        update_packets_transmitted = 0;
        table_updates = 0;
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
            power_consumption = (self.packets_transmitted + self.update_packets_transmitted) * self.transmission_cost + self.table_updates * self.table_update_cost + self.broadcast_count * self.broadcast_cost + self.replies_sent * self.reply_cost;
        end
        
        function [self,dst] = transmit(self,dst)
            % Method to transmit a message from node to dst node
            self.packets_transmitted = self.packets_transmitted + 1;
            dst.packets_received = dst.packets_received + 1;
            dst.message_to_transmit = true;
            dst.message_table{dst.id} = true;
            dst.message_table{self.id} = true;
            self.message_table{dst.id} = true;
            self.ready_to_transmit = false;
        end
        
        function [self,position,id] = broadcast(self,t)
            % Method to broadcast packets to the channel to begin route
            % discovery
            self.broadcast_count = self.broadcast_count + 1;
            position = self.current_position;
            id = self.id;
            self.ready_to_transmit = false;
            self.last_broadcast_time = t;
        end
        
        function blocked = checkBlockingPeriod(self,t)
            % Method to check whether the node is within the blocking
            % period for broadcasting route request packets
            if t-self.last_broadcast_time < self.broadcast_delay
                blocked = true;
            else
                blocked = false;
            end
        end
        
        function [self,bc_node] = sendReply(self,bc_node)
            % Method to reply to broadcast so transmission can begin
            % Self is the replying node i.e. destination node for the
            % transmission, bc_node is the broadcasting node i.e. the
            % source node for the transmission
            self.replies_sent = self.replies_sent + 1;
            
            self.location_table{bc_node.id} = bc_node.current_position;
            self.message_table{bc_node.id} = true;
            self.location_table{self.id} = self.current_position;
            self.table_updates = self.table_updates + 1;
            self.update_packets_transmitted = self.update_packets_transmitted + 1;
            
            bc_node.location_table{self.id} = self.current_position;
            bc_node.message_table{self.id} = false;
            bc_node.table_updates = bc_node.table_updates + 1;
            bc_node.ready_to_transmit = true;
        end
        
        function inBTRange = checkBTRange(self,node2)
        % Function to check whether two nodes are within Bluetooth 
        % transmission range

        % Inputs: Transmission node objects
        % Output: Boolean true if nodes are in range

            dist = calculateDistance(self,node2);

            if dist <= self.max_transmission_distance
                inBTRange = true;
            else
                inBTRange = false;
            end
        end
    end
end
        