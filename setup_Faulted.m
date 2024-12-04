function [droneInfo, numFaulted] = setup_Faulted(droneInfo, percentFaulted)
    
    % Get the number of rows in droneInfo
    numRows = size(droneInfo, 1);
    
    % Generate random numbers for each row
    randomNumbers = rand(numRows, 1) * 100; % Random numbers between 0 and 100
    
    % Determine which rows to change based on percentFaulted
    rowsToChange = randomNumbers <= percentFaulted;
    
    % Change the 17th column to 1 for the selected rows
    droneInfo(rowsToChange, 17) = 1;
    
    % Track & Output the number of rows changed (# of faulted drones)
    numFaulted = sum(rowsToChange);
    
end

