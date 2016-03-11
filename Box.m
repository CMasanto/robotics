classdef Box % supposed to be square
    properties
        x % counterclockwise from bottom left
        y % counterclockwise from bottom left
        center
        radius % of circle containing box
        size % of edge (all edges have same size)
        label % 'free', 'stuck', 'mixed'
    end
    methods
        function obj = Box(x,y)
            obj.x = x;
            obj.y = y;
            obj.center = [(x(1)+x(2))/2; (y(1)+y(4))/2];
            obj.radius = norm([x(1); y(1)]-obj.center);
            obj.size = x(2)-x(1);
            obj.label = 'mixed';
        end
        function BS = split(obj)
            x1 = obj.x(1);
            x2 = obj.x(2);
            y1 = obj.y(1);
            y2 = obj.y(4);

            xM = (x1+x2)/2;
            yM = (y1+y2)/2;

            BS{1} = Box([x1 xM xM x1],[y1 y1 yM yM]);
            BS{2} = Box([xM x2 x2 xM],[y1 y1 yM yM]);
            BS{3} = Box([xM x2 x2 xM],[yM yM y2 y2]);
            BS{4} = Box([x1 xM xM x1],[yM yM y2 y2]);
        end
    end
end