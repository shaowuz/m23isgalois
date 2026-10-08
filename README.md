# The Mathieu group M23 is a Galois group over Q

Equations and verification code accompanying the paper of the same title.
Magma is used for `.m` files and PARI/GP for `.gp` files.

## Files


| File                                    | Contents                                                                                |
| --------------------------------------- | --------------------------------------------------------------------------------------- |
| `P_Q_over_K.m`                          | The canonical model $X_K$: $\alpha,P,Q,b',c'$.                                          |
| `P_Q_over_Lprime.m`                     | The canonical model of $\mathcal X_{L'}$ : $\alpha,P,Q,b',c'$.                          |
| `seven_nielsen_class_representatives.m` | Seven triples and checks of their groups, conjugacy classes and distinct inner classes. |
| `polynomial_F.m`                        | $F(T,V)\in\mathbb Z[T,V]$, of bidegree $(4,23)$.                                        |
| `polynomial_F_small.m`                  | $F_{\mathrm{small}}(T,W)$ obtained using $V=(37W-40)/(49W+32)$.                         |
| `polynomial_calF.m`                     | $\mathcal F(T,V)$ over $L$ of bidegree $(4,23)$.                                        |
| `polynomial_F8.gp`                      | The earlier model $F_8\in\mathbb Q(T)[V]$ and `F8int`, of bidegree $(8,23)$.            |
| `polynomial_f1.gp`                      | The first degree-23 $M_{23}$ example over $\mathbb Q$.                                  |
| `polynomial_f2.gp`                      | The degree-23 $M_{23}$ example obtained from $T=-3703/947$.                             |
| `polynomial_f3.gp`                      | The degree-22 $M_{22}$ example.                                                         |
| `verify.m`                              | Galois group and discriminant checks; exact $F/F_{\mathrm{small}}$ comparison.          |


## Running the code

Run from the repository root. In Magma, select checks before loading `verify.m`. For example,

```text
MODE := "certified";
WHICH := "f1";
load "verify.m";
```

- `MODE` is `"conditional"` (GaloisGroup only) (default) or `"certified"`
(also requires GaloisProof for rigorous Galois group computation).
- `WHICH` is `"f1"`, `"f2"`, `"f3"`, `"f1f2"`, `"f1f2f3"`, `"X"` (F and F_small), or `"all"` (default). Please
see the descriptions in `verify.m`.

GaloisProof may take substantial time and memory under `MODE := "certified"`.

In PARI/GP, use `read("polynomial_f1.gp")`, and similarly for the other
`.gp` files. Each runs a coefficient fingerprint check when loaded.
