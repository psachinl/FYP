classdef DREAMPacket
    % Class to describe nodes in a MANET where transmission is via LMR
    
    % Constant object values
    properties (Constant)
        transmission_speed = 2048;  % 2 MB/s using BLE only
        size = 31;                  % Packet size of 31 bytes
        movement_speed = 3e8;       % Packets move at speed of light in air
    end
    
    % Public variables
    properties
        source
        destination
        distance
    end
    
    % Private variables
    properties (GetAccess=private)
    end
    
    % Values that are only calculated when required
    properties (Dependent)
        propagation_delay
        transmission_time
        delivery_time
    end
    
    % Public methods
    methods
        function propagation_delay=get.propagation_delay(self)
            propagation_delay = self.distance / self.movement_speed;
        end
        
        function transmission_time=get.transmission_time(self)
            transmission_time = self.size * 8 / self.transmission_speed;
        end
        
        function delivery_time=get.delivery_time(self)
            delivery_time = self.propagation_delay + self.movement_speed;
        end
    end
end
        