function droneInfo = sendVerify_InNestDrones(droneInfo, x_mile_range, currentDroneIndex)

    droneIndices = [];
    currentDroneLocation = droneInfo(currentDroneIndex, 1:2);    
    
    initial_sector = droneInfo(currentDroneIndex, 19);
    order = selectTiles(initial_sector);
    called_sectors = [initial_sector];
    if x_mile_range == 2
        called_sectors = [called_sectors, order(1)];
    end
    if x_mile_range == 3
        called_sectors = [called_sectors, order(2), order(3)];
    end
    if x_mile_range == 4
        called_sectors = [called_sectors, order(4), order(5)];
    end
    if x_mile_range == 5
        called_sectors = [called_sectors, order(6), order(7), order(8)];
    end
    
    for i = 1:size(droneInfo, 1)
        if i ~= currentDroneIndex
            if ismember(droneInfo(i,19), called_sectors)
                droneIndices = [droneIndices; i];
                % Update columns 15 and 16 to the original drone's x and y
                % respectively (target location)
                droneInfo(i, 15:16) = droneInfo(currentDroneIndex, 1:2);
                % Set column 3 to 1 (verifying)
                droneInfo(i, 3) = 1;
                % Set column 18 to 10 (wait timer)
                droneInfo(i, 18) = 10;
            end
        end
    end
    
    
    

end

