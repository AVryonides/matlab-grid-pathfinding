% Compare four-direction BFS and A* on the captured GUI map.
% Each obstacle pair is [x y], transcribed from the screenshot.
obstacles = [
    3 1; 6 1; 16 1; 3 2; 8 2; 11 3; 12 3; 2 4; 4 4;
    16 5; 12 6; 16 6; 10 7; 11 7; 5 8; 13 8; 15 8; 3 9;
    9 11; 13 12; 2 13; 4 13; 5 13; 9 13; 12 13; 16 13;
    11 14; 3 15; 5 16; 9 16
];
blocked = false(16);
blocked(sub2ind(size(blocked), obstacles(:,2), obstacles(:,1))) = true;

figure('Name', 'BFS and A*', 'Color', 'w');
tiledlayout(1,2);
names = {'BFS', 'A*'};
for method = 1:2
    [path, closed] = searchGrid(blocked, method == 2);
    expanded = nnz(closed);
    moves = size(path,1)-1;
    fprintf('%s: %d moves, %d cells expanded\n', names{method}, moves, expanded);
    nexttile;
    cellColors = double(~blocked);
    cellColors(closed) = 2;
    imagesc(cellColors, [0 2]);
    colormap([0 0 0; 1 1 1; 0.72 0.85 1]);
    axis image;
    set(gca, 'XColor', 'k', 'YColor', 'k');
    hold on;
    plot(path(:,1), path(:,2), 'r-', 'LineWidth', 2);
    plot(1,1,'bo','MarkerFaceColor','b');
    plot(16,16,'ro','MarkerFaceColor','r');
    title(sprintf('%s: %d moves, %d expanded', names{method}, moves, expanded), 'Color', 'k');
    xlabel('x');
    ylabel('y');
end
sgtitle('Blue cells: expanded by search | Red line: final route', 'Color', 'k');

function [path, closed] = searchGrid(blocked, useAStar)
    [height, width] = size(blocked);
    goal = numel(blocked);
    [x,y] = meshgrid(1:width, 1:height);
    heuristic = double(useAStar) * (width-x + height-y);
    distance = inf(size(blocked));
    parent = zeros(size(blocked));
    closed = false(size(blocked));
    frontier = 1;
    distance(1) = 0;
    directions = [0 1; 1 0; 0 -1; -1 0];
    path = zeros(0,2);
    while ~isempty(frontier)
        if useAStar
            scores = distance(frontier) + heuristic(frontier);
            candidates = find(scores == min(scores));
            [~, best] = min(heuristic(frontier(candidates)));
            index = candidates(best);
        else
            index = 1;
        end
        current = frontier(index);
        frontier(index) = [];
        closed(current) = true;
        if current == goal
            route = goal;
            while route(end) ~= 1
                route(end+1) = parent(route(end));
            end
            [rows, columns] = ind2sub(size(blocked), flip(route));
            path = [columns(:), rows(:)];
            return;
        end
        [row, column] = ind2sub(size(blocked), current);
        for direction = 1:size(directions,1)
            nextX = column + directions(direction,1);
            nextY = row + directions(direction,2);
            if nextX < 1 || nextX > width || nextY < 1 || nextY > height
                continue;
            end
            next = sub2ind(size(blocked), nextY, nextX);
            if blocked(next) || closed(next) || distance(current)+1 >= distance(next)
                continue;
            end
            if isinf(distance(next))
                frontier(end+1) = next;
            end
            distance(next) = distance(current)+1;
            parent(next) = current;
        end
    end
end
