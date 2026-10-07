\\ f3(x) in Z[x], degree 22.
\\ Group identification and optional GaloisProof: verify.m.

f3 = 0;
f3 += (212425572022)*x^0;
f3 += (8150987444096)*x^1;
f3 += (19223398109406)*x^2;
f3 += (12770814291390)*x^3;
f3 += (-5309597045808)*x^4;
f3 += (-12865403779026)*x^5;
f3 += (-8595497273752)*x^6;
f3 += (-2898168029276)*x^7;
f3 += (-396850048164)*x^8;
f3 += (48162643482)*x^9;
f3 += (44873894586)*x^10;
f3 += (13957937472)*x^11;
f3 += (222611762)*x^12;
f3 += (-1334363150)*x^13;
f3 += (-104404974)*x^14;
f3 += (57499538)*x^15;
f3 += (1612816)*x^16;
f3 += (-878184)*x^17;
f3 += (-3160)*x^18;
f3 += (4948)*x^19;
f3 += (-171)*x^20;
f3 += (-10)*x^21;
f3 += (1)*x^22;

\\ Fingerprint: degree, nonzero terms, total coefficient digits, maximum digits,
\\ content, and f3(3) modulo 2^61-1.
f3_expect = [22, 23, 214, 14, 1, 2291967796895347739];

f3_selfcheck() =
{
  my(nz = 0, dg = 0, mx = 0, ct = 0, c, L);
  for(i = 0, 22,
    c = polcoef(f3, i, x);
    if(c != 0, L = #Str(abs(c)); nz = nz + 1; dg = dg + L; mx = max(mx, L);
               ct = gcd(ct, c))
  );
  [poldegree(f3, x), nz, dg, mx, ct, lift(Mod(subst(f3, x, 3), 2^61 - 1))];
}

if(f3_selfcheck() != f3_expect, error("f3: coefficient check failed"));
