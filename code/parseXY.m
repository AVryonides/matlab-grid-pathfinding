
function [ok, xy] = parseXY(str, gridSize)

    ok = false;
    xy = [];

    % Split input at comma
    s = char(str);
    parts = regexp(s, '\s*,\s*', 'split');

    if numel(parts) ~= 2
        errordlg('Use "x,y"');
        return;
    end

    x = str2double(parts{1});
    y = str2double(parts{2});

    if ~isfinite(x) || ~isfinite(y)
        errordlg('Numbers required.');
        return;
    end

    % Round to integer coordinates
    x = round(x);
    y = round(y);

    % Check boundaries
    if x < 1 || x > gridSize || ...
       y < 1 || y > gridSize

        errordlg(sprintf( ...
            'Coordinates must be within [1..%d].', gridSize));

        return;
    end

    ok = true;
    xy = [x y];
end
