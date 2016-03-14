classdef Box < handle % supposed to be square
    properties
        x % counterclockwise from bottom left
        y % counterclockwise from bottom left
        center
        radius % of circle containing box
        size % of edge (all edges have same size)
        label % 'free', 'stuck', 'mixed'
        
        % Subdivision Tree 
        parent
        topLeftChild
        topRightChild
        bottomLeftChild
        bottomRightChild
    end
    methods
        function obj = Box(x,y)
            obj.x = x;
            obj.y = y;
            obj.center = [(x(1)+x(2))/2; (y(1)+y(4))/2];
            obj.radius = norm([x(1); y(1)]-obj.center);
            obj.size = x(2)-x(1);
            obj.label = 'mixed';
            
            obj.parent = [];
            obj.topLeftChild = [];
            obj.topRightChild = [];
            obj.bottomLeftChild = [];
            obj.bottomRightChild = [];
        end
        
        
        
        function BS = split(obj)
            x1 = obj.x(1);  % bottom left x
            x2 = obj.x(2);  % bottom right x
            y1 = obj.y(1);  % bottom left y
            y2 = obj.y(4);  % upper right y

            xM = (x1+x2)/2;  % x midpoint of width
            yM = (y1+y2)/2;  % y midpoint of height

            % Bottom-left Box
            BS{1} = Box([x1 xM xM x1],[y1 y1 yM yM]);
            BS{1}.parent = obj;
            obj.bottomLeftChild = BS{1};
            
            % Bottom-right Box
            BS{2} = Box([xM x2 x2 xM],[y1 y1 yM yM]);
            BS{2}.parent = obj;
            obj.bottomRightChild = BS{2};
            
            % Top-right Box
            BS{3} = Box([xM x2 x2 xM],[yM yM y2 y2]);
            BS{3}.parent = obj;
            obj.topRightChild = BS{3};

            % Top-left Box
            BS{4} = Box([x1 xM xM x1],[yM yM y2 y2]);
            BS{4}.parent = obj;
            obj.topLeftChild = BS{4};
        end

        
        
        % The simplest way to obtain all adjacent boxes is to search
        % through every box (specifically, every leaf of the subdivision
        % tree) and check if it shares a side with the box.
        function allLeaves = getAllLeaves(obj)
            hasChildren = ~isempty(obj.topLeftChild);
            numLeaves = 0;
            allLeaves = cell(100, 1);  % Pre-allocate 100 cells.
            
            if hasChildren
                tlc = getAllLeaves(obj.topLeftChild);
                trc = getAllLeaves(obj.topRightChild);
                blc = getAllLeaves(obj.bottomLeftChild);
                brc = getAllLeaves(obj.bottomRightChild);
                
                for b = 1:length(tlc)
                    numLeaves = numLeaves + 1;
                    allLeaves{numLeaves} = tlc{b};
                end
                
                for b = 1:length(trc)
                    numLeaves = numLeaves + 1;
                    allLeaves{numLeaves} = trc{b};
                end
                
                for b = 1:length(blc)
                    numLeaves = numLeaves + 1;
                    allLeaves{numLeaves} = blc{b};
                end
                
                for b = 1:length(brc)
                    numLeaves = numLeaves + 1;
                    allLeaves{numLeaves} = brc{b};
                end
            else
                numLeaves = numLeaves + 1;
                allLeaves{numLeaves} = obj;
            end
            
            emptyCells = cellfun('isempty', allLeaves); 
            allLeaves(emptyCells) = [];
        end
        
        
        
        % Returns the root of the subdivision tree
        function b = getRoot(obj)
            b = obj;
            while ~isempty(b.parent)  % Only the root has a NaN parent
                b = b.parent;
            end
        end
        
        
        
        % Returns all boxes neighboring a given box
        function neighbors = getAdjBoxes(obj)
            root = getRoot(obj);
            leaves = getAllLeaves(root);
            neighbors = cell(100, 1);  % Pre-allocate 100 cells.
            numNeighbors = 0;
            for l = 1:length(leaves)
                leaf = leaves{l};
                if obj ~= leaf && obj.sharesEdgeWith(leaf)
                    numNeighbors = numNeighbors + 1;
                    neighbors{numNeighbors} = leaf;
                end
            end
            
            emptyCells = cellfun('isempty', neighbors); 
            neighbors(emptyCells) = [];
        end
        
        
        
        % Determines if two boxes share an edge
        function sharesEdge = sharesEdgeWith(obj, b)
           sharesEdge = false;
           smallB = obj;
           largeB = b;
           if b.radius < obj.radius
               smallB = b;
               largeB = obj;
           end
           
           % If the midpoint of an edge of the smaller Box is shared,
           % then the Boxes intersect.
           smallEdgeMidptsX = [smallB.x(1), smallB.center(1), ...
               smallB.x(2), smallB.center(1)];
           smallEdgeMidptsY = [smallB.center(2), smallB.y(2)...
               smallB.center(2), smallB.y(3)];
           
           for mp = 1:length(smallEdgeMidptsX)
               % Test if left edge of larger Box contains a midpoint
               % of a smaller Box's edge.
               if largeB.y(1) < smallEdgeMidptsY(mp) && largeB.y(4) > ...
                       smallEdgeMidptsY(mp) && smallEdgeMidptsX(mp) == ...
                       largeB.x(1)
                   sharesEdge = true;
                   return;
               end
               
               % Test if right edge of larger Box contains a midpoint
               % of a smaller Box's edge.
               if largeB.y(2) < smallEdgeMidptsY(mp) && largeB.y(3) > ...
                       smallEdgeMidptsY(mp) && smallEdgeMidptsX(mp) == ...
                       largeB.x(2)
                   sharesEdge = true;
                   return;
               end
               
               % Test if top edge of larger Box contains a midpoint
               % of a smaller Box's edge.
               if largeB.x(4) < smallEdgeMidptsX(mp) && largeB.x(3) > ...
                       smallEdgeMidptsX(mp) && smallEdgeMidptsY(mp) == ...
                       largeB.y(3)
                   sharesEdge = true;
                   return;
               end
               
               % Test if bottom edge of larger Box contains a midpoint
               % of a smaller Box's edge.
               if largeB.x(1) < smallEdgeMidptsX(mp) && largeB.x(2) > ...
                       smallEdgeMidptsX(mp) && smallEdgeMidptsY(mp) == ...
                       largeB.y(1)
                   sharesEdge = true;
                   return;
               end
           end
        end
        
        
        
        function draw(obj)
            if strcmp(obj.label,'stuck')
                rectangle('Position',[obj.x(1) obj.y(1) obj.size ...
                    obj.size], 'FaceColor','r');
            elseif strcmp(obj.label,'free')
                rectangle('Position',[obj.x(1) obj.y(1) obj.size ...
                    obj.size], 'FaceColor','g');
            elseif strcmp(obj.label,'small')
                rectangle('Position',[obj.x(1) obj.y(1) obj.size ...
                    obj.size], 'FaceColor','k');
            elseif strcmp(obj.label,'mixed') || strcmp(obj.label,...
                    'stuckorfree')
                rectangle('Position',[obj.x(1) obj.y(1) obj.size ...
                    obj.size], 'FaceColor','y');
            end
           
           drawnow
           hold on

           hasChildren = ~isempty(obj.topLeftChild);
           if hasChildren
                obj.topLeftChild.draw();
                obj.topRightChild.draw();
                obj.bottomLeftChild.draw();
                obj.bottomRightChild.draw();
           end
        end
    end
end







