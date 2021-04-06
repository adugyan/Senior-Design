function [out] = plot_polygon_smile(input)

gcf; hold on; % brings up current figure
xvals = input(1,:); % separates matrix into x,y positions
yvals = input(2,:);
h_poly = plot(xvals,yvals,'b-','Linewidth',1.5); % plots lines connecting sequence of vertices
h_start =plot(xvals(1),yvals(1)); % colors the first vertex provided
out=[h_poly;h_start]; % consolidates the handles of the plotting in case changes requested
axis equal