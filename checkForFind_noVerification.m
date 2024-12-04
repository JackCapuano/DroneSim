function [result, stats] = checkForFind_noVerification(droneInfo, targetLocation, maxSearchRadius, stats, chanceOfFalsePositive)
    
    % Normal result should be false
    result = false;
    
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
                %fprintf('FALSE POSITIVE: faulted drone gave false positive, scenario failed \n');
                stats{3,8} = stats{3,8} + 1; % Record the false positive
                stats{5,8} = "No"; % Record the scenario failure
                % End the scenario
                    result = true; % set the output to true
                    close; % close the visual
                    return; % return the function *IMPORTANT*
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
                    if droneInfo(i, 17) == 0 % Not Faulted, found = scenario success
                        %disp('Found, drone not faulted, scenario success');
                        stats{5,8} = "Yes"; % Record successful scenario
                        % End the scenario
                            result = true; % set the output to true
                            close; % close the visual
                            return; % return the function *IMPORTANT*
                    elseif droneInfo(i, 17) == 1 % Faulted, found = false negative
                        %disp('FALSE NEGATIVE: Found, but drone was faulted');
                        stats{3,8} = stats{4,8} + 1;
                        % Dont't end the scenario
                    end
                    
                else 
                    % If here, target was not found
                    
                    %fprintf('Percent towards "on top of" target: %f \n', (distCheck*100) ); % Debug
                    %fprintf('Percent towards "on top of" target: %f \n', (distCheck*100) ); % Debug
                    %disp("Within max range, but not found"); % Debug
                    % Don't end the scenario
                    
                end
            
        end
    end
    
end
