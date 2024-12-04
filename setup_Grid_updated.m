function droneInfo = setup_Grid_updated(height, width, numBlocks, droneInfo)
    totalArea = height * width;
    areaPerBlock = totalArea / numBlocks;
    sideLength = sqrt(areaPerBlock);

    numRows = floor(height / sideLength);
    numColumns = floor(width / sideLength);

    totalBlocks = numRows * numColumns;

    % Calculate side length based on rows and columns
    sideLength = min(height / numRows, width / numColumns);

    % Recalculate the number of rows and columns based on the new side length
    numRows = floor(height / sideLength);
    numColumns = floor(width / sideLength);

    % Adjust side length to ensure even distribution of area among blocks
    sideLength = min(height / numRows, width / numColumns);

    % Update the number of rows and columns
    numRows = floor(height / sideLength);
    numColumns = floor(width / sideLength);

    count = 1;
    for i = 1:numRows
        for j = 1:numColumns
            % Calculate center coordinates
            centerX = (j - 0.5) * sideLength;
            centerY = (i - 0.5) * sideLength;

            % Calculate corner coordinates
            bottomLeft = [(j - 1) * sideLength, (i - 1) * sideLength];
            bottomRight = [j * sideLength, (i - 1) * sideLength];
            topLeft = [(j - 1) * sideLength, i * sideLength];
            topRight = [j * sideLength, i * sideLength];

            % Populate droneInfo matrix
            droneInfo(count, 4:5) = bottomLeft;
            droneInfo(count, 6:7) = [centerX, centerY];
            droneInfo(count, 8:9) = topRight;
            droneInfo(count, 10:11) = bottomRight;
            droneInfo(count, 12:13) = topLeft;

            count = count + 1;
        end
    end

    % Add remaining blocks over the entire area
    remainingBlocks = numBlocks - totalBlocks;
    for k = 1:remainingBlocks
        % Use the entire area for remaining blocks
        centerX = (width / 2);
        centerY = (height / 2);
        sideLength = min(height, width);

        % Populate droneInfo matrix
        droneInfo(count, 4:5) = [(centerX - 0.5 * sideLength), (centerY - 0.5 * sideLength)];
        droneInfo(count, 6:7) = [centerX, centerY];
        droneInfo(count, 8:9) = [(centerX + 0.5 * sideLength), (centerY + 0.5 * sideLength)];
        droneInfo(count, 10:11) = [(centerX + 0.5 * sideLength), (centerY - 0.5 * sideLength)];
        droneInfo(count, 12:13) = [(centerX - 0.5 * sideLength), (centerY + 0.5 * sideLength)];

        count = count + 1;
    end
end