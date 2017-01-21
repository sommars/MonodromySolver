needsPackage "MonodromySolver"
setRandomSeed 0
needsPackage "ExampleIdeals"

parametrizedCyclic = n -> (
    S := gens cyclicRoots(n,CC);
    R := ring S;
    polys := flatten entries S;
    ind := flatten apply(#polys,i-> -- indices for parameters
    	apply(exponents polys#i, t->(i,t))
    	);
    AR := CC[apply(ind,i->A_i)][gens R];
    polysP := for i to #polys-1 list -- system with parameteric coefficients and same support 
    sum(exponents polys#i, t->A_(i,t)*AR_(t));
    polySystem transpose matrix {polysP}
    )

nedges = 4
nnodes = 3
setRandomSeed 0
polys = parametrizedCyclic 4
(p0,x0) = createSeedPair polySystem polys
mixedVolume = computeMixedVolume specializeSystem (p0,polys)
elapsedTime  monodromySolve(polys,p0,{x0},NumberOfEdges=>nedges,TargetSolutionCount=>mixedVolume,ThreadCount=>4)
