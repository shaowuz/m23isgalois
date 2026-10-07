# The Mathieu group M23 is a Galois group over Q

Equations and verification code accompanying the paper of the same title.
Magma is used for `.m` files and PARI/GP for `.gp` files.

## Files

| File | Contents |
| --- | --- |
| `P_Q_over_K.m` | The canonical model $X_K$: $\alpha,P,Q,b',c'$. |
| `P_Q_over_Lprime.m` | The canonical model of $\mathcal X_{L'}$ : $\alpha,P,Q,b',c'$. |
| `seven_nielsen_class_representatives.m` | Seven triples and checks of their groups, conjugacy classes and distinct inner classes. |
| `polynomial_F.m` | $F(T,V)\in\mathbb Z[T,V]$, of bidegree $(4,23)$. |
| `polynomial_F_small.m` | $F_{\mathrm{sma}}(T,W)$, named `F_small`, obtained using $V=(37W-40)/(49W+32)$. |
| `polynomial_calF.m` | $\mathcal F(T,V)$ over $L$, named `calF`, of bidegree $(4,23)$. |
| `polynomial_F8.gp` | The earlier model $F_8\in\mathbb Q(T)[V]$ and `F8int`, of bidegree $(8,23)$. |
| `polynomial_f1.gp` | The first degree-23 $M_{23}$ example over $\mathbb Q$. |
| `polynomial_f2.gp` | The degree-23 $M_{23}$ example obtained from $T=-3703/947$. |
| `polynomial_f3.gp` | The degree-22 $M_{22}$ example. |
| `verify.m` | Number-field group and discriminant checks; exact $F/F_{\mathrm{sma}}$ comparison and conditional group checks modulo 31. |

## Running the code

Run from the repository root. Load each model or Nielsen file separately:

```text
magma P_Q_over_K.m
magma P_Q_over_Lprime.m
magma seven_nielsen_class_representatives.m
```

In Magma, select checks before loading `verify.m`:

```text
MODE := "conditional";
WHICH := "examples";
load "verify.m";
```

`MODE` is `"conditional"` (GaloisGroup only, the default) or `"certified"`
(also requires GaloisProof to succeed for the number-field examples).
`WHICH` is `"f1"`, `"f2"`, `"f3"`, `"both"` (f1 and f2), `"examples"`,
`"X"` (F and F_sma), `"calX"`, `"families"`, or `"all"` (the default).
Group calculations, particularly GaloisProof and the function-field checks,
may take substantial time and memory.

In PARI/GP, use `read("polynomial_f1.gp")`, and similarly for the other
`.gp` files. Each runs a coefficient fingerprint check when loaded.


The family group checks use GF(31)(t), with the prime (31,s-12) for calF.
They remain conditional even in `"certified"` mode. The paper's ramification,
node and p=411000011 character-sum certification scripts are not included.
The fingerprints check data integrity, not Galois groups; F8 is not checked
by `verify.m`.
