function node = removeDuplicates(node)
% Function to remove the duplicate positions added to avoid indexing errors
duplicates = length(node.position{4}) - (length(node.position{3}) + length(node.position{1}));
node.position{4} = node.position{4}(1:end-duplicates,:);
