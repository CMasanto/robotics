 % file: envs2.m
%
% This file sets up the "test2" data structures
%	which corresponds to a complete set of inputs
%	for the planning algorithm.
%
% The "test" object is saved in a file called "test1.mat"
test2.radius = 2.0;
test2.start = [-1.5; 3.75];
test2.goal = [4; -6.75];
test2.eps = 0.2; % epsilon
test2.strategy = 'ran';		% random strategy
test2.box = [-8 8 8 -8; -8 -8 8 8];
% see envs2.fig:
test2.env = {
		[-5.5, -4.5, -4.5, -5.5; -5.5, -5.5, 1, 1],...
		[-2, 1, 1, -5, -5, 0, 0, -2; 1.5, 1.5, 6, 6, 5, 5, 2.5, 2.5],...
		[-3, 4.5, 4.5, -3; -2.5, -2.5, -1.5, -1.5],...
		[1, 2.5, 2.5, 5, 5, 1; -7, -7, -5.5, -5.5, -4, -4],...
		[2.5, 5, 5; 3, 0, 3],...
		[4, 7.5, 5, 4; 5.5, 7.5, 7.5, 7] };

% Displays the background box:
patch(test2.box(1,:),test2.box(2,:),'y')

% axis tight, axis equal, axis off

for i = 1:length(test2.env)
    p = test2.env{i};
    patch(p(1,:),p(2,:),'g')
end

% Saves the "test2" object in a file called "test2.mat":
save test2 test2
