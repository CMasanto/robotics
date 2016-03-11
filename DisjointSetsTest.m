ds = DisjointSets();

b0 = Box(1, 2);
b1 = Box(3, 4);
b2 = Box(4, 5);
b3 = Box(7, 6);
b4 = Box(7, 6);
b5 = Box(7, 7);
b6 = Box(8, 8);
b7 = Box(9, 9);
b8 = Box(9, 2);
b9 = Box(1, 5);

ds.addBox(b0);
ds.addBox(b1);
ds.addBox(b2);
ds.addBox(b3);
ds.addBox(b4);
ds.addBox(b5);
ds.addBox(b6);
ds.addBox(b7);
ds.addBox(b8);
ds.addBox(b9);

ds.print();

ds.union(b1, b2);
ds.print();

ds.union(b3, b4);
ds.print();

ds.union(b4, b5);
ds.print();

ds.union(b6, b7);
ds.union(b7, b8);
ds.union(b8, b9);
ds.print();


