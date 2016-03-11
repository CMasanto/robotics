% This code demonstrates the rotation of a set of points
% about the axes x, y, and z.
% a) How can you build the rotation matrix R using the function rpy2r
% from the robotics toolbox?
% b) Study the class Quaternion of the robotics toolbox.
% Let qx and qy be the quaternions for Rx and Ry, respectively.
% What's the quaternion corresponding to Rx*Ry?
% c) Let q = a+bi+cj+dk be the quaternion corresponding to a rotation R.
% What can you say about the constants b, c, and d when R is a rotation about
% the x, y, and z axis, respectively?
% d) Let q = a+bi+cj+dk be the quaternion corresponding to a rotation of
% alpha degrees about the x axis. What' the quaternion corresponding to a
% rotation of -alpha degres about the x axis?

x = 0:0.1:1;
y = zeros(size(x));
z = y;
X = [x; y; z];
l = [-2 2];

figure('position', [100, 100, 1000, 300])
ax = subplot(1,3,1);
plot(x,y,'o'), xlabel('x'), ylabel('y'), title('z view (before)'), xlim(ax,l), ylim(ax,l)
ax = subplot(1,3,2);
plot(x,z,'o'), xlabel('x'), ylabel('z'), title('y view (before)'), xlim(ax,l), ylim(ax,l)
ax = subplot(1,3,3);
plot(y,z,'o'), xlabel('y'), ylabel('z'), title('x view (before)'), xlim(ax,l), ylim(ax,l) 

theta = pi/4;
Rx = [1 0           0         ; ...
      0 cos(theta) -sin(theta); ...
      0 sin(theta) cos(theta)];
  
theta = pi/4;
Ry = [cos(theta)  0 sin(theta); ...
      0           1 0          ; ...
      -sin(theta) 0 cos(theta)];
  
theta = pi/4;
Rz = [cos(theta) -sin(theta) 0; ...
      sin(theta) cos(theta)  0; ...
      0          0           1];

R = Rx*Rz; % rotation

X = R*X;
x = X(1,:);
y = X(2,:);
z = X(3,:);

figure('position', [200, 200, 1000, 300])
ax = subplot(1,3,1);
plot(x,y,'o'), xlabel('x'), ylabel('y'), title('z view (after)'), xlim(ax,l), ylim(ax,l)
ax = subplot(1,3,2);
plot(x,z,'o'), xlabel('x'), ylabel('z'), title('y view (after)'), xlim(ax,l), ylim(ax,l)
ax = subplot(1,3,3);
plot(y,z,'o'), xlabel('y'), ylabel('z'), title('x view (after)'), xlim(ax,l), ylim(ax,l)