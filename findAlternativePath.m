
function findAlternativePath(startPointEdit, endPointEdit, hAxes)

    map = needMap(hAxes);
    if isempty(map)
        return;
    end

    g = size(map, 1);

    [okS, s] = parseXY(get(startPointEdit, 'String'), g);
    [okE, e] = parseXY(get(endPointEdit, 'String'), g);

    if ~okS || ~okE
        return;
    end

    if map(s(2), s(1)) == 1 || map(e(2), e(1)) == 1
        errordlg('Points must be obstacle-free.');
        return;
    end

    % Try to find a reachable checkpoint
    foundAlternative = false;

    for tries = 1:5000

        cp = [randi([1 g]), randi([1 g])];

        if map(cp(2), cp(1)) == 1 || ...
           isequal(cp, s) || isequal(cp, e)
            continue;
        end

        % Start to checkpoint
        [f1, p1] = bfs4(map, ...
                        [s(2), s(1)], ...
                        [cp(2), cp(1)]);

        if ~f1
            continue;
        end

        % Checkpoint to end
        [f2, p2] = bfs4(map, ...
                        [cp(2), cp(1)], ...
                        [e(2), e(1)]);

        if f2
            foundAlternative = true;
            break;
        end
    end

    if ~foundAlternative
        errordlg('No reachable checkpoint found.');
        return;
    end

    % Combine the two paths
    altRC = [p1; p2(2:end,:)];

    % Convert to (x,y)
    altXY = [altRC(:,2), altRC(:,1)];

    % Plot alternative path in dashed blue
    plot(hAxes, altXY(:,1), altXY(:,2), ...
         'b--', 'LineWidth', 2);

    % Plot checkpoint in green
    plot(hAxes, cp(1), cp(2), 'go', ...
         'MarkerSize', 8, ...
         'MarkerFaceColor', 'g');

    % Store alternative path
    paths = getappdata(hAxes, 'paths');

    if isempty(paths)
        paths = {};
    end

    paths{end+1} = altXY;

    setappdata(hAxes, 'paths', paths);
    setappdata(hAxes, 'startPoint', s);
    setappdata(hAxes, 'endPoint', e);

    % Export alternative path
    writematrix(altXY, 'alternativePath.csv');

    updateDropdown(hAxes, numel(paths));
end
