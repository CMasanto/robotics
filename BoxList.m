classdef BoxList < handle  % Represents a list of boxes
    properties
        list % underlying array of elements
        numBoxes % number of Boxes in the list
    end
    methods
        function addBox(this, b)  % add a Box to the list
            this.numBoxes = this.numBoxes + 1;
            this.list{this.numBoxes} = b;
        end
        
        function addBoxesFromList(this, bl)  % add all Boxes from a list
            for b = 1:bl.numBoxes
                this.numBoxes = this.numBoxes + 1;
                this.list{this.numBoxes} = bl.list{b};
            end
        end
        
        function obj = BoxList()
            obj.list = cell(1, 100);
            obj.numBoxes = 0;
        end
        
    end
end