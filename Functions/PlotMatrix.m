function PlotMatrix(x,y,C)
% this function will plot an input matrix C against the vectors x and y

if nargin==1
    pc = pcolor(x);
else
    [X,Y] = meshgrid(x,y);
    pc = pcolor(X,Y,C);
end
pc.EdgeColor = 'none';
ax = gca;
ax.Colormap = inferno;

colorbar;

end

