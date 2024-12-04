function newLocation = moveTarget_Random(targetLocation, timeStep, speed, areaHeight, areaWidth)
    % Generate random displacement based on speed and time step
    displacement = speed * timeStep * [randn(), randn()];

    % Update target location
    newLocation = targetLocation + displacement;

    % Ensure target stays within the boundaries
    newLocation(1) = max(0, min(areaWidth, newLocation(1)));
    newLocation(2) = max(0, min(areaHeight, newLocation(2)));
end