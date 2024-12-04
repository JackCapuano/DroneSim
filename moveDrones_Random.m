function newPositions = moveDrones_Random(droneInfo, speed, timeStep)
    % Random Movement
        % Change all the positions
        newPositions = droneInfo + speed * timeStep * randn(size(droneInfo));        
        
end