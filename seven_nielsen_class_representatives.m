// Seven inner Nielsen class elements of type (2A,23A,23B) in M23.
// Magma permutations act on the right: the paper's product-one relation
// becomes g3*g2*g1 = 1.
// The first triple is the one displayed in "A Nielsen class".

S := Sym(23);
g2 := S!(1,2,11,10,16,9,6,3,23,19,20,14,21,17,4,8,22,5,18,15,13,7,12);
// Each entry is <g1,g2,g3>.
triples := [
    <S!(1,11)(2,23)(3,8)(4,16)(5,21)(7,20)(15,19)(18,22),
     g2,
     S!(1,2,3,4,10,11,12,7,19,18,8,6,9,16,17,21,22,5,14,20,13,15,23)>,
    <S!(3,17)(5,11)(7,18)(8,16)(9,21)(12,19)(14,22)(15,23),
     g2,
     S!(1,12,23,18,13,15,3,21,16,4,17,6,9,14,8,10,11,22,20,19,7,5,2)>,
    <S!(1,4)(2,14)(5,23)(6,21)(8,11)(9,12)(10,19)(17,20),
     g2,
     S!(1,17,19,11,4,12,16,10,23,22,8,2,20,21,9,7,13,15,18,5,3,6,14)>,
    <S!(1,19)(2,12)(3,10)(5,11)(6,20)(7,23)(9,22)(13,17),
     g2,
     S!(1,23,13,21,14,20,9,8,4,17,15,18,5,2,7,3,11,22,16,10,6,19,12)>,
    <S!(1,14)(2,19)(4,10)(5,23)(7,20)(8,13)(12,18)(15,21),
     g2,
     S!(1,20,13,4,11,2,23,22,8,15,14,12,5,3,6,9,16,10,17,21,18,7,19)>,
    <S!(2,22)(4,21)(5,15)(6,7)(8,9)(10,23)(12,18)(14,17),
     g2,
     S!(1,12,5,18,7,9,4,14,21,17,20,19,23,11,2,8,16,10,3,6,13,15,22)>,
    <S!(1,18)(2,13)(4,19)(5,17)(6,14)(9,11)(12,22)(16,20),
     g2,
     S!(1,5,21,14,9,2,15,18,12,8,4,23,3,6,20,10,11,16,19,17,22,7,13)>
];

G := sub<S | triples[1][1],g2>;
assert IsConjugate(S,G,TransitiveGroup(23,5));
for t in triples do
    g1, g2, g3 := Explode(t);
    assert g3*g2*g1 eq Id(S);
    assert sub<S | g1,g2> eq G;
    assert CycleStructure(g1) eq [<2,8>,<1,7>];     // 2A
    assert Order(g2) eq 23 and Order(g3) eq 23;
    assert not IsConjugate(G,g2,g3);               // opposite 23-classes
end for;

// With g2 fixed, inner equivalence is conjugacy by its centralizer.
assert Centralizer(G,g2) eq sub<G | g2>;
covered := {t[1]^(g2^i) : t in triples, i in [0..22]};
assert #covered eq 7*23;
print "Seven distinct inner Nielsen class representatives: checks passed.";
