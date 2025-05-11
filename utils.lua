math.randomseed(os.time())

function sign(num)
    if num >= 0 then
        return 1
    else
        return -1
    end
end

function random_disjoint(a1, b1, a2, b2)
    if math.random() < 0.5 then
        return math.random(a1, b1)
    else
        return math.random(a2, b2)
    end
end

function euclidian_distance(x1, y1, x2, y2)
    return math.sqrt((x1 - x2)^2 + (y1 - y2)^2)
end