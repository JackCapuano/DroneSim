function [potentialFindsMatrix, simulation_flag, droneInfo] = sendVerify_NDrones(droneInfo, i, num_verify, potentialFindsMatrix)
% Sends N drones to verify currentDrone's find, also checks
%disp("Sending drones to verify"); % Debug

% potentialFindsMatrix for actual finds
currentDrone = i;
simulation_flag = true; % normal case should be true

% set current drone's position (where it "found") to the
% potentialFindMatrix
    potentialFindsMatrix(currentDrone, 1) = droneInfo(currentDrone, 1); % X
    potentialFindsMatrix(currentDrone, 2) = droneInfo(currentDrone, 2);% Y
    
% if the drone is faulted and finds (false positive) set a flag variable
    if droneInfo(currentDrone, 17) == 1
        potentialFindsMatrix(currentDrone, 4) = 1;
    end

% Find the nearest num_verify drones
    nearest_n_drones = findNearest_NDrones(droneInfo, i, num_verify);

% set their reset status to 1 (moving towards verification)
    for a = 1:size(nearest_n_drones)
        % set reset status
        droneInfo(nearest_n_drones(a), 3) = 1;
    end

% set their target positions to this find's potentialFindMatrix's location
    for a = 1:size(nearest_n_drones)
        % set reset status
        droneInfo(nearest_n_drones(a), 15) = potentialFindsMatrix(currentDrone, 1); % set X
        droneInfo(nearest_n_drones(a), 16) = potentialFindsMatrix(currentDrone, 2); % set Y
    end

end

