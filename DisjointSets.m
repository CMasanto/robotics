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
        
        function y = find(this, x)  % returns the list in which x is found
            for s = 1:this.numSets
                boxList = this.setList{s};
                for b = 1:boxList.numBoxes
                    box = boxList.list{b};
                    if isequal(box, x)
                       y = boxList;  % the set to which x belongs
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
            for b = 1:yList.numBoxes
                xList.addBoxesFromList(yList);
            end
            
            % Delete the original x and y lists.
            this.deleteList(yList);
            emptyCells = cellfun('isempty', this.setList); 
            this.setList(emptyCells) = [];
            this.numSets = this.numSets - 1;
        end
        
        function print(this)
            disp('HEAD---------------HEAD---------------HEAD');
            for s = 1:this.numSets
                disp('-------Set Start--------');
                l = this.setList{s};
                for b = 1:l.numBoxes
                    disp(l.list{b}.x);
                    disp(l.list{b}.y);
                end
                disp('-------Set End--------');
            end
            disp('TAIL---------------TAIL---------------TAIL');
        end
        
    end
end