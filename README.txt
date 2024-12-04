DroneSim Research by Jack Capuano, Austen Pallen
Last Updated: 3/26/2024

_format.xlsx's are provided for explanation of the main matrices:

    droneInfo contains information on drones, each row is a seperate drone
        Column 1: current X value of the drone
        Column 2: current Y value of the drone
        Column 3: reset status (what action the drone is doing: selected search pattern = 0 , verifying = 1, waiting = 2)
        Columns 4-13: Coordinates (x,y) for the drone's grid corners and middle (TL = top left, M = middle, etc)
        Column 14: grid location is which point on the grid square the drone is currently at (order of movement)
        Column 15-16: x and y coordinate of the potential find spot the drone is verifying 
        Column 17: faulted - 0 is not faulted, 1 is faulted
        Column 18: reset timer, timer to wait at a verify location before returning

    stats contains recorded statistics from a running simulation
        Includes its own labels in the matrix & _format.xlsx documentation, self explanatory

    accum_stats records statistics for multiple running simulations
        template follows stats, but without the labels (just numbers)

    avg_stats records statistics for all running simulations divided by total runs
            template follows stats, but without the labels (just numbers)

    potentialFindsMatrix contains information on potential finds, each row is a potential* find location
        Column 1-2: the X and Y coordinates of the potential find location
        Column 3: The # of drones that have (succesfully) verified (found a target) at this location
        Column 4: Set to 1 if the drone (and therefore the find) is faulted (false positive)
        Column 5: set to 0 if we need to send more drones (every time there is a find) and 1 if not (between finds)





