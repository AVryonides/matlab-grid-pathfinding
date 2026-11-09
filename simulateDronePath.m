
function simulateDronePath(startPointEdit, endPointEdit, hAxes)

    map = needMap(hAxes);
    if isempty(map)
        return;
    end

    g = size(map, 1);

    dd = getappdata(hAxes, 'pathDropdown');
    paths = getappdata(hAxes, 'paths');

    if isempty(paths)
        errordlg('No paths yet.');
        return;
    end

    idx = get(dd, 'Value') - 1;

    if idx < 1 || idx > numel(paths)
        errordlg('Select a valid path.');
        return;
    end

    % Selected path
    sel = paths{idx};

    [okS, s] = parseXY(get(startPointEdit, 'String'), g);
    [okE, e] = parseXY(get(endPointEdit, 'String'), g);

    if ~okS || ~okE
        return;
    end

    % Redraw map
    cla(hAxes);

    imshow(1 - buildPathMask(map, paths, g), ...
           'Parent', hAxes);

    colormap(hAxes, gray);
    axis(hAxes, 'equal');
    axis(hAxes, 'on');
    hold(hAxes, 'on');

    % Plot start and end
    plot(hAxes, s(1), s(2), 'bo', ...
         'MarkerFaceColor', 'b');

    plot(hAxes, e(1), e(2), 'ro', ...
         'MarkerFaceColor', 'r');

    % Highlight selected path
    plot(hAxes, sel(:,1), sel(:,2), ...
         'k-', 'LineWidth', 5);

    plot(hAxes, sel(:,1), sel(:,2), ...
         'w-', 'LineWidth', 2);

    % Drone marker
    drone = plot(hAxes, sel(1,1), sel(1,2), ...
                 'bo', 'MarkerFaceColor', 'b');

    % Animate along path
    for i = 2:size(sel,1)

        set(drone, ...
            'XData', sel(i,1), ...
            'YData', sel(i,2));

        pause(0.08);
    end
end
