% Clear workspace and figures
clear
hold off;
clf
hold on;

% Define region size and limits
space_size = 10;
extrema_l = -floor(space_size/2);
extrema_h = floor(space_size/2);

% Initiate Variables and region matrix
w = [1 -1;2 -1;1 1];
b = [-1;-1;3];
wo = [1, 1, 1];
bo = -2.5;

x = zeros([space_size space_size]);

% Plot decision lines
plt_weights(w, b, extrema_l, extrema_h)

% Pass nodes through the LTG to determine state
x = activate_nodes(w, b, x, wo, bo, extrema_l);

% Plot nodes
plt_space(x, extrema_l, extrema_h)

% Label Axes then draw
ylabel('X2')
xlabel('X1')
title(sprintf('Single-Layer LTG NN\n'))

drawnow

function x = activate_nodes(w, b, x, wo, bo, extrema_l)
    % Which node should be active based on LTG
    for i = 1:numel(x)
        [x2, x1] = ind2sub(length(x), i);
        
        act_array = w*[x1 + extrema_l; x2 + extrema_l] + b;
        act_array = double(act_array >= 0);
        out_array = wo*act_array + bo;
        
        if sum(out_array) >= 0
            x(i) = 1;
        else
            x(i) = 0;
        end
    end
end

function plt_weights(w, b, extrema_l, extrema_h)
    %  m = -w1/w2   b = -w0/w2
    px1 = extrema_l;
    px2 = extrema_h;
    
    % Plot the decision lines using w1x1 + w2x2 +w3x3 = 0 
    for i = 1:(length(w))
        m = -1*(w(i,1)/w(i,2));
        yint = -1*(b(i,1)/w(i,2));
        py1 = (m*px1) + yint;
        py2 = (m*px2) + yint;
        plot([px1, px2], [py1, py2],'blue');
    end
end

function plt_space(x, extrema_l, extrema_h)
    % Plot the nodes and visually differentiate based on state
    for i = 1:numel(x)
        [r, c] = ind2sub(length(x),i);
        if x(i) > 0
            scatter(c+extrema_l,r+extrema_l, 45, 'filled', 'bo');
        else
            scatter(c + extrema_l, r + extrema_l, 75, 'r*');
        end
    end
    axis([extrema_l, extrema_h, extrema_l, extrema_h])
end


