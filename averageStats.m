function  avg_stats = averageStats(avg_stats, numRuns)

global accum_stats;
avg_stats(2,8) = accum_stats(2,8)/numRuns; % TTF

end

