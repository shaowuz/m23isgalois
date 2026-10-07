// K = Q(sqrt(-23)); X_K is defined by P = Q = 0 in P^3_K.
// P = P^1_{lambda/alpha}, Q = Q^1_{lambda/alpha}; wt(x_i) = i.
Qx<x> := PolynomialRing(Rationals());
K<sqrt_minus_23> := NumberField(x^2+23);
w := (1+sqrt_minus_23)/2;  // Auxiliary notation for coefficients.
R<x0,x1,x2,x3> := PolynomialRing(K,4);
alpha := 28-3*w;

P := x0*x2 + alpha*x0*x3 - x1^2 - alpha*x1*x2
    + (1050+153*w)*x1*x3 - (854+795*w)*x2^2
    + (64846-96051*w)*x2*x3 + (1261334-2018927*w)*x3^2;

Q := (2*x0^2*x3 + (56-6*w)*x0*x1*x3 - 2*x1^3
    - (2+5*w)*x0*x2^2 + (4584+2624*w)*x0*x2*x3
    + (130810+28575*w)*x0*x3^2 - (2830+2097*w)*x1*x2^2
    + (243600-181928*w)*x1*x2*x3 + (12668386-7086877*w)*x1*x3^2
    + (113308+7474*w)*x2^3 + (8859958+6474145*w)*x2^2*x3
    + (779576812-318883230*w)*x2*x3^2
    + (8003426930-11368991285*w)*x3^3)/2;

X_K := Curve(Proj(R),[P,Q]);
bprime := X_K![1,0,0,0];
cprime := X_K![1,(128-47*w)/7620,(136*w-265)/967740,
    (2657-1181*w)/245805960];

assert TotalDegree(P) eq 2 and TotalDegree(Q) eq 3;
assert MonomialCoefficient(P,x0*x2) eq 1;
assert MonomialCoefficient(P,x0*x3) eq alpha;
assert MonomialCoefficient(P,x1^2) eq -1;
assert MonomialCoefficient(P,x1*x2) eq -alpha;
assert MonomialCoefficient(Q,x0^2*x3) eq 1;
assert &and[MonomialCoefficient(Q,m) eq 0
    : m in [x0^2*x2,x0*x1*x2,x1^2*x2,x1^2*x3]];
assert &and[IsIntegral(c) : c in Coefficients(P)];
assert Evaluate(P,Eltseq(bprime)) eq 0 and Evaluate(Q,Eltseq(bprime)) eq 0;
assert Evaluate(P,Eltseq(cprime)) eq 0 and Evaluate(Q,Eltseq(cprime)) eq 0;
assert Norm(alpha) eq 754;
assert &and[IsIntegral(2*c) : c in Coefficients(Q)];
print "K model: normalization, integrality and point checks passed.";
