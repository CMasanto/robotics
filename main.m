% file name: main.m
%
% This should be the main program to run your program!!
%

load test1
r0 = 2.0;
minradius = 0.4;

% containing box
B = Box(test.box(1,:),test.box(2,:));

Q = {B};

E = test.env;

[B,Q] = getmixedbox(Q);
while ~isempty(B) % there is a 'mixed' box
    BS = B.split; % all boxes are initilized as 'mixed'
    for i = 1:4
        if BS{i}.radius < minradius
            BS{i}.label = 'small';
        else
            F = featureset(BS{i},E,r0);
            if isempty(F)
                BS{i}.label = 'stuckorfree';
            end
        end
    end
    Q = {Q{:} BS{:}}; % add 4 new boxes to the queue

    [B,Q] = getmixedbox(Q);
end

for i = 1:length(Q)
    if strcmp(Q{i}.label,'stuckorfree')
        if (inclusiontest(Q{i},E))
            Q{i}.label = 'stuck';
        else
            Q{i}.label = 'free';
        end
    end
end

for i = 1:length(Q)
    B = Q{i};
    if strcmp(B.label,'stuck')
        patch(B.x,B.y,'red')
    elseif strcmp(B.label,'free')
        patch(B.x,B.y,'green')
    elseif strcmp(B.label,'small')
%         patch(B.x,B.y,'blue')
    elseif strcmp(B.label,'mixed')
        patch(B.x,B.y,'yellow')
    end
end

%axis equal, axis tight, axis off
