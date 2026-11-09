
function findPath(startPointEdit, endPointEdit, hAxes)

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

    % Convert coordinates from (x,y) to (row,col)
    [found, pathRC] = bfs4(map, ...
                          [s(2), s(1)], ...
                          [e(2), e(1)]);

    if ~found
        errordlg('No path found.');
        return;
    end

    % Convert back to (x,y)
    pathXY = [pathRC(:,2), pathRC(:,1)];

    % Plot shortest path in red
    plot(hAxes, pathXY(:,1), pathXY(:,2), ...
         'r-', 'LineWidth', 2);

    % Store path
    paths = getappdata(hAxes, 'paths');

    if isempty(paths)
        paths = {};
    end

    paths{end+1} = pathXY;

    setappdata(hAxes, 'paths', paths);
    setappdata(hAxes, 'startPoint', s);
    setappdata(hAxes, 'endPoint', e);

    updateDropdown(hAxes, numel(paths));
end
