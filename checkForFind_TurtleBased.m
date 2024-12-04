function [potentialFindsMatrix, stats, droneInfo, simulation_flag] = checkForFind_TurtleBased(droneInfo, targetLocation, maxSearchRadius, num_verify, stats, chanceOfFalsePositive, potentialFindsMatrix)

    % Normal result should be true (keep going)
    simulation_flag = true;
    
    % Buffer starting percentage
    starting_buffer = 12; 
    
%% Finds %%
  
    % Check the number of drones
    numDrones = size(droneInfo, 1);
    
% Loop through every drone
    for current_drone_index = 1:numDrones
        
        % FALSE POSITIVE CHANCE IF FAULTED & CREATE POTENTIAL FIND
        
            if droneInfo(current_drone_index, 17) == 1 % if faulted

                % Generate a random number between 0 and 100
                randomNumber = rand() * 100;

                % Check if the random number falls within the
                % chanceOfFalsePositive
                if randomNumber <= chanceOfFalsePositive
                    %fprintf('FALSE POSITIVE: faulted drone gave false positive \n');
                    stats{3,8} = stats{3,8} + 1; % Record the false positive
                    % set current drone's position (where it "found") to the
                    % potentialFindMatrix
                        potentialFindsMatrix(current_drone_index, 1) = droneInfo(current_drone_index, 1); % X
                        potentialFindsMatrix(current_drone_index, 2) = droneInfo(current_drone_index, 2);% Y
                        potentialFindsMatrix(current_drone_index, 3) = potentialFindsMatrix(current_drone_index, 3) + starting_buffer;
                        potentialFindsMatrix(current_drone_index, 5) = 1;
                    % Set a flag recording this as a false positive
                            potentialFindsMatrix(current_drone_index, 4) = 1;
                end
            end
            
        % end FALSE POSITIVE CHANCE IF FAULTED & CREATE POTENTIAL FIND
            
        
        % CHECK FOR ACTUAL FIND & CREATE POTENTIAL FIND
        
            % Calculate the distance between the drone and the target
            distance = sqrt((droneInfo(current_drone_index, 1) - targetLocation(1))^2 + (droneInfo(current_drone_index, 2) - targetLocation(2))^2);

            if(distance <= maxSearchRadius) % if within maxSearchRadius

                % Get the % to the max search radius the drone is
                distCheck = 1-(distance/maxSearchRadius);

                distCheckLog = -0.875 * log((-distCheck + 1)); % log based algorithm
                distCheckLog = distCheckLog/2.302585094; % log based algorithm

                % Generate a random number between 0 and 1
                randomChance = rand();

                    if distCheckLog >= randomChance % If the drone found the target based on log'd percent chance
                        % If here, target has been found

                        %fprintf('Percent towards "on top of" target: %f \n', (distCheck*100) ); % Debug
                        %fprintf('Chance of find: %f, Random Number: %f \n', distCheckLog, randomChance); % Debug

                        % Check if the drone is faulted
                        if droneInfo(current_drone_index, 17) == 0 % Not Faulted
                            %fprintf('Percent towards "on top of" target: %f \n', (distCheck*100) ); % Debug

                            % If the drone is verifying (moving or waiting)
                            if droneInfo(current_drone_index, 3) == 1 || droneInfo(current_drone_index, 3) == 2
                                this_drone_verify_location = droneInfo(current_drone_index, 15:16);

                                % For the all potential finds
                                for current_potFindMatrix_index = 1:size(potentialFindsMatrix, 1)
                                    % Check if x-coordinate and y-coordinate match
                                    if potentialFindsMatrix(current_potFindMatrix_index, 1) == this_drone_verify_location(1) && potentialFindsMatrix(current_potFindMatrix_index, 2) == this_drone_verify_location(2)
                                        % increment the buffer
                                        %disp("Incerementing total verifications"); % Debug
                                        potentialFindsMatrix = increaseBuffer(potentialFindsMatrix, current_potFindMatrix_index);
                                        potentialFindsMatrix(current_drone_index, 4) = 0; % if theres an actual find, we can un-false positive it even if it started as one
                                    end
                                end

                            else % If the drone is not verifying, create new potential find
                                % set current drone's position (where it "found") to the
                                % potentialFindMatrix
                                % and start the buffer filling at 10
                                    potentialFindsMatrix(current_drone_index, 1) = droneInfo(current_drone_index, 1); % X
                                    potentialFindsMatrix(current_drone_index, 2) = droneInfo(current_drone_index, 2);% Y
                                    potentialFindsMatrix(current_drone_index, 3) = potentialFindsMatrix(current_drone_index, 3) + starting_buffer;
                                    potentialFindsMatrix(current_drone_index, 5) = 1; % flag to send verifying drones here
                                    potentialFindsMatrix(current_drone_index, 4) = 0; % flag for not a false positive
                            end
                            
                            

                        elseif droneInfo(current_drone_index, 17) == 1 % Faulted, found = false negative
                            %disp('FALSE NEGATIVE: Found, but drone was faulted');
                            stats{3,8} = stats{4,8} + 1;
                            % Dont't end the scenario
                        end

                    else 
                        % If here, target was not found

                        %fprintf('Percent towards "on top of" target: %f \n', (distCheck*100) ); % Debug
                        %disp("Within max range, but not found"); % Debug
                        % Don't end the scenario

                    end

            end
            
            % END CHECK FOR ACTUAL FIND & CREATE POTENTIAL FIND
        
    end
    
    % END FOR EVERY DRONE
    
