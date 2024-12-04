function [droneInfo, potentialFindsMatrix] = moveDrones_Grid(droneInfo, currentDrone, speed, timestep, verify_wait_time, potentialFindsMatrix, verify_type, false_positive_chance)

    if(droneInfo(currentDrone,3) == 0) % If the reset_status is 0 (standard movement)
        
        % Find which grid point is next for currentDrone
        grid_location = droneInfo(currentDrone, 14);
        
        % Get the x and y coordinates of the grid point
        if(grid_location == 1 || grid_location == 12 || grid_location == 7) % Bottom Left
            target_position = droneInfo(currentDrone , 4:5);
        elseif(grid_location == 2 || grid_location == 5 || grid_location == 9) % Middle
            target_position = droneInfo(currentDrone , 6:7);
        elseif(grid_location == 3 || grid_location == 11) % Top Right
            target_position = droneInfo(currentDrone , 8:9);
        elseif(grid_location == 4 || grid_location == 8) % Bottom Right
            target_position = droneInfo(currentDrone , 10:11);
        elseif(grid_location == 6 || grid_location == 10) % Top Left
            target_position = droneInfo(currentDrone , 12:13);
        end
        
        % Move the drone towards the target point
        droneInfo = moveDroneTowardsPoint(target_position, droneInfo, speed, timestep, currentDrone);
        
        % If the drone reached the last grid location
        if((droneInfo(currentDrone, 1) == target_position(1)) && (droneInfo(currentDrone, 2) == target_position(2)))
            % Update grid location (bc drone reached last grid location)
            if(grid_location <= 11) % If within the range of locations
                droneInfo(currentDrone, 14) = grid_location + 1;
            elseif(grid_location == 12) % At the end, reset to 1st location
                droneInfo(currentDrone, 14) = 1;
            end
        end
        
        
    elseif(droneInfo(currentDrone,3) == 1) % If the reset_status is 1 (Moving to verifying location)
        
        % Find the target
            target_position = droneInfo(currentDrone, 15:16);
        
        % Move the drone towards the point
            droneInfo = moveDroneTowardsPoint(target_position, droneInfo, speed, timestep, currentDrone);
        
        % Start the waiting period and switch to reset_status 2 on reach
            if((droneInfo(currentDrone, 1) == target_position(1)) && (droneInfo(currentDrone, 2) == target_position(2)))
                droneInfo(currentDrone, 18) = verify_wait_time;
                droneInfo(currentDrone, 3 ) = 2;
            end
        
    elseif(droneInfo(currentDrone,3) == 2) % If the reset_status is 2 (Waiting at verifying location)
        
        % Decrement the wait counter
            droneInfo(currentDrone, 18) = droneInfo(currentDrone, 18) - 1;        
        
        % If the drone is faulted and the potentialfind is a false
        % positive, "verify" the false positive
        
            %first find the og drone that started the false positive chain
                % Extract the values to compare from droneInfo
                valuesToCompare = droneInfo(currentDrone, 15:16);

                % Initialize the variable to store the row index of the matching row
                matchingRowIndex = [];

                % Loop over every row of potentialFindsMatrix
                for row = 1:size(potentialFindsMatrix, 1)
                    % Compare valuesToCompare with the current row of potentialFindsMatrix
                    if isequal(valuesToCompare, potentialFindsMatrix(row, 1:2))
                        % Store the row index of the matching row
                        matchingRowIndex = row;
                        % Break out of the loop since we found a match
                        break;
                    end
                end
            
            % then, if the drone is faulted and the potential find is
            % a false positive, verify the false positive
                a = droneInfo(currentDrone, 17) == 1;
                % catch error for b not being set
                if isempty(matchingRowIndex)
                    b = false;
                else
                    b = potentialFindsMatrix(matchingRowIndex, 4) == 1;
                end
                    
                if (a && b && rand() < (false_positive_chance/100))
                    if(verify_type == "Turtle")
                        potentialFindsMatrix = increaseBuffer(potentialFindsMatrix, matchingRowIndex);
                    elseif(verify_type == "NDrones")
                        potentialFindsMatrix(matchingRowIndex, 3) = potentialFindsMatrix(matchingRowIndex, 3) + 1; % increment verify counter
                        % can instantly reset wait timer
                        droneInfo(currentDrone, 18) = 10;
                    end
                    
                end
        
        % Send back to the normal movement by switching to reset_status 0
            if (droneInfo(currentDrone, 18) <= 0)
                droneInfo(currentDrone,3) = 0;
            end
        
    end

end

