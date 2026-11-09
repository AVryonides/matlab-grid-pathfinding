
function highlightSelectedPath(hAxes)

    map = needMap(hAxes);
    if isempty(map)
        return;
    end

    g = size(map, 1);

    dd = getappdata(hAxes, 'pathDropdown');
    paths = getappdata(hAxes, 'paths');

    if isempty(paths)
        paths = {};
    end

    idx = get(dd, 'Value') - 1;

    % Redraw the map
    cla(hAxes);
    imshow(1 - map, 'Parent', hAxes);
    colormap(hAxes, gray);
    axis(hAxes, 'on');
    hold(hAxes, 'on');

    % Redraw start and end using saved coordinates
    s = getappdata(hAxes, 'startPoint');
    e = getappdata(hAxes, 'endPoint');

    if ~isempty(s)
        sM = plot(hAxes, s(1), s(2), 'bo', ...
                  'MarkerSize', 10, ...
                  'MarkerFaceColor', 'b');
        setappdata(hAxes, 'startMarker', sM);
    end

    if ~isempty(e)
        eM = plot(hAxes, e(1), e(2), 'ro', ...
                  'MarkerSize', 10, ...
                  'MarkerFaceColor', 'r');
        setappdata(hAxes, 'endMarker', eM);
    end

    if idx >= 1 && idx <= numel(paths)

        sel = paths{idx};

        % Plot other paths
        for i = 1:numel(paths)
            if i == idx
                continue;
            end

            p = paths{i};

            plot(hAxes, p(:,1), p(:,2), ...
                 'w-', 'LineWidth', 0.5);
        end

        % Highlight selected path
        plot(hAxes, sel(:,1), sel(:,2), ...
             'k-', 'LineWidth', 5);

        plot(hAxes, sel(:,1), sel(:,2), ...
             'w-', 'LineWidth', 2);
    end

    axis(hAxes, [0.5, g+0.5, 0.5, g+0.5]);
end
