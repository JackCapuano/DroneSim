function [stats] = setup_Stats(stats, percentFaulted, numDrones, maxSearchRadius, droneSpeed, areaHeight, areaWidth, numFaulted, timeStep)

%% MAKE SURE TO CHANGE stats_format IF YOU CHANGE THIS FILE %%

%% Formatting & Setting: %%

% First Column - Fault Stats %
stats{1,2} = "Fault Stats";
    stats{2,1} = "% Faulted";
        stats{2,2}= percentFaulted;
    stats{3,1} = "number of Faulted Agents";
        stats{3,2} = numFaulted;

% Second Column - Sim Stats %
stats{1,5} = "Sim Stats";
    stats{2,4} = "Number of Drones";
        stats{2,5} = numDrones;
    stats{3,4} = "Max Search Radius";
        stats{3,5} = maxSearchRadius;
    stats{4,4} = "Drone Speed";
        stats{4,5} = droneSpeed;
    stats{5,4} = "Time Step";
        stats{5,5} = timeStep;
    stats{6,4} = "areaHeight";
        stats{6,5} = areaHeight;
    stats{7,4} = "areaWidth";
        stats{7,5} = areaWidth;
        
% Third Column - Output Stats %
stats{1,8} = "Output Stats";
    stats{2,7} = "Time to Find";
        stats{2,8} = NaN; % start at NaN to indicate no sim run *yet
    stats{3,7} = "Number of False Positives";
        stats{3,8} = 0;
    stats{4,7} = "Number of False Negatives";
        stats{4,8} = 0;
    stats{5,7} = "Scenario Success?";
        stats{5,8} = NaN;

        


end

