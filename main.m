% file name: main.m
%
% This should be the main program to run your program!!
%
clc
clf

load test1
r0 = test.radius;
minradius = test.eps;

% containing box
B = Box(test.box(1,:),test.box(2,:));
root = B;
root.draw();

Q = {B};
E = test.env;
DS = DisjointSets();
freeBoxes = cell(30, 1);
numFree = 0;

startPos = [test.start(1)-test.radius test.start(2)-test.radius...
    2*test.radius 2*test.radius];
goalPos = [test.goal(1)-test.radius test.goal(2)-test.radius...
    2*test.radius 2*test.radius];

disp('Mixed box assignment phase...')
[B,Q] = getmixedbox(Q);
while ~isempty(B) % there is a 'mixed' box      
    BS = B.split; % all boxes are initilized as 'mixed'
    for i = 1:4
        if BS{i}.radius < minradius
            BS{i}.label = 'small';
        else
            F = featureset(BS{i}, E, r0);
            if isempty(F)
                BS{i}.label = 'stuckorfree';
            end
        end
    end
    Q = {Q{:} BS{:}}; % add 4 new boxes to the queue

    [B,Q] = getmixedbox(Q);
end


disp('Union-Find phase...')
for i = 1:length(Q)    
    if strcmp(Q{i}.label,'stuckorfree')
        if (inclusiontest(Q{i},E))
            Q{i}.label = 'stuck';
        else
            Q{i}.label = 'free';
            numFree = numFree + 1;
            freeBoxes{numFree} = Q{i};
        end
    end
end

for f = 1:numFree
   DS.addBox(freeBoxes{f}); 
end

for f1 = 1:numFree
   for f2 = 1:numFree
      if freeBoxes{f1} == freeBoxes{f2}
         continue; 
      elseif freeBoxes{f1}.sharesEdgeWith(freeBoxes{f2})
            DS.union(freeBoxes{f1}, freeBoxes{f2});
      end
   end
end

% When all free boxes have been added, union them

disp('Drawing phase...')
% Draw env
root.draw();

for i = 1:length(E)
    p = E{i};
    fill(p(1,:), p(2,:), 'm')
end

rectangle('Position', startPos, 'Curvature', [1 1], 'EdgeColor', 'w');
rectangle('Position', goalPos, 'Curvature', [1 1], 'EdgeColor', 'w');
disp('Process complete.')

%axis equal, axis tight, axis off
