% adding a point to a plot
function addPlotPoint (varargin)
    [x,y]=ginput (1); hold on
    plot(x, y, 'd')
    disp('calling addPlotPoint')
end

% set(gca, 'ButtonDownFcn' , @addPlotPoint)