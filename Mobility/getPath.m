function [path] = getPath(edge_start_points,edge_end_points,weights,start_node,end_node)
% getPath   Calculates the shortest path between two nodes in an 
%           undirected graph
%
% Inputs:   Start points for each edge in the graph
%           End points for each edge in the graph
%           Weights for each edge
%           Start and end nodes to calculate the shortest path 
%           between
%
% Outputs:  Path between input nodes calculated using Dijkstra's 
%           algorithm

DG = sparse(edge_start_points,edge_end_points,weights);
UG = tril(DG + DG');
% h = view(biograph(UG,[],'ShowArrows','off','ShowWeights','on'));
[~,path,~] = graphshortestpath(UG,start_node,end_node,'directed',false);
