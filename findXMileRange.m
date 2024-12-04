function x_mile_range = findXMileRange(potentialFindsMatrix, row_index)

%       Old Range - works with old sendVerify_InRangeDrones
%     if potentialFindsMatrix(row_index, 3) >= 0 && potentialFindsMatrix(row_index, 3) < 20
%         x_mile_range = 2;
%     elseif potentialFindsMatrix(row_index, 3) >= 20 && potentialFindsMatrix(row_index, 3) < 40
%         x_mile_range = 3;
%     elseif potentialFindsMatrix(row_index, 3) >= 40 && potentialFindsMatrix(row_index, 3) < 60
%         x_mile_range = 4;
%     elseif potentialFindsMatrix(row_index, 3) >= 60 && potentialFindsMatrix(row_index, 3) < 80
%         x_mile_range = 5;
%     elseif potentialFindsMatrix(row_index, 3) >= 80 && potentialFindsMatrix(row_index, 3) <= 100
%         x_mile_range = 6;
%     end

%       New Range - works with new sendVerify_InNestDrones
    if potentialFindsMatrix(row_index, 3) >= 0 && potentialFindsMatrix(row_index, 3) < 20
        x_mile_range = 2;
    elseif potentialFindsMatrix(row_index, 3) >= 20 && potentialFindsMatrix(row_index, 3) < 40
        x_mile_range = 3;
    elseif potentialFindsMatrix(row_index, 3) >= 40 && potentialFindsMatrix(row_index, 3) < 60
        x_mile_range = 4;
    elseif potentialFindsMatrix(row_index, 3) >= 60 && potentialFindsMatrix(row_index, 3) < 80
        x_mile_range = 5;
    elseif potentialFindsMatrix(row_index, 3) >= 80 && potentialFindsMatrix(row_index, 3) <= 100
        x_mile_range = 6;
    end


end


