
function map = needMap(hAxes)

    if ~isappdata(hAxes, 'map')

        errordlg('Generate a map first.');

        map = [];
        return;
    end

    map = getappdata(hAxes, 'map');
end
