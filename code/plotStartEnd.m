
function plotStartEnd(startPointEdit, endPointEdit, hAxes)

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

    if map(s(2), s(1)) == 1
        errordlg('Start is an obstacle.');
        return;
    end

    if map(e(2), e(1)) == 1
        errordlg('End is an obstacle.');
        return;
    end

    % Remove previous markers
    oldS = getappdata(hAxes, 'startMarker');
    oldE = getappdata(hAxes, 'endMarker');

    if ishghandle(oldS)
        delete(oldS);
    end

    if ishghandle(oldE)
        delete(oldE);
    end

    % Plot start in blue
    sM = plot(hAxes, s(1), s(2), 'o', ...
              'MarkerSize', 10, ...
              'MarkerEdgeColor', 'blue', ...
              'MarkerFaceColor', 'blue');

    % Plot end in red
    eM = plot(hAxes, e(1), e(2), 'o', ...
              'MarkerSize', 10, ...
              'MarkerEdgeColor', 'red', ...
              'MarkerFaceColor', 'red');

    % Save state
    setappdata(hAxes, 'startMarker', sM);
    setappdata(hAxes, 'endMarker', eM);
    setappdata(hAxes, 'startPoint', s);
    setappdata(hAxes, 'endPoint', e);
end
