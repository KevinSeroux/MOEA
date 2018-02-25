% Generate a random real value between min and max
function value = randBetween(min, max)
    value = min + (max - min) * rand();
end

