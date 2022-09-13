
## mlir

just run all the converters in the same invokation, then lower to llvm ir with mlir-translate, then llc/lli from there

mlir-opt t.mlir --pass-pipeline="func.func(tosa-infer-shapes, tosa-to-linalg-named, tosa-to-linalg, canonicalize, arith-expand, canonicalize)" --one-shot-bufferize="allow-return-allocs allow-unknown-ops create-deallocs=0" --func-bufferize --pass-pipeline="func.func(canonicalize, convert-linalg-to-affine-loops, affine-loop-fusion, lower-affine, finalizing-bufferize, buffer-deallocation, convert-scf-to-cf, convert-math-to-llvm)" --convert-arith-to-llvm --convert-vector-to-llvm --convert-cf-to-llvm --convert-memref-to-llvm --convert-func-to-llvm --canonicalize --llvm-legalize-for-export > t-llvm.mlir
