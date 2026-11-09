
function updateDropdown(hAxes, nPaths)

    dd = getappdata(hAxes, 'pathDropdown');

    if ~ishghandle(dd)
        return;
    end

    % Generate labels
    labels = arrayfun( ...
        @(i) sprintf('Path %d', i), ...
        1:nPaths, ...
        'UniformOutput', false);

    % Update dropdown
    set(dd, ...
        'String', [{'Select path'}, labels], ...
        'Value', max(1, min(nPaths+1, ...
                           get(dd, 'Value'))));
end
