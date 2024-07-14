# FSRU
This repository accompagnies the article "Validating Energy Policy Consistency: Optimizing Selection and Dimensioning of Gas Terminals in German Ports", currently under revision.

# To reproduce the results, download this repository and install Julia (v1.10 or higher). Execute Julia at the location of this repository and type 'include("D:/Documents/JULIA/src/reproduce_script.jl")' in the REPL. This will run both scenarios and generate the figures found in the Application and Results sections. 

Tu dois mettre le chemin entier vers le reproduce_script.jl comme j'ai fait 



# To generate an interactive map of the network
1. Launch Julia (1.10 or >)
2. Enter the following prompts
    1. `using Pkg`
    2. `Pkg.add(url="https://github.com/HenriDeh/FSRU.jl")`
    3. `using FSRU`
    4. `generate_map_greenfield()`
Alternatively, use `generate_map_brownfield()` at step 4 to obtain the brownfield graph. 
Each step may take a while as the complete project is compiled and the the experiments are reproduced before creating the map. The map will pop in a dedicated interactive window. Use right-click to pan the map and the scroll wheel to zoom. Reset the zoom using Ctrl+left-click.