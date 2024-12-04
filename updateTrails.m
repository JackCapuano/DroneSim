function newTrails = updateTrails(oldTrails, positions)
    % Update drone trails with current positions
    newTrails = oldTrails;
    for i = 1:numel(oldTrails)
        newTrails{i} = [oldTrails{i}; positions(i, 1:2)];
    end
end
