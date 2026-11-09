
function p = reconstruct_path(parent, startRC, goalRC)

    cur = goalRC;
    p = cur;

    while any(cur ~= startRC)

        pr = parent(cur(1), cur(2), :);

        pr = double([pr(1), pr(2)]);

        % Safety check
        if all(pr == 0)
            p = [];
            return;
        end

        % Add parent to beginning of path
        p = [pr; p];

        cur = pr;
    end
end
