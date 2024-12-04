function [potentialFindsMatrix] = increaseBuffer(potentialFindsMatrix,row_index)
% takes in potentialFindsMatrix and a specific potentialFind and outputs
% the increased potentialFindsMatrix
potentialFindsMatrix(row_index, 5) = 1; % new find, send more drones
    if potentialFindsMatrix(row_index, 3) >= 0 && potentialFindsMatrix(row_index, 3) < 20 %between 0 and 20
        potentialFindsMatrix(row_index, 3) = potentialFindsMatrix(row_index, 3) + 6; %increase by 4
        %disp("Increase by 4");
    elseif potentialFindsMatrix(row_index, 3) >= 20 && potentialFindsMatrix(row_index, 3) < 40%between 20 and 40
        potentialFindsMatrix(row_index, 3) = potentialFindsMatrix(row_index, 3) + 8;%increase by 6
        %disp("Increase by 6");
    elseif potentialFindsMatrix(row_index, 3) >= 40 && potentialFindsMatrix(row_index, 3) < 60%between 40 and 60
        potentialFindsMatrix(row_index, 3) = potentialFindsMatrix(row_index, 3) + 12;%increase by 8
        %disp("Increase by 8");
    elseif potentialFindsMatrix(row_index, 3) >= 60 && potentialFindsMatrix(row_index, 3) < 80%between 60 and 80
        potentialFindsMatrix(row_index, 3) = potentialFindsMatrix(row_index, 3) + 14;%increase by 12
        %disp("Increase by 12");
    elseif potentialFindsMatrix(row_index, 3) >= 80 && potentialFindsMatrix(row_index, 3) <= 100%between 80 and 100
        potentialFindsMatrix(row_index, 3) = potentialFindsMatrix(row_index, 3) + 16;%increase by 14
        %disp("Increase by 14");
    end

end

