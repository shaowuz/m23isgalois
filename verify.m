// ---------------------------------------------------------------------------
// verify.m
//
// Verifies that the splitting field of each of the two degree-23 polynomials f1,
// f2 in this repository is a Galois extension of Q with group M23 = 23T5.
// The polynomials are committed here as f1 and f2 (also in polynomial_f1.gp
// and polynomial_f2.gp).
//
// USAGE:
//     magma
//     > load "verify.m";
// or non-interactively (runs and exits, exit code reflects the asserts):
//     echo 'load "verify.m"; quit;' | magma
//
// Two flags at the top control the run:
//     MODE        "certified"    attempt rigorous certification with GaloisProof
//                 "conditional"  stop after the unproven GaloisGroup identification
//     WHICH       "f1", "f2" or "both": which polynomials to run on
//
// For each polynomial the script prints it, the transitive-group label 23Tk of
// the computed group, its order and composition factors, and -- when MODE is
// "certified" -- whether GaloisProof certified the result.  GaloisProof needs a
// 64-bit Magma with a large amount of memory free.
// ---------------------------------------------------------------------------

SetVerbose("GaloisGroup", 1);
SetSeed(1);

MODE  := "certified";    // "certified": run GaloisProof; "conditional": no proof
WHICH := "both";         // "f1", "f2" or "both"

assert MODE in {"certified", "conditional"};
assert WHICH in {"f1", "f2", "both"};

P<x> := PolynomialRing(Rationals());

// --- f1 --------------------------------------------------------------------
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


// --- f2 --------------------------------------------------------------------
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

// ---------------------------------------------------------------------------
// One polynomial: compute the group, identify it, and optionally certify.
// Returns true iff GaloisProof certified the result (always false when
// MODE is "conditional").
// ---------------------------------------------------------------------------

function Check(name, f, MODE)

    assert IsIrreducible(f);

    printf "\n===========================================================\n";
    printf "%o = %o\n", name, f;

    printf "computing GaloisGroup ...\n";
    t0 := Cputime();

    G, Rts, S := GaloisGroup(f);

    printf "done in %o s\n", Cputime(t0);
    printf "|returned G| = %o\n", #G;
    printf "returned G is transitive : %o  (degree %o)\n",
           IsTransitive(G), Degree(G);

    k := TransitiveGroupIdentification(G);
    printf "returned group = 23T%o\n", k;
    printf "description    = %o\n", TransitiveGroupDescription(23, k);

    // Magma does not provide a predefined identifier named M23.
    // Construct 23T5 explicitly from the transitive-group database.

    M23db := TransitiveGroup(23, 5);

    printf "returned G is isomorphic to 23T5 : %o\n", IsIsomorphic(G, M23db);
    printf "returned G is conjugate to 23T5 in Sym(23) : %o\n",
           IsConjugate(Sym(23), G, M23db);
    printf "composition factors of the returned group: %o\n",
           CompositionFactors(G);

    if k eq 5 and #G eq 10200960 then
        printf "*** The conditional computation returned 23T5 = M23. ***\n";
        printf "*** This does NOT yet certify the Galois group of %o. ***\n", name;
    end if;

    certified := false;

    if MODE eq "certified" then
        printf "\nrunning GaloisProof ...\n";
        t0 := Cputime();

        ok := GaloisProof(f, S);

        printf "GaloisProof: %o   (%o s)\n", ok, Cputime(t0);

        if ok then
            printf "*******************************************************\n";
            printf "*** CERTIFIED: Gal(%o/Q) is the returned group 23T%o. ***\n", name, k;
            printf "*******************************************************\n";
            certified := true;
        else
            printf "GaloisProof did not certify the conditional result.\n";
        end if;
    else
        printf "\nGaloisProof skipped because MODE is \"conditional\".\n";
        printf "The identification with M23 remains CONDITIONAL for %o.\n", name;
    end if;

    return certified;

end function;

// ---------------------------------------------------------------------------

all_ok := true;

// Store each Check result before combining: "and" short-circuits in Magma,
// so "all_ok and Check(...)" would silently skip the second polynomial
// whenever the first one is not certified.

if WHICH in {"f1", "both"} then
    ok1 := Check("f1", f1, MODE);
    all_ok := all_ok and ok1;
end if;

if WHICH in {"f2", "both"} then
    ok2 := Check("f2", f2, MODE);
    all_ok := all_ok and ok2;
end if;

if MODE eq "certified" then
    printf "\nFINAL: %o\n", all_ok select "ALL CERTIFIED" else "NOT ALL CERTIFIED";
    assert all_ok;
end if;
