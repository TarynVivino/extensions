This is just asimple way to facilitate testing code that isn't
command-centric, intended for use with regtest (but potentially
useful without it). Just set up tests by name like so:

```
Trial "one and one":
	let i be 1;
	let x be i + 1;
	say "[x][line break]";
```

and a corresponding regtest entry:

```
> try one and one
/^2$
```

