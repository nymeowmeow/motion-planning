%
% TestScript for Assignment 1
%

%% Define a small map
map = false(10);

% Add an obstacle
map (1:10, 6) = true;
%map(3:10,4) = true;
%map(1:5, 6) = true;

start_coords = [6, 2];
dest_coords  = [8, 9];
%start_coords = [6, 2];
%dest_coords = [8, 9];
%%
close all;
%[route, numExpanded] = DijkstraGrid (map, start_coords, dest_coords);
% Uncomment following line to run Astar
[route, numExpanded] = AStarGrid (map, start_coords, dest_coords);
disp(route);
disp(numExpanded);
