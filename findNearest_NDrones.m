function [drone_ids] = findNearest_NDrones(droneInfo, i, num_verify)
%FINDNEAREST_NDRONES finds the nearest n drones to drone i

drone_i_index = i; % Change this index to the desired drone
n = num_verify; % Number of nearby drones to return


% Extract coordinates of drone i
drone_i_coords = droneInfo(drone_i_index, 1:2);

% Compute Euclidean distances between drone i and all other drones
distances = sqrt(sum((droneInfo(:, 1:2) - drone_i_coords).^2, 2));

% Sort distances and get indices of nearest drones
[sorted_distances, sorted_indices] = sort(distances);

% Exclude the current drone itself from the nearest list
nearest_indices = sorted_indices(sorted_indices ~= drone_i_index);

% Select the nearest n drones
nearest_n_indices = nearest_indices(1:n);

drone_ids = nearest_n_indices;
end

