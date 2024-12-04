function droneInfo = sendVerify_InRangeDrones(droneInfo, x_mile_range, currentDroneIndex)

    droneIndices = [];
    currentDroneLocation = droneInfo(currentDroneIndex, 1:2);

    for i = 1:size(droneInfo, 1)
        if i ~= currentDroneIndex
            distance = sqrt((droneInfo(i, 1) - currentDroneLocation(1))^2 + (droneInfo(i, 2) - currentDroneLocation(2))^2);
            if distance <= x_mile_range
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

