% function [potentialFindsMatrix] = decreaseBuffer(potentialFindsMatrix)
% % takes in potentialFindsMatrix and outputs
% % the decreased initialized finds in potentialFindsMatrix
% 
%     for row_index = 1:size(potentialFindsMatrix, 1)
%         if potentialFindsMatrix(row_index, 3) >= 0 && potentialFindsMatrix(row_index, 3) < 20 %between 0 and 20
%             potentialFindsMatrix(row_index, 3) = potentialFindsMatrix(row_index, 3) - 0.1; %increase by 4
%             %disp("Increase by 4");
%         elseif potentialFindsMatrix(row_index, 3) >= 20 && potentialFindsMatrix(row_index, 3) < 40%between 20 and 40
%             potentialFindsMatrix(row_index, 3) = potentialFindsMatrix(row_index, 3) - 0.2 ;%increase by 6
%             %disp("Increase by 6");
%         elseif potentialFindsMatrix(row_index, 3) >= 40 && potentialFindsMatrix(row_index, 3) < 60%between 40 and 60
%             potentialFindsMatrix(row_index, 3) = potentialFindsMatrix(row_index, 3) - 0.3;%increase by 8
%             %disp("Increase by 8");
%         elseif potentialFindsMatrix(row_index, 3) >= 60 && potentialFindsMatrix(row_index, 3) < 80%between 60 and 80
%             potentialFindsMatrix(row_index, 3) = potentialFindsMatrix(row_index, 3) - 0.4;%increase by 12
%             %disp("Increase by 12");
%         elseif potentialFindsMatrix(row_index, 3) >= 80 && potentialFindsMatrix(row_index, 3) <= 100%between 80 and 100
%             potentialFindsMatrix(row_index, 3) = potentialFindsMatrix(row_index, 3) - 0.5;%increase by 14
%             %disp("Increase by 14");
%         end
%     end
% 
% end



function [potentialFindsMatrix] = decreaseBuffer(potentialFindsMatrix)
    % Define condition masks for each range
    mask1 = potentialFindsMatrix(:, 3) >= 0 & potentialFindsMatrix(:, 3) < 20;
    mask2 = potentialFindsMatrix(:, 3) >= 20 & potentialFindsMatrix(:, 3) < 40;
    mask3 = potentialFindsMatrix(:, 3) >= 40 & potentialFindsMatrix(:, 3) < 60;
    mask4 = potentialFindsMatrix(:, 3) >= 60 & potentialFindsMatrix(:, 3) < 80;
    mask5 = potentialFindsMatrix(:, 3) >= 80 & potentialFindsMatrix(:, 3) <= 100;

    % Update potentialFindsMatrix based on conditions
    potentialFindsMatrix(mask1, 3) = potentialFindsMatrix(mask1, 3) - 0.1;
    potentialFindsMatrix(mask2, 3) = potentialFindsMatrix(mask2, 3) - 0.2;
    potentialFindsMatrix(mask3, 3) = potentialFindsMatrix(mask3, 3) - 0.3;
    potentialFindsMatrix(mask4, 3) = potentialFindsMatrix(mask4, 3) - 0.4;
    potentialFindsMatrix(mask5, 3) = potentialFindsMatrix(mask5, 3) - 0.5;
end