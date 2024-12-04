function visualizeSimulation(areaWidth, areaHeight, targetLocation, droneInfo, droneTrails)
    % Visualize the simulation
    
    % Clear previous plot
    clf;
    
    % Plot the target location
    plot(targetLocation(1), targetLocation(2), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
    hold on;
    
    % Plot drone positions (black for unfaulted, red for faulted)
    for i = 1:size(droneInfo, 1)
        if droneInfo(i, 17) == 0
            % Plot in black if the 17th column is 0
            plot(droneInfo(i, 1), droneInfo(i, 2), 'ko', 'MarkerSize', 5, 'LineWidth', 1);
        else
            % Plot in red if the 17th column is 1
            plot(droneInfo(i, 1), droneInfo(i, 2), 'ro', 'MarkerSize', 5, 'LineWidth', 1);
        end
    end
    
    % Plot the drone trails
    for i = 1:numel(droneTrails)
        plot(droneTrails{i}(:, 1), droneTrails{i}(:, 2), 'b-', 'LineWidth', 0.5);
    end
    
    % Set plot limits
    xlim([0, areaWidth]);
    ylim([0, areaHeight]);
    
    % Set axis labels
    xlabel('Miles');
    ylabel('Miles');
    
    % Add title
    title('Drone Search Simulation');
    
    % Add legend
    % legend('Target', 'Drones');
    
    % Add grid
    grid on;
    % Set grid lines every 1 unit
        ax = gca; % Get current axes
        ax.XAxis.MinorTick = 'on'; % Turn on minor ticks for x-axis
        ax.YAxis.MinorTick = 'on'; % Turn on minor ticks for y-axis
        ax.XAxis.MinorTickValues = 0:1:8; % Set minor tick values for x-axis
        ax.YAxis.MinorTickValues = 0:1:12; % Set minor tick values for y-axis
    
    % Refresh the plot
    drawnow;
end
