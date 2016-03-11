classdef DisjointSets < Handle  % Union-Find data structure
    properties
        setList  % The cell array of BoxList objects
        numSets  % Current number of lists
    end
    methods
        function [y] = find(this, x)  % returns the head of the list in which x is found
            for s = 1:this.numSets
                set = this.setList(s);
                for b = 1:set.numBoxes
                    box = set.list(b);
                    if box == x
                       y = set;  % the set to which x belongs
                       break;
                    end
                end
            end
            print('The given parameter was not found.');
        end
        
        function addBox(this, b)
            this.setList(this.numSets) = BoxList();
            this.setList(this.numSets).addBox(b);
            this.numSets = this.numSets + 1;
        end
        
        function addList(this, l)
            this.setList(this.numSets) = l;
            this.numSets = this.numSets + 1;
        end
        
        function union(this, x, y)
            % Find and concatenate the lists to which x and y belong.
            xList = this.find(x);
            yList = this.find(y);
            unioned = horzcat(xList, yList);
            this.addList(unioned);
            
            % Delete the original x and y lists.
            % Search for x and y in setlist, and set them to []
        end
        
        function obj = DisjointSets()
            obj.setList = cell(1000);  % initial capacity
            obj.numSets = 0;
        end
        
    end
end