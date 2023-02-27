+++
title = "Lifetime calculation of Electrolytic Capacitors"
description = "An example of calculation lifetime of JIANGHAI electrolytic capacitor."
date = 2020-11-04T09:19:42+01:00

[taxonomies]
categories = ["Power-Electronics"]
tags = ["Capacitor"]

[extra]
toc = true
math = true
math_auto_render = true
+++

On the process of making new inverter/converter products, we are talking about what type of topology will be used, power losses and cost estimation. It is easy to forgot about the **Lifetime of capacitors**. This article is quick note how to estimate lifetime of electrolytic capacitor (elcap) provided by **JIANGHAI** [^fn1]. Other manufactures may have different ways to estimate lifetime of these capacitors. Please look up manufacturer application note for more detail.


## Lifetime model

The lifetime $L$ of the electrolytic capacitor can be estimated by using numerical lifetime model:

$$
L = L_0 \cdot K_T \cdot K_R \cdot K_V
$$

where

- $L_0$ is specified lifetime from the datasheet of given capacitor at norminal ripple.
- $K_T$ temperature factor (ambient temperature)
- $K_R$ ripple current factor (self-heating)
- $K_V$ voltage factor (operating voltage)

### Temperature factor

Temperature factor $K_T$ can be calculated based on "10-Kelvin-rule" that is: a drop of the ambient temperature by $10K$ double the lifetime of capacitor.

$$
K_T = 2^{\cfrac {T_O - T_A}{10K}}
$$

Where

- $T_0$ rated temperature
- $T_A$ ambient temperature

### Ripple current factor

Ripple current factor $K_R$ is calculated as following.

$$
K_R = K_i^{A \cdot \cfrac{\Delta T_0}{10K}}
$$

where

- $A = 1 - (\frac{I_A}{I_R})^2$
- $I_A$ ripple current in the application
- $I_R$ rated ripple current
- $\Delta T_0$ core temperature increase of the elcap
  - $T_0=105 ^{\circ}C$ typ. 3.5~5K
  - $T_0 = 85 ^\circ C$ typ. 3.5~10K
- $K_i$ empirical safety factor
  - $T_0=105 ^{\circ}C$ if ($I>I_R$) then $K_i = 4$ else $K_i = 2$
  - $T_0 = 85 ^\circ C \rightarrow K_i = 2$

### Voltage factor

There are two cases need to take into account when calculate voltage factor $K_V$.

If $0.6 \le \cfrac{U_A}{U_R} \le 1$ then
$$
K_V = \left( \cfrac{U_A}{U_R} \right) ^{-2.5}
$$
else
$$
K_V = 3.59
$$

where

- $U_R$ rated voltage
- $U_A$ actual operating voltage

## References

[^fn1]: Albertsen, A. 2010. Electrolytic capacitor lifetime estimation [Online]. JIANGHAI Eur. GmbH. Available: https://jianghai-europe.com/wp-content/uploads/Jianghai-Europe-E-Cap-Lifetime-Estimation-long-AAL-2018-09-18.pdf [Accessed March 3, 2022].
