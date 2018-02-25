% Return a sorted collection with a function
% In:
% - fun Function returning the value used to sort the collection. It takes
%   one element from the collection
% - collection The array to sort
% - direction (optional) 'ascend' or 'descend'
% Out :
% - sortedCollection The sorted collection
% - values Returned values with input function
function [sortedCollection, values] = sortfun(fun, collection, direction)
    if nargin <= 2
        direction = 'ascend';
    end

    collectionSize = length(collection);
    values = zeros(1, collectionSize);
    
    % Extract current values
    for i=1:collectionSize
        values(i) = fun(collection(i));
    end
    
    % Get indexes of sorted values
    [values, sortedIdx] = sort(values, direction);
    
    % Reorder the population and the objective values
    sortedCollection = collection(sortedIdx);
end

