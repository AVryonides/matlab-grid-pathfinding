
function mask = buildPathMask(map, paths, g)

    % Copy original map
    mask = map;

    for i = 1:numel(paths)

        p = paths{i};

        % Convert (x,y) into matrix indices
        idx = sub2ind([g g], p(:,2), p(:,1));

        % Mark path cells as free
        mask(idx) = 0;
    end
end
