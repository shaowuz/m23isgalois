// Run from the repository root. Set MODE and WHICH before loading to override.
// MODE: "conditional" (GaloisGroup) or "certified" (also GaloisProof).
// WHICH: "f1", "f2", "f3", "both", "examples", "X", "calX", "families", "all".
// Family group checks are conditional in either mode.
if not assigned MODE then MODE := "conditional"; end if;
if not assigned WHICH then WHICH := "all"; end if;
assert MODE in {"certified","conditional"};
assert WHICH in {"f1","f2","f3","both","examples","X","calX","families","all"};
SetSeed(1);

P<x> := PolynomialRing(Rationals());

// f1
f1 := x^23
    - 184*x^21
    - 1150*x^20
    + 26151*x^19
    + 18400*x^18
    - 1808490*x^17
    + 1545462*x^16
    + 67672923*x^15
    - 42732528*x^14
    - 1333395744*x^13
    + 290615166*x^12
    + 10550424369*x^11
    + 3700476348*x^10
    + 35123826654*x^9
    - 194398310718*x^8
    - 1023887308293*x^7
    + 3961650395556*x^6
    + 1949980486716*x^5
    - 28142323927002*x^4
    + 53599151839311*x^3
    - 46185312415788*x^2
    + 19169943578802*x
    - 3150159884154;


// f2
f2 := x^23
    + 46*x^21
    - 598*x^20
    + 1679*x^19
    - 21620*x^18
    + 127420*x^17
    - 361974*x^16
    + 2223732*x^15
    - 9392096*x^14
    + 17344116*x^13
    - 71999476*x^12
    + 320807726*x^11
    - 436105484*x^10
    + 83587888*x^9
    - 2463757240*x^8
    + 9451874955*x^7
    - 5728074376*x^6
    - 26037806834*x^5
    + 63691532334*x^4
    - 67357061907*x^3
    + 38754121124*x^2
    - 11217790920*x
    + 1243077066;

// f3
f3 := x^22 - 10*x^21 - 171*x^20 + 4948*x^19 - 3160*x^18 - 878184*x^17
 + 1612816*x^16 + 57499538*x^15 - 104404974*x^14 - 1334363150*x^13
 + 222611762*x^12 + 13957937472*x^11 + 44873894586*x^10 + 48162643482*x^9
 - 396850048164*x^8 - 2898168029276*x^7 - 8595497273752*x^6
 - 12865403779026*x^5 - 5309597045808*x^4 + 12770814291390*x^3
 + 19223398109406*x^2 + 8150987444096*x + 212425572022;

// The expected discriminants are those of the number fields, not polynomials.
procedure CheckExample(name,f,expected_discriminant,mode)
    assert IsIrreducible(f);
    n := Degree(f);
    k := n eq 22 select 38 else 5;
    expected_group := TransitiveGroup(n,k);
    G, roots, data := GaloisGroup(f);
    assert IsConjugate(Sym(n),G,expected_group);
    printf "%o: conditional group identification %oT%o.\n",name,n,k;
    if mode eq "certified" then
        assert GaloisProof(f,data);
        printf "%o: GaloisProof passed.\n",name;
    end if;
    K := NumberField(f);
    primes := [pe[1] : pe in Factorization(expected_discriminant)];
    O := MaximalOrder(K : Ramification := primes);
    // Reconstruct and check the order without assuming the ramification bound.
    fresh := NumberField(f);
    basis := [Evaluate(Polynomial(Eltseq(K!b)),fresh.1) : b in Basis(O)];
    checked_order := Order(basis);
    assert Discriminant(checked_order) eq expected_discriminant;
    assert IsMaximal(checked_order);
    printf "%o: field discriminant verified.\n",name;
end procedure;

if WHICH in {"f1","both","examples","all"} then
    CheckExample("f1",f1,2^36*3^18*23^30,MODE);
end if;
if WHICH in {"f2","both","examples","all"} then
    CheckExample("f2",f2,2^44*7^8*23^24,MODE);
end if;
if WHICH in {"f3","examples","all"} then
    CheckExample("f3",f3,2^22*3^24*23^18*127^8,MODE);
end if;

// These reductions do not implement the appendix's p=411000011 certification.
load "polynomial_F.m";
load "polynomial_F_small.m";
if WHICH in {"X","families","all"} then
    // Check the change of variable over Q before reducing modulo 31.
    QQTV<T,V> := PolynomialRing(Rationals(),2);
    cs := Coefficients(F); ms := Monomials(F);
    H := &+[cs[i]*T^Degree(ms[i],1)*(37*V-40)^Degree(ms[i],2)
        *(49*V+32)^(23-Degree(ms[i],2)) : i in [1..#cs]];
    small := QQTV!F_small;
    assert H*LeadingCoefficient(small) eq small*LeadingCoefficient(H);
    print "F and F_small: exact change of variable verified.";

    k := GF(31);
    kt<t> := FunctionField(k);
    R<v> := PolynomialRing(kt);
    f := R!Evaluate(F,[t,v]);
    g := R!Evaluate(F_small,[t,v]);
    assert k!(37*32+40*49) ne 0;
    assert Degree(f) eq 23 and Degree(g) eq 23;
    assert IsIrreducible(f) and IsIrreducible(g);
    G := GaloisGroup(f);
    assert IsConjugate(Sym(23),G,TransitiveGroup(23,5));
    print "F modulo 31: conditional group identification M23.";
end if;

load "polynomial_calF.m";
if WHICH in {"calX","families","all"} then
    k := GF(31);
    kx<x> := PolynomialRing(k);
    kt<t> := FunctionField(k);
    R<v> := PolynomialRing(kt);
    // The degree-one prime (31,s-12) of L.
    h := kx!DefiningPolynomial(L);
    assert Evaluate(h,12) eq 0 and Evaluate(Derivative(h),12) ne 0;
    cs := Coefficients(calF); ms := Monomials(calF);
    f := &+[R!Evaluate(kx!Eltseq(cs[i]),k!12)
        *t^Degree(ms[i],1)*v^Degree(ms[i],2) : i in [1..#cs]];
    assert Degree(f) eq 23 and IsIrreducible(f);
    G := GaloisGroup(f);
    assert IsConjugate(Sym(23),G,TransitiveGroup(23,5));
    print "calF modulo (31,s-12): conditional group identification M23.";
end if;
