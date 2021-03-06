# MeshArrays.jl


[![Travis Build Status](https://travis-ci.org/juliaclimate/MeshArrays.jl.svg?branch=master)](https://travis-ci.org/juliaclimate/MeshArrays.jl)
[![codecov](https://codecov.io/gh/juliaclimate/MeshArrays.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/juliaclimate/MeshArrays.jl)
[![Coverage Status](https://coveralls.io/repos/github/juliaclimate/MeshArrays.jl/badge.svg?branch=master)](https://coveralls.io/github/juliaclimate/MeshArrays.jl?branch=master)

[![DOI](https://zenodo.org/badge/143987632.svg)](https://zenodo.org/badge/latestdoi/143987632)
[![](https://img.shields.io/badge/docs-stable-blue.svg)](https://juliaclimate.github.io/MeshArrays.jl/stable)
[![](https://img.shields.io/badge/docs-dev-blue.svg)](https://juliaclimate.github.io/MeshArrays.jl/dev)

`MeshArrays.jl` defines the `MeshArray` type that can contain / organize / distribute collections of inter-connected arrays as generally done in climate models. `MeshArrays.jl` thus provides a simple yet efficient and general way to e.g. analyze climate system simulations ([JuliaCon-2018 presentation](https://youtu.be/RDxAy_zSUvg)).

### Installation & Test

```
using Pkg
Pkg.add("MeshArrays")
Pkg.test("MeshArrays")
```

### Use Examples

The example below (1) generates a grid decomposition, (2) seeds random noise everywhere, (3) smoothes out the noise, and (4) plots the (`outer`) array of subdomain (`inner`) arrays. The diffusion-based smoother illustrates how `MeshArrays.jl` computes partial derivatives over the whole domain by transfering data between neighboring subdomains. 

```
using MeshArrays; p=dirname(pathof(MeshArrays))
γ,Γ=GridOfOnes("PeriodicDomain",16,20)

include(joinpath(p,"../examples/Demos.jl"))
(xi,xo,_,_)=demo2(Γ);
show(xo)

using Plots; plotlyjs()
include(joinpath(p,"../examples/Plots.jl"))
heatmap(xo,clims=(-0.25,0.25))
```

Initial noise           |  Smoothed noise 
:------------------------------:|:---------------------------------:
![](docs/images/noise_raw_16tiles.png)  |  ![](docs/images/noise_smooth_16tiles.png)

Above, we used _16 subdomains_, with _40x40 grid points_ each, covering a standard _doubly periodic domain_. However, `MeshArrays.jl` also readily supports elaborate grids commonly used in climate models, such as the ones shown below.

<img src="docs/images/sphere_all.png" width="40%">

As exaplained in [the docs](https://juliaclimate.github.io/MeshArrays.jl/dev), the `MeshArray` type generally looks like this:

```
struct gcmarray{T, N} <: AbstractMeshArray{T, N}
   grid::gcmgrid
   meta::varmeta
   f::Array{Array{T,2},N}
   fSize::Array{NTuple{2, Int}}
   fIndex::Array{Int,1}
   version::String
end
```

### Jupyter Notebooks

The [JuliaCon-2018 presentation](https://youtu.be/RDxAy_zSUvg) corresponds to the first [Jupyter](https://en.wikipedia.org/wiki/Project_Jupyter) notebook found under `DataStructures/` in the [this repo](https://github.com/gaelforget/MeshArrayNotebooks.git). Other included notebooks demonstrate:

- Using`MeshArrays.jl` to accurately compute planetary transports on a ocean model [C-grid](https://en.wikipedia.org/wiki/Arakawa_grids).
- Using [IndividualDisplacements.jl](https://github.com/gaelforget/IndividualDisplacements.jl) to efficiently and accurately compute trajectories of ocean plastic, plankton, etc over the C-grid configurations supported by `MeshArrays.jl`.
- Support for [CF-compliant](http://cfconventions.org) [Netcdf](https://en.wikipedia.org/wiki/NetCDF) input / output of `MeshArray`s, with interpolation or domain decomposition, for `C-grid` variables as provided via [NCTiles.jl](https://gaelforget.github.io/NCTiles.jl/stable/).
- Support for [MITgcm](https://mitgcm.readthedocs.io/en/latest/) use cases and specificities is provided via [MITgcmTools.jl](https://github.com/gaelforget/MITgcmTools.jl).



