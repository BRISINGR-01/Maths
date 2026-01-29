clearvars -except out
close all
clc

% Load variables
phi = out.phi;
t   = phi.time;
ang = phi.signals.values;

L  = 0.20;
y0 = -0.10;

% Drawing figure
fig = figure('Color','w');
axis equal
axis([-0.25 0.25 -0.25 0.35])
grid on
hold on
xlabel('x [m]')
ylabel('y [m]')
title('Inverted Pendulum with Disturbance Button')

% Store disturbance 
fig.UserData.disturbance = 0;

% Actuator
magnet_y = y0 + L + 0.05;
rectangle('Position',[-0.06 magnet_y 0.12 0.03],'Curvature',0.2,'FaceColor',[0.25 0.25 0.25]);

text(0, magnet_y + 0.045, 'MAGNET','HorizontalAlignment','center','FontWeight','bold');

% Pivot point
plot(0, y0, 'ko', 'MarkerSize',6, 'MarkerFaceColor','k');

% Pendulum initial conditions
x0 = L * sin(ang(1));
y0p = y0 + L * cos(ang(1));

hRod = plot([0 x0], [y0 y0p], 'b', 'LineWidth',3);
hBob = plot(x0, y0p, 'ro', 'MarkerSize',8, 'MarkerFaceColor','r');

% Disturb button
uicontrol('Style','pushbutton', ...
          'String','Disturb pendulum', ...
          'FontSize',11, ...
          'Position',[20 20 170 35], ...
          'Callback',@disturb_callback);

% Animation of pendulum 
step = 5;
k = 1;

while ishandle(fig)

    if k > length(t)
        k = length(t);   % keep last simulated value
    end

    disturbance = fig.UserData.disturbance;
    a = ang(k) + disturbance;

    x = L * sin(a);
    y = y0 + L * cos(a);

    set(hRod,'XData',[0 x],'YData',[y0 y]);
    set(hBob,'XData',x,'YData',y);

    drawnow;

    if ~ishandle(fig)
     break
    end

    fig.UserData.disturbance = 0.95 * fig.UserData.disturbance;


    k = k + step;
end



% Callback 
function disturb_callback(src,~)
    fig = ancestor(src,'figure');
    fig.UserData.disturbance = fig.UserData.disturbance + 0.05;
end
