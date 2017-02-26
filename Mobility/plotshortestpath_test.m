clear
% W = [.41 .99 .51 .32 .15 .45 .38 .32 .36 .29 .21];
% W = [51 15 45 38 36 29 12];
% DG = sparse([6 1 2 2 3 4 4 5 5 6 1],[2 6 3 5 4 1 6 3 4 3 5],W); % Directed graph
% s = [2 3 4 5 5 6 1];
% e = [3 4 1 6 4 3 2];
s = [1 3 3 2 6 1 7 4 7 8];
e = [3 4 5 6 7 2 6 5 8 7];
W = [579 40 128 267 163 250 0 115 18 0];
DG = sparse(s,e,W);
% First vector shows start point for edge, second shows end point e.g. edge
% from node 6 to node 2. W shows the weight of each edge
% h = view(biograph(DG,[],'ShowWeights','on'));
% [dist,path,pred] = graphshortestpath(DG,1,6)
% set(h.Nodes(path),'Color',[1 0.4 0.4])
% edges = getedgesbynodeid(h,get(h.Nodes(path),'ID'));
% set(edges,'LineColor',[1 0 0])
% set(edges,'LineWidth',1.5)

UG = tril(DG + DG')
h = view(biograph(UG,[],'ShowArrows','off','ShowWeights','on'))
[dist,path,pred] = graphshortestpath(UG,1,4,'directed',false)
set(h.Nodes(path),'Color',[1 0.4 0.4]) % Changes the colour of the nodes on the shortest path
fowEdges = getedgesbynodeid(h,get(h.Nodes(path),'ID'));
revEdges = getedgesbynodeid(h,get(h.Nodes(fliplr(path)),'ID'));
edges = [fowEdges;revEdges];
set(edges,'LineColor',[1 0 0])
set(edges,'LineWidth',1.5)

[dist1,path1,pred1] = graphshortestpath(UG,2,8,'directed',false)
set(h.Nodes(path1),'Color',[0.4 1 0.4]) % Changes the colour of the nodes on the shortest path
fowEdges1 = getedgesbynodeid(h,get(h.Nodes(path1),'ID'));
revEdges1 = getedgesbynodeid(h,get(h.Nodes(fliplr(path1)),'ID'));
edges1 = [fowEdges1;revEdges1];
set(edges1,'LineColor',[0 1 0])
set(edges1,'LineWidth',1.5)
