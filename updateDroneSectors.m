function droneInfo = updateDroneSectors(droneInfo, areaHeight, areaWidth)
    % Define the sector boundaries
    sectorHeight = areaHeight / 3;
    sectorWidth = areaWidth / 3;

    % Loop through each drone and assign sector designations
    for j = 1:size(droneInfo, 1)
        x = droneInfo(j, 6); % Middle grid x coord is in 6
        y = droneInfo(j, 7); % Middle grid y coord is in 7
        
        % Determine the row of the sector
        if y <= sectorHeight
            row = 1; % Top row
        elseif y <= 2 * sectorHeight
            row = 2; % Middle row
        else
            row = 3; % Bottom row
        end
        
        % Determine the column of the sector
        if x <= sectorWidth
            col = 1; % Left column
        elseif x <= 2 * sectorWidth
            col = 2; % Middle column
        else
            col = 3; % Right column
        end
        
        % Calculate the sector number
        sector = (row - 1) * 3 + col;
        
        % Update the sector designation in column 19
        droneInfo(j, 19) = sector;
    end
    
end
