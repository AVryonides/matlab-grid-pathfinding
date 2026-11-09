
function g = clampInt(x, lo, hi)

    if ~isfinite(x)
        x = lo;
    end

    x = round(x);

    g = max(lo, min(hi, x));
end
