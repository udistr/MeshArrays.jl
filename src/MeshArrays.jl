## Module associated with the MeshArrays package

module MeshArrays

include("Types.jl");
include("Grids.jl");
include("Operations.jl");
include("Exchanges.jl");
include("ReadWrite.jl");
include("Demos.jl");
include("Solvers.jl");

export AbstractMeshArray, MeshArray, gcmgrid
export exchange, gradient, convergence, smooth, mask
export GridSpec, GridLoad, GridOfOnes
export TileMap, LatitudeCircles, ThroughFlow
export ScalarPotential, VectorPotential

#The following exch_UV differs from normal exchange; incl. exch_UV_N.
#export exch_UV
#The following is used in NCTiles.jl ... could TileMap be used instead?
#export findtiles

#The following codes add dependencies to Plots
#using Plots; include(joinpath(dirname(pathof(MeshArrays)),"Plots.jl"));

#The following codes add dependencies to NetCDF
#include("gcmfaces_nctiles.jl");

#The following codes add being deprecated
#include("gcmfaces_plot.jl");
#include("gcmfaces_convert.jl");

end # module
