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
                if obj.sharesEdgeWith(l) && obj ~= l
                    numNeighbors = numNeighbors + 1;
                    neighbors(numNeighbors)
                end
            end
        end
        
        % Determines if two boxes share an edge
        function sharesEdge = sharesEdgeWith(obj, b)
           sharesEdge = FALSE;
           smallerBox = obj;
           if b.radius < smallerBox.radius
               smallerBox = b;
           end
           
           [xi, yi] = polyxpoly(obj.x, obj.y, b.x, b.y);
           numSharedPoints = 0;
           for p = 1:length(xi)
               if (xi{p} == smallerBox.x(1) && yi{p} == smallerBox.y(1))
                   numSharedPoints = numSharedPoints + 1;
               end

               if (xi{p} == smallerBox.x(2) && yi{p} == smallerBox.y(2))
                   numSharedPoints = numSharedPoints + 1;
               end

               if (xi{p} == smallerBox.x(3) && yi{p} == smallerBox.y(3))
                   numSharedPoints = numSharedPoints + 1;
               end

               if (xi{p} == smallerBox.x(3) && yi{p} == smallerBox.y(3))
                   numSharedPoints = numSharedPoints + 1;
               end
           end
           
           if numSharedPoints >= 2
                sharesEdge = TRUE;
           end
        end
    end
end







