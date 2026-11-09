
function [found, path] = bfs4(map, startRC, goalRC)

    % map: 1 = obstacle, 0 = free
    % startRC and goalRC: [row col]

    n = size(map, 1);

    found = false;
    path = [];

    % Visited cells
    visited = false(n, n);

    % Parent pointers
    parent = zeros(n, n, 2, 'uint16');

    % FIFO queue
    q = zeros(n*n, 2, 'uint16');

    head = 1;
    tail = 1;

    % Add starting position
    q(tail,:) = uint16(startRC);
    tail = tail + 1;

    visited(startRC(1), startRC(2)) = true;

    % Four possible directions
    nbr = int16([-1 0;
                  1 0;
                  0 -1;
                  0 1]);

    while head < tail

        % Remove first element from queue
        u = double(q(head,:));
        head = head + 1;

        % Check if goal is reached
        if isequal(u, goalRC)

            found = true;

            path = reconstruct_path( ...
                parent, startRC, goalRC);

            return;
        end

        % Explore four neighbours
        for k = 1:4

            v = u + double(nbr(k,:));

            r = v(1);
            c = v(2);

            % Check grid boundaries
            if r < 1 || r > n || c < 1 || c > n
                continue;
            end

            % Skip visited cells and obstacles
            if visited(r,c) || map(r,c) == 1
                continue;
            end

            % Mark neighbour as visited
            visited(r,c) = true;

            % Store parent
            parent(r,c,1) = uint16(u(1));
            parent(r,c,2) = uint16(u(2));

            % Add neighbour to queue
            q(tail,:) = uint16([r c]);
            tail = tail + 1;
        end
    end

    % No path found
end
