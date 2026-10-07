\\ f1(x) in Z[x], degree 23.
\\ Group identification and optional GaloisProof: verify.m.

f1 = 0;
f1 += (-3150159884154)*x^0;
f1 += (19169943578802)*x^1;
f1 += (-46185312415788)*x^2;
f1 += (53599151839311)*x^3;
f1 += (-28142323927002)*x^4;
f1 += (1949980486716)*x^5;
f1 += (3961650395556)*x^6;
f1 += (-1023887308293)*x^7;
f1 += (-194398310718)*x^8;
f1 += (35123826654)*x^9;
f1 += (3700476348)*x^10;
f1 += (10550424369)*x^11;
f1 += (290615166)*x^12;
f1 += (-1333395744)*x^13;
f1 += (-42732528)*x^14;
f1 += (67672923)*x^15;
f1 += (1545462)*x^16;
f1 += (-1808490)*x^17;
f1 += (18400)*x^18;
f1 += (26151)*x^19;
f1 += (-1150)*x^20;
f1 += (-184)*x^21;
f1 += (1)*x^23;

\\ Fingerprint: degree, nonzero terms, total coefficient digits, maximum digits,
\\ content, and f1(3) modulo 2^61-1.
f1_expect = [23, 23, 219, 14, 1, 92254275456192];

f1_selfcheck() =
{
  my(nz = 0, dg = 0, mx = 0, ct = 0, c, L);
  for(i = 0, 23,
    c = polcoef(f1, i, x);
    if(c != 0, L = #Str(abs(c)); nz = nz + 1; dg = dg + L; mx = max(mx, L);
               ct = gcd(ct, c))
  );
  [poldegree(f1, x), nz, dg, mx, ct, lift(Mod(subst(f1, x, 3), 2^61 - 1))];
}

if(f1_selfcheck() != f1_expect, error("f1: coefficient check failed"));
