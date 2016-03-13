box = Box([0 10 10 0],[0 0 10 10]);
BS1 = box.split();
BS2 = BS1{1}.split();
BS3 = BS2{1}.split();
BS4 = BS3{2}.split();
BS5 = BS4{3}.split();

root = BS5{2}.getRoot();
leaves = root.getAllLeaves();
for b = 1:length(leaves)
    disp(leaves{b});
end