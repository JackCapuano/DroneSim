function [droneInfo] = moveDroneTowardsPoint(target_position, droneInfo, speed, timestep, currentDrone)

% Calculate the vector from current_position to target_position
        direction_vector = target_position - [droneInfo(currentDrone, 1),droneInfo(currentDrone, 2)];

        % Calculate the distance between current_position and target_position
        distance = norm(direction_vector);

        % Check if the object has reached the target position
        if distance <= speed * timestep
            
            % If the drone would overshoot, go straight to target
            droneInfo(currentDrone , 1:2) = target_position;
            
            
            
        else
            % Calculate the displacement based on speed and timestep
            displacement = speed * timestep;

            % Calculate the unit vector in the direction of the target
            unit_vector = direction_vector / distance;

            % Calculate the new position
            newX = droneInfo(currentDrone, 1) + displacement * unit_vector(1);
            newY = droneInfo(currentDrone, 2) + displacement * unit_vector(2);
            
            % Set the new position
            droneInfo(currentDrone, 1) = newX;
            droneInfo(currentDrone, 2) = newY;
        end

end

