% file name: main.m
%
% This should be the main program to run your program!!
%
clc
clf

load test1
r0 = 2.0;
minradius = 0.4;

% containing box
B = Box(test.box(1,:),test.box(2,:));
root = B;
root.draw();

Q = {B};
E = test.env;
DS = DisjointSets();
freeBoxes = cell(30, 1);
numFree = 0;

disp('Mixed box assignment phase...')
[B,Q] = getmixedbox(Q);
while ~isempty(B) % there is a 'mixed' box      
    BS = B.split; % all boxes are initilized as 'mixed'
    for i = 1:4
        BS{i}.draw();
        hold on
        
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
      else
         if freeBoxes{f1}.sharesEdgeWith(freeBoxes{f2})
            DS.union(freeBoxes{f1}, freeBoxes{f2});
            fprintf('Unioning box %d with box %d\n', f1, f2);
         end
      end
   end
end

% When all free boxes have been added, union them

disp('Drawing phase...')
% for i = 1:length(Q)
%     B = Q{i};
%     if strcmp(B.label,'stuck')
%         patch(B.x,B.y,'red')
%     elseif strcmp(B.label,'free')
%         patch(B.x,B.y,'green')
%     elseif strcmp(B.label,'small')
%         patch(B.x,B.y,'blue')
%     elseif strcmp(B.label,'mixed')
%         patch(B.x,B.y,'yellow')
%     end
% end

% Draw env
root.draw();
for i = 1:length(E)
    p = E{i};
    fill(p(1,:), p(2,:), 'm')
end

DS.print();

disp('Process complete.')

%axis equal, axis tight, axis off
