clear
close all

start_points = [1 3 3 2 6 1 7 4 7 8]; % Edge start points
end_points = [3 4 5 6 7 2 6 5 8 7]; % Edge end points
Weights = [579 40 128 267 163 250 0 115 18 0]; % Edge weights
DG = sparse(start_points,end_points,Weights); % Directed Graph
% First vector shows start point for edge, second shows end point e.g. edge
% from node 6 to node 2. W shows the weight of each edge

UG = tril(DG + DG') % Generate Undirected Graph
h = view(biograph(UG,[],'ShowArrows','off','ShowWeights','on'))
[dist,path,pred] = graphshortestpath(UG,1,4,'directed',false)
set(h.Nodes(path),'Color',[1 0.4 0.4]) % Changes the colour of the nodes on the shortest path
fowEdges = getedgesbynodeid(h,get(h.Nodes(path),'ID'));
revEdges = getedgesbynodeid(h,get(h.Nodes(fliplr(path)),'ID'));
edges = [fowEdges;revEdges];
set(edges,'LineColor',[1 0 0])
set(edges,'LineWidth',1.5)

% [dist1,path1,pred1] = graphshortestpath(UG,2,8,'directed',false)
% set(h.Nodes(path1),'Color',[0.4 1 0.4]) % Changes the colour of the nodes on the shortest path
% fowEdges1 = getedgesbynodeid(h,get(h.Nodes(path1),'ID'));
% revEdges1 = getedgesbynodeid(h,get(h.Nodes(fliplr(path1)),'ID'));
% edges1 = [fowEdges1;revEdges1];
% set(edges1,'LineColor',[0 1 0])
% set(edges1,'LineWidth',1.5)
