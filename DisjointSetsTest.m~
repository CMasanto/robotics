ds = DisjointSets();
disp('DisjointSets object successfully created.');

b0 = Box([1 2 3 4],[2 4 6 8]);
b1 = Box([2 2 3 4],[2 4 6 8]);
b2 = Box([3 2 3 4],[2 4 6 8]);
b3 = Box([4 2 3 4],[2 4 6 8]);
b4 = Box([5 2 3 4],[2 4 6 8]);
b5 = Box([6 2 3 4],[2 4 6 8]);
b6 = Box([7 2 3 4],[2 4 6 8]);
b7 = Box([8 2 3 4],[2 4 6 8]);
b8 = Box([9 2 3 4],[2 4 6 8]);
b9 = Box([1 5 3 4],[2 4 6 8]);
disp('All 10 Boxes successfully created.');

ds.addBox(b0);
disp('Box #0 successfully added.');

ds.addBox(b1);
disp('Box #1 successfully added.');

ds.addBox(b2);
disp('Box #2 successfully added.');

ds.addBox(b3);
disp('Box #3 successfully added.');

ds.addBox(b4);
disp('Box #4 successfully added.');

ds.addBox(b5);
disp('Box #5 successfully added.');

ds.addBox(b6);
disp('Box #6 successfully added.');

ds.addBox(b7);
disp('Box #7 successfully added.');

ds.addBox(b8);
disp('Box #8 successfully added.');

ds.addBox(b9);
disp('Box #9 successfully added.');

ds.print();

% Union #1
disp('Union #1 beginning');
ds.union(b1, b2);
ds.print();
disp('Union #1 complete');

% Union #2
disp('Union #2 beginning');
ds.union(b3, b4);
ds.print();
disp('Union #2 complete');

% Union #3
disp('Union #3 beginning');
ds.union(b4, b5);
ds.print();
disp('Union #3 complete');

% Union #4
disp('Union #4 beginning');
ds.union(b6, b7);
ds.union(b7, b8);
ds.union(b8, b9);
ds.print();
disp('Union #4 complete');
