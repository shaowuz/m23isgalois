# M23 as a Galois group over Q

The inverse Galois problem asks whether every finite group occurs as the
Galois group of some extension of `Q`. This repository shows that the answer
is yes for the Mathieu group `M23`. It records explicit degree-23 polynomials
in `Z[x]` whose Galois group over `Q` is `M23 = 23T5`, together with Magma
code that verifies the claim. `M23` was the last remaining case to complete the
proof that every sporadic simple group is a Galois group over `Q`.

`F(V,T)` is a degree-23 polynomial over Q(T) with Galois group 
`M23`, and `f1(x), f2(x)` are degree-23 polynomials in `Z[x]` with Galois
group `M23`.

## Files

| File | Contents |
| --- | --- |
| `polynomial_F.gp` | `F(V,T)`, degree 23 over `Q(T)` |
| `polynomial_f1.gp` | `f1(x)`, degree 23 over `Q` |
| `polynomial_f2.gp` | `f2(x)`, degree 23 over `Q` |
| `verify.m` | Magma script: computes `GaloisGroup` for `f1` and for `f2`, identifies each as `23T5`, and by default attempts to certify the results with `GaloisProof`. |

## Usage

```
magma
> load "verify.m";
```

or non-interactively (runs and exits; the exit code reflects the asserts):

```
echo 'load "verify.m"; quit;' | magma
```

Two flags at the top of `verify.m` control the run. `WHICH := "f1"`, `"f2"`
or `"both"` selects the polynomial(s). `MODE := "conditional"` stops after
the fast, unproven `GaloisGroup` identification; the default
`MODE := "certified"` then attempts a rigorous certification with
`GaloisProof`, which needs a very large amount of free memory.

Both `f1` and `f2` are identified as `23T5 = M(23)` of order 10200960.


