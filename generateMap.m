
function generateMap(gridSizeEdit, obstacleDensityEdit, hAxes)

    gridSize = clampInt( ...
        str2double(get(gridSizeEdit, 'String')), 2, 512);

    p = str2double(get(obstacleDensityEdit, 'String'));

    if ~isfinite(p) || p < 0 || p > 1
        errordlg('Obstacle density must be in [0,1].');
        return;
    end

    % 1 = obstacle, 0 = free
    map = rand(gridSize) < p;

    % Display map
    cla(hAxes);
    imshow(1 - map, 'Parent', hAxes);
    colormap(hAxes, gray);
    axis(hAxes, 'equal');
    axis(hAxes, 'on');
    hold(hAxes, 'on');

    % Reset shared state
    setappdata(hAxes, 'map', map);
    setappdata(hAxes, 'paths', {});
    setappdata(hAxes, 'startPoint', []);
    setappdata(hAxes, 'endPoint', []);
    setappdata(hAxes, 'startMarker', []);
    setappdata(hAxes, 'endMarker', []);

    % Reset dropdown
    dd = getappdata(hAxes, 'pathDropdown');

    if ishghandle(dd)
        set(dd, 'String', {'Select path'}, 'Value', 1);
    end
end
