function order = selectTiles(startTile)
    switch startTile
        case 1
            order = [2, 4, 5, 3, 7, 6, 8, 9];
        case 2
            order = [1, 3, 5, 4, 6, 8, 7, 9];
        case 3
            order = [2, 6, 5, 1, 9, 4, 8, 7];
        case 4
            order = [1, 5, 7, 2, 8, 6, 3, 9];
        case 5
            order = [2, 6, 8, 4, 1, 3, 9, 7];
        case 6
            order = [3, 5, 9, 2, 8, 4, 1, 7];
        case 7
            order = [4, 8, 5, 1, 9, 2, 6, 3];
        case 8
            order = [7, 5, 9, 4, 6, 2, 1, 3];
        case 9
            order = [6, 8, 5, 3, 7, 2, 4, 1];
        otherwise
            error('Start tile must be a number between 1 and 9');
    end
end
