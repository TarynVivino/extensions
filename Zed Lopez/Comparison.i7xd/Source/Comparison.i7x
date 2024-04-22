Comparison by Zed Lopez begins here.

Include (-
[ spaceship v1 v2 k cmp_fn;
  if KOVComparisonFunction(k) cmp_fn = (KOVComparisonFunction(k))(v1,v2);
  if ((~~cmp_fn) || (cmp_fn == UnsignedCompare)) return v1 - v2;
  return cmp_fn(v1,v2);
];
-)

To decide what number is (v1 - a value of kind K) <=> (v2 - a K):
    (- spaceship({v1},{v2},{-strong-kind:K}) -)

Comparison ends here.
