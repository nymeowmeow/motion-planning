function route = GradientBasedPlanner (f, start_coords, end_coords, max_its)
% GradientBasedPlanner : This function plans a path through a 2D
% environment from a start to a destination based on the gradient of the
% function f which is passed in as a 2D array. The two arguments
% start_coords and end_coords denote the coordinates of the start and end
% positions respectively in the array while max_its indicates an upper
% bound on the number of iterations that the system can use before giving
% up.
% The output, route, is an array with 2 columns and n rows where the rows
% correspond to the coordinates of the robot as it moves along the route.
% The first column corresponds to the x coordinate and the second to the y coordinate

[gx, gy] = gradient (-f);

%%% All of your code should be between the two lines of stars.
% *******************************************************************
route = start_coords;
found = false;
current = start_coords;
for i=1:max_its,
    x = current(1);
    y = current(2);

    %if x < 1,
        %x = single(1.0);
    %elseif x > size(f, 1),
        %x = single(size(f,1));
    %end
    %if y < 1,
        %y = single(1.0);
    %elseif y > size(f, 2),
        %y = single(size(f, 2));
    %end
    %gradx = interp2(gx, y, x);
    %grady = interp2(gy, y, x);
    gradx = gx(round(y), round(x));
    grady = gy(round(y), round(x));
    g = [ gradx, grady ];
    g = g/norm(g);
    %if isnan(g(1)) || isnan(g(2))
        %disp('nan');
    %end
    if norm(g) < 1e-9,
        break;
    end
    current = [ x + g(1), y + g(2)];
    %if norm(current - route(end, :)) > 1,
        %alpha = norm(current - route(end, :));
        %current = [ x + g(1)/alpha, y + g(2)/alpha];
    %end
    route = [ route; current ];
    if norm(current - end_coords) < 2,
        found = true;
        break;
    end
end

if ~found,
    route = 0;
end
% *******************************************************************
end