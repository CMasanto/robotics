classdef BoxList < Handle  % Represents a list of boxes
    properties
        list % underlying array of elements
        numBoxes % number of Boxes in the list
    end
    methods
        function addBox(this, b)  % add a Box to the list
            this.list(this.numBoxes) = b;
            this.numBoxes = this.numBoxes + 1;
        end
        
        function addBoxesFromList(this, bl)  % add all Boxes from a list
            for b = 1:bl.numBoxes
                this.list(this.numBoxes) = bl.list(b);
                this.numBoxes = this.size + 1;
            end
        end
        
        function obj = BoxList()
            obj.list = cell(1000);
            obj.numBoxes = 0;
        end
        
    end
end