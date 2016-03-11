classdef DisjointSets < handle  % Union-Find data structure
    properties
        setList  % The cell array of BoxList objects
        numSets  % Current number of lists
    end
    methods
        function obj = DisjointSets()
            obj.setList = cell(1, 100);  % initial capacity
            obj.numSets = 0;
        end
        
        function y = find(this, x)  % returns the head of the list in which x is found
            for s = 1:this.numSets
                set = this.setList{s};
                for b = 1:set.numBoxes
                    box = set.list{b};
                    if isequal(box, x)
                       y = set;  % the set to which x belongs
                       disp(y);
                       break;
                    end
                end
            end
        end
        
        function addBox(this, b)
            this.numSets = this.numSets + 1;
            this.setList{this.numSets} = BoxList();
            this.setList{this.numSets}.addBox(b);
        end
        
        function addList(this, l)
            this.numSets = this.numSets + 1;
            this.setList{this.numSets} = l;
        end
        
        function deleteList(this, l)
            for s = 1:this.numSets
                if this.setList{s} == l
                    this.setList{s} = [];
                    return;
                end
            end
        end
        
        function union(this, x, y)
            % Find and concatenate the lists to which x and y belong.
            xList = this.find(x);
            yList = this.find(y);
            unioned = horzcat(xList, yList);
            this.addList(unioned);
            
            % Delete the original x and y lists.
            this.deleteList(xList);
            this.deleteList(yList);
        end
        
        function print(this)
            disp('HEAD---------------HEAD---------------HEAD');
            for s = 1:this.numSets
                disp(this.setList(s))
            end
            disp('TAIL---------------TAIL---------------TAIL');
        end
        
    end
end