%% Buffer Calls %%

    % For every potentialFindsMatrix row
    for potentialFindMatrix_row = 1:size(potentialFindsMatrix, 1)
        % CALL DRONES WITHIN X RANGE OF INITIALIZED BUFFERS (based on
        % buffer fill %) (if its an initialized buffer)
        if (potentialFindsMatrix(potentialFindMatrix_row, 3) > 0) && (potentialFindsMatrix(potentialFindMatrix_row, 5) == 1) && (potentialFindsMatrix(potentialFindMatrix_row, 3) < 95)
            % - find x mile range for current potential find (based on %)
            x_mile_range_current = findXMileRange(potentialFindsMatrix, potentialFindMatrix_row);
                % - call all drones within x mile range
                droneInfo = sendVerify_InRangeDrones(droneInfo, x_mile_range_current, potentialFindMatrix_row);
                % - call all drones within "nest" (area on grid)
                %droneInfo = sendVerify_InNestDrones(droneInfo, x_mile_range_current, potentialFindMatrix_row);
            potentialFindsMatrix(potentialFindMatrix_row, 5) = 0;
        end
        
        % CHECK FOR FILLED BUFFERS
        % Check if the value in the 3rd column of the current row exceeds
        % the threshold (93 bc we -7 every step anyways)
            if potentialFindsMatrix(potentialFindMatrix_row, 3) >= 100
                % If any row exceeds the threshold, set the flag to true and break the loop
                exceeds_threshold = true;
                
                if droneInfo(potentialFindMatrix_row,17) == 0 % If the find was an actual find (i.e. the initial drone was not faulted)
                    disp("Potential Find Buffer filled, true find, simulation success");
                    stats{5,8} = "Yes"; 
                elseif droneInfo(potentialFindMatrix_row,17) == 1 % If the find is a false positive chain
                    disp("Potential Find Buffer filled, but it was a false positive chain, simulation fail");
                    stats{5,8} = "No";
                end
                
                simulation_flag = ~exceeds_threshold; % if exceeded threshold, sim flag should be false
                return;
            end
    end
    % DECREASE THE BUFFERS (based on theorem)
            potentialFindsMatrix = decreaseBuffer(potentialFindsMatrix);

end

