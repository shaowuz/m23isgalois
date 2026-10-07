\\ f2(x) in Z[x], degree 23.
\\ Group identification and optional GaloisProof: verify.m.

f2 = 0;
f2 += (1243077066)*x^0;
f2 += (-11217790920)*x^1;
f2 += (38754121124)*x^2;
f2 += (-67357061907)*x^3;
f2 += (63691532334)*x^4;
f2 += (-26037806834)*x^5;
f2 += (-5728074376)*x^6;
f2 += (9451874955)*x^7;
f2 += (-2463757240)*x^8;
f2 += (83587888)*x^9;
f2 += (-436105484)*x^10;
f2 += (320807726)*x^11;
f2 += (-71999476)*x^12;
f2 += (17344116)*x^13;
f2 += (-9392096)*x^14;
f2 += (2223732)*x^15;
f2 += (-361974)*x^16;
f2 += (127420)*x^17;
f2 += (-21620)*x^18;
f2 += (1679)*x^19;
f2 += (-598)*x^20;
f2 += (46)*x^21;
f2 += (1)*x^23;

\\ Fingerprint: degree, nonzero terms, total coefficient digits, maximum digits,
\\ content, and f2(3) modulo 2^61-1.
f2_expect = [23, 23, 178, 11, 1, 2305842706887186565];

f2_selfcheck() =
{
  my(nz = 0, dg = 0, mx = 0, ct = 0, c, L);
  for(i = 0, 23,
    c = polcoef(f2, i, x);
    if(c != 0, L = #Str(abs(c)); nz = nz + 1; dg = dg + L; mx = max(mx, L);
               ct = gcd(ct, c))
  );
  [poldegree(f2, x), nz, dg, mx, ct, lift(Mod(subst(f2, x, 3), 2^61 - 1))];
}

if(f2_selfcheck() != f2_expect, error("f2: coefficient check failed"));
