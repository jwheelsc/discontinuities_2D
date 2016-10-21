%%% find length of line in pixels

function [d] = getLineLength(sets)

for i = 1:length(sets)
    lin = sets{i};
    diff = lin(2:end,:)-lin(1:end-1,:);
    d(i) = sum(sqrt((diff(:,1).^2)+(diff(:,2).^2)));
end