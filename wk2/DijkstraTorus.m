function route = DijkstraTorus (input_map, start_coords, dest_coords)
% Run Dijkstra's algorithm on a grid.
% Inputs : 
%   input_map : a logical array where the freespace cells are false or 0 and
%      the obstacles are true or 1
%   start_coords and dest_coords : Coordinates of the start and end cell
%       respectively, the first entry is the row and the second the column.
% Output :
%   route : An array containing the linear indices of the cells along the
%    shortest route from start to dest or an empty array if there is no
%    route.

% set up color map for display
% 1 - white - clear cell
% 2 - black - obstacle
% 3 - red = visited
% 4 - blue  - on list
% 5 - green - start
% 6 - yellow - destination

cmap = [1 1 1; ...
        0 0 0; ...
        1 0 0; ...
        0 0 1; ...
        0 1 0; ...
        1 1 0];

colormap(cmap);


[nrows, ncols] = size(input_map);

% map - a table that keeps track of the state of each grid cell
map = zeros(nrows,ncols);

map(~input_map) = 1;  % Mark free cells
map(input_map)  = 2;  % Mark obstacle cells

% Generate linear indices of start and dest nodes
start_node = sub2ind(size(map), start_coords(1), start_coords(2));
dest_node  = sub2ind(size(map), dest_coords(1),  dest_coords(2));

map(start_node) = 5;
map(dest_node)  = 6;

% Initialize distance array
distances = Inf(nrows,ncols);

% For each grid cell this array holds the index of its parent
parent = zeros(nrows,ncols);

distances(start_node) = 0;

    function  res = processNode(x, y, parentnode, d)
        res = 0;
    
        if x >=1 && y >= 1 && x <= 180 && y <= 180 && (map(x, y) == 1 || map(x,y) == 6 || map(x,y) == 4),
            if map(x,y) == 6,
                res = 1;
            end

            %if distances(x,y) > d+1,
                %distances(x,y) = d+1;
                %parent(x,y) = parentnode;
            %end
            %if map(x,y) == 1
                %numExpanded = numExpanded + 1;
                %map(x,y) = 4;
            %end
            update(x,y,d+2,parentnode);
        end
    end

% Main Loop
while true
    
    % Draw current map
    map(start_node) = 5;
    map(dest_node) = 6;
    
    image(1.5, 1.5, map);
    grid on;
    axis image;
    drawnow;
    
    % Find the node with the minimum distance
    [min_dist, current] = min(distances(:));
    
    if ((current == dest_node) || isinf(min_dist))
        break;
    end;
    
    % Update map
    map(current) = 3;         % mark current node as visited
    distances(current) = Inf; % remove this node from further consideration
    
    % Compute row, column coordinates of current node
    [i, j] = ind2sub(size(distances), current);
    
    % Visit each neighbor of the current node and update the map, distances
    % and parent tables appropriately.
   
    %%% All of your code should be between the two lines of stars. 
    % ******************************************************************* 
    tmp = i;
    if tmp == 1,
        tmp = 180;
    else
        tmp = i-1;
    end
    if processNode(tmp, j, current, min_dist) == 1,
        break;
    end
    tmp = j;
    if tmp == 1,
        tmp = 180;
    else
        tmp = j-1;
    end
    if processNode(i, tmp, current, min_dist) == 1,
        break;
    end
    tmp = j;
    if tmp == 180,
        tmp = 1;
    else
        tmp = j+1;
    end
    if processNode(i, tmp, current, min_dist) == 1,
        break;
    end
    tmp = i;
    if tmp == 180,
        tmp = 1;
    else
        tmp = i+1;
    end
    if processNode(tmp, j, current, min_dist) == 1,
        break;
    end
    % *******************************************************************
end

if (isinf(distances(dest_node)))
    route = [];
else
    route = [dest_node];
    
    while (parent(route(1)) ~= 0)
        route = [parent(route(1)), route];
    end
    
    % Snippet of code used to visualize the map and the path
    for k = 2:length(route) - 1        
        map(route(k)) = 7;
        pause(0.1);
        image(1.5, 1.5, map);
        grid on;
        axis image;
    end
end

    function update (i,j,d,p)
        if ( (map(i,j) ~= 2) && (map(i,j) ~= 3) && (map(i,j) ~= 5) && (distances(i,j) > d) )
            distances(i,j) = d;
            map(i,j) = 4;
            parent(i,j) = p;
        end
    end

end
