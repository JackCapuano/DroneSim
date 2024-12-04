function [potentialFindsMatrix, stats, droneInfo, simulation_flag] = checkForFind_StandardConsensus(droneInfo, targetLocation, maxSearchRadius, num_verify, stats, chanceOfFalsePositive, potentialFindsMatrix)
    
    % Normal result should be true (keep going)
    simulation_flag = true;
    
    % Check the number of drones
    numDrones = size(droneInfo, 1);
    
% Loop through every drone
    for i = 1:numDrones
        
%% False Positives %%
        % Calculate the chance for a false positive if faulted
        if droneInfo(i, 17) == 1
            
            % Generate a random number between 0 and 100
            randomNumber = rand() * 100;

            % Check if the random number falls within the
            % chanceOfFalsePositive
            if randomNumber <= chanceOfFalsePositive
                %fprintf('FALSE POSITIVE: faulted drone gave false positive \n');
                stats{3,8} = stats{3,8} + 1; % Record the false positive
                
                % Send N drones to verify and check for an actual find
                    [potentialFindsMatrix, simulation_flag, droneInfo] = sendVerify_NDrones(droneInfo, i, num_verify, potentialFindsMatrix);
                    
            end
            
        end
            
%% Actual Finds %%
        % Calculate actual find chances
        
        % Calculate the distance between the drone and the target
        distance = sqrt((droneInfo(i, 1) - targetLocation(1))^2 + (droneInfo(i, 2) - targetLocation(2))^2);
        
        % Calculate find chance if within maxSearchRadius
        if(distance <= maxSearchRadius)
            
            % Get the % to the max search radius the drone is
            distCheck = 1-(distance/maxSearchRadius);
            
            distCheckLog = -0.875 * log((-distCheck + 1));
            distCheckLog = distCheckLog/2.302585094;

            % Generate a random number between 0 and 1
            randomChance = rand();

            % Check if the drone found the target based on random chance
            
                if distCheckLog >= randomChance 
                    % If here, target has been found
                    
                    %fprintf('Percent towards "on top of" target: %f \n', (distCheck*100) ); % Debug
                    %fprintf('Chance of find: %f, Random Number: %f \n', distCheckLog, randomChance); % Debug
                    
                    % Check if the drone is faulted
                    if droneInfo(i, 17) == 0 % Not Faulted
                        %fprintf('Percent towards "on top of" target: %f \n', (distCheck*100) ); % Debug
                        
                        % Send N drones to verify and check for an actual find
                            [potentialFindsMatrix, simulation_flag, droneInfo] = sendVerify_NDrones(droneInfo, i, num_verify, potentialFindsMatrix);
                    
                        % Increment the potentialFindsMatrix 'find'
                        % count, *If the drone is verifying*
                        if droneInfo(i, 3) == 1 || droneInfo(i, 3) == 2
                            this_drone_verify_location = droneInfo(i, 15:16);
                            
                            % For the all potential finds
                            for j = 1:size(potentialFindsMatrix, 1)
                                % Check if x-coordinate and y-coordinate match
                                if potentialFindsMatrix(j, 1) == this_drone_verify_location(1) && potentialFindsMatrix(j, 2) == this_drone_verify_location(2)
                                    % Increment the third column by one
                                    %disp("Incerementing total verifications"); % Debug
                                    potentialFindsMatrix(j, 3) = potentialFindsMatrix(j, 3) + 1;
                                end
                            end
                            
                        end
                        
                    elseif droneInfo(i, 17) == 1 % Faulted, found = false negative
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
        
        
%% Check potentialFindMatrix for actual finds %%

        % Iterate over each row of the 3rd column
        for j = 1:size(potentialFindsMatrix, 1)
            % Check if the value in the 3rd column of the current row exceeds the threshold
            if potentialFindsMatrix(j, 3) >= num_verify
                % If any row exceeds the threshold, set the flag to true and break the loop
                exceeds_threshold = true;
                
                if droneInfo(j,17) == 0 % If the find was an actual find (i.e. the initial drone was not faulted)
                    disp("Potential Find Reached num_verify, true find, simulation success");
                    stats{5,8} = "Yes"; 
                elseif droneInfo(j,17) == 1 % If the find is a false positive chain
                    disp("Potential Find Reached num_verify, but it was a false positive chain, simulation fail");
                    stats{5,8} = "No";
                end
                
                simulation_flag = ~exceeds_threshold; % if exceeded threshold, sim flag should be false
                return;
            end
        end
        
    end
    
end
