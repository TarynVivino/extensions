Version 1.0.1 of Spaceship by Zed Lopez begins here.

Include (-
[ spaceship x y k fn;
  fn = KOVComparisonFunction(k);
  if (~~fn) return 0;
  if (fn == UnsignedCompare) return x - y;
  return fn(x, y);
];
-)

To decide what number is (v1 - a value of kind K) <=> (v2 - a K):
    (- spaceship({v1},{v2},{-strong-kind:K}) -)

Spaceship ends here.
