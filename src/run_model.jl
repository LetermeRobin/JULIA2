using FSRU, Distances, JuMP

include("data.jl")

countries = ["AT", "BE", "BG", "CY", "CZ", "DE", "DK", "EE", "ES", "FI", "FR", "GR", "HR", "HU", "IE", "IT", "LT", "LU", "LV", "MT", "NL", "PL", "PT", "RO", "SE", "SI", "SK"]

coord_countries = [coord_AT, coord_BE, coord_BG, coord_CY, coord_CZ, coord_DE, coord_DK, coord_EE, coord_ES, coord_FI, coord_FR, coord_GR, coord_HR, coord_HU, coord_IE, coord_IT, coord_LT, coord_LU, coord_LV, coord_MT, coord_NL, coord_PL, coord_PT, coord_RO, coord_SE, coord_SI, coord_SK]
country_prices = [country_price_at, country_price_be, country_price_bg, country_price_cy, country_price_cz, country_price_de, country_price_dk, country_price_ee, country_price_es, country_price_fi, country_price_fr, country_price_gr, country_price_hr, country_price_hu, country_price_ie, country_price_it, country_price_lt, country_price_lu, country_price_lv, country_price_mt, country_price_nl, country_price_pl, country_price_pt, country_price_ro, country_price_se, country_price_si, country_price_sk]
import_countries = [import_at, import_be, import_bg, import_cy, import_cz, import_de, import_dk, import_ee, import_es, import_fi, import_fr, import_gr, import_hr, import_hu, import_ie, import_it, import_lt, import_lu, import_lv, import_mt, import_nl, import_pl, import_pt, import_ro, import_se, import_si, import_sk]
export_countries = [export_AT, export_BE, export_BG, export_CY, export_CZ, export_DE, export_DK, export_EE, export_ES, export_FI, export_FR, export_GR, export_HR, export_HU, export_IE, export_IT, export_LT, export_LU, export_LV, export_MT, export_NL, export_PL, export_PT, export_RO, export_SE, export_SI, export_SK]
TOTAL_DEMAND_countries = [TOTAL_DEMAND_AT, TOTAL_DEMAND_BE, TOTAL_DEMAND_BG, TOTAL_DEMAND_CY, TOTAL_DEMAND_CZ, TOTAL_DEMAND_DE, TOTAL_DEMAND_DK, TOTAL_DEMAND_EE, TOTAL_DEMAND_ES, TOTAL_DEMAND_FI, TOTAL_DEMAND_FR, TOTAL_DEMAND_GR, TOTAL_DEMAND_HR, TOTAL_DEMAND_HU, TOTAL_DEMAND_IE, TOTAL_DEMAND_IT, TOTAL_DEMAND_LT, TOTAL_DEMAND_LU, TOTAL_DEMAND_LV, TOTAL_DEMAND_MT, TOTAL_DEMAND_NL, TOTAL_DEMAND_PL, TOTAL_DEMAND_PT, TOTAL_DEMAND_RO, TOTAL_DEMAND_SE, TOTAL_DEMAND_SI, TOTAL_DEMAND_SK]

# Loop on each country
for ii in 1:length(countries)

    println("######------ Results for country : $(countries[ii]) ------######")
    println()
    ports_coordinates = coord_countries[ii]
    g, consumers_dict, domestic_dict, port_dict, import_dict, export_dict  = create_graph(ports_coordinates, countries[ii])
    
    # Sets
    periods = 1:length(2025:2050)
    node_set = vertices(g)
    arc_dict = Dict(i => (e.src, e.dst) for (i,e) in enumerate(edges(g)))
    arc_set = values(arc_dict)
    bidirectional_arc_set = Set(a for a in arc_set if get_prop(g, a..., :is_bidirectional)==1)
    for a in bidirectional_arc_set
        pop!(bidirectional_arc_set, (a[2], a[1]))
    end
    consumers_set = values(consumers_dict)
    domestic_set = values(domestic_dict)
    port_set = Set(values(port_dict))
    export_set = values(export_dict)
    import_set = values(import_dict)
    
    export_countries_set = Dict{String, Vector{Int}}()
    for n in export_set
        c = get_prop(g, n, :country) 
        if haskey(export_countries_set, c)
            push!(export_countries_set[c], n)
        else
            export_countries_set[c] = [n]
        end
    end

    import_countries_set = Dict{String, Vector{Int}}() 
    for n in import_set
        c = get_prop(g, n, :country)
        if haskey(import_countries_set, c)
            push!(import_countries_set[c], n)
        else
            import_countries_set[c] = [n]
        end
    end

    fsru_set = 1:20
    demand_nodes_set = union(Set(domestic_set), Set(consumers_set))
    supply_nodes_set = union(Set(port_set), Set(import_set))

    # Parameters
    γ = 0.99
    demand_multiplier = range(start = 1, stop = 0, length = length(periods)+1)[2:end]
    arc_capacity = Dict([a => get_prop(g, a..., :capacity_Mm3_per_d)*365/1000 for a in arc_set]) #bcm3 per year
    arc_bidirectional = Dict([a => get_prop(g, a..., :is_bidirectional) for a in arc_set])
    arc_length = Dict(a => get_prop(g, a..., :length_km) for a in arc_set)
    flow_cost = 0.0 #M€/km/bcm
    
    # Supply / Import
    countries_supply = import_countries[ii]
    country_price = country_prices[ii]
    total_import = sum(values(countries_supply))

    # Ports
    fsru_per_port = Dict(port_set .=> 1); 
    new_pipeline_length = Dict(node => haversine(ports_coordinates[city], get_prop(g,node,:coordinates))/1000 for (city, node) in port_dict) #km
    investment_horizon = 10
    pipeline_cost_per_km = 0.3  #(capex + opex, depends on diameter) #M€
    total_capex = 1000 #- new_pipeline_length[port_dict["Wilhelmshaven"]]*pipeline_cost_per_km*fsru_per_port[port_dict["Wilhelmshaven"]]
    port_capex = fill(sum(total_capex/investment_horizon/(1 + (1-γ))^t for t in 1:investment_horizon), length(periods))
    port_opex = 0.02*total_capex #opex per fsru in use

    # FSRUs
    fsru_cap = Dict(fsru_set .=> 5) #bcm per year

    # All
    total_supply = sum(values(countries_supply))
    
    # Demand
    TOTAL_DEMAND = TOTAL_DEMAND_countries[ii]

    # Export
    countries_demand = export_countries[ii] 
    total_export = sum(values(countries_demand))
    
    # Domestic
    total_domestic_demand = 0.59 * TOTAL_DEMAND #bcm3 per year
    for n in domestic_set
        if hasproperty(g, node_id, :gdp_percentage)
            current_percentage = get_prop(g, node_id, :gdp_percentage)
        else
            current_percentage = 0.0  # Initialize to zero if property doesn't exist
        end
        TOT += current_percentage
    end
    for n in domestic_set
        if hasproperty(g, node_id, :gdp_percentage)
            current_percentage = get_prop(g, node_id, :gdp_percentage)
        else
            current_percentage = 0.0  # Initialize to zero if property doesn't exist
        end
        nodal_domestic_demand = Dict((n,t) => current_percentage*total_domestic_demand[t]*1/TOT for t in 1:length(periods))
    end

    
    
    TOT = sum(get_prop(g, n, :gdp_percentage) for n in domestic_set)
    nodal_domestic_demand = Dict((n,t) => get_prop(g, n, :gdp_percentage)*total_domestic_demand[t]*1/TOT for n in domestic_set for t in 1:length(periods))
    
    # Industrial
    total_industrial_demand = 0.41 * TOTAL_DEMAND #bcm3 per year
    nodal_industrial_demand = Dict((n,t) => get_prop(g, n, :demand_percentage)*total_industrial_demand[t] for n in consumers_set for t in 1:length(periods))
    
    # All demand 
    nodal_demand = merge(nodal_domestic_demand, nodal_industrial_demand)
    
    println("2022: total supply (imports) = $total_supply\ntotal demand = $(TOTAL_DEMAND[1])\ntotal exports = $total_export\nleaving ", TOTAL_DEMAND[1] + total_export - total_supply, " of capacity needed")


    # Model
    model = Model(HiGHS.Optimizer)
    @variables model begin 
        port_upgrade[port_set, periods], Bin
        port_upgraded[port_set, periods], Bin
        assign_fsru_to_port[port_set, fsru_set, periods], Bin
        0 <= arc_flow[i in arc_set, periods]
        0 <= import_flow[import_set, periods]
        0 <= export_flow[export_set, periods]
        0 <= fsru_flow[port_set, periods]
    end

    #Constraints
    @constraints model begin
        # Demande satisfaction et conservation du flux
        c_demand_flow[node in setdiff(demand_nodes_set, port_set), t in periods],
            sum(arc_flow[(src, node), t] for src in inneighbors(g, node)) == sum(arc_flow[(node, dst), t] for dst in outneighbors(g, node)) + nodal_demand[(node, t)]
        # Satisfaction de la demande et conservation du flux aux ports
        c_demand_flow_port[node in port_set, t in periods],
            fsru_flow[node, t] + sum(arc_flow[(src, node), t] for src in inneighbors(g, node)) == sum(arc_flow[(node, dst), t] for dst in outneighbors(g, node)) + nodal_demand[(node, t)]
        # Capacité du port FSRU
        c_fsru_port_capacity[p in port_set, t in periods],
            fsru_flow[p, t] <= sum(assign_fsru_to_port[p, f, t] * fsru_cap[f] for f in fsru_set)
        # Flux d'importation
        c_import_flow[node in setdiff(import_set, export_set), t in periods],
            import_flow[node, t] + sum(arc_flow[(src, node), t] for src in inneighbors(g, node)) == sum(arc_flow[(node, dst), t] for dst in outneighbors(g, node))
        # Importation par pays
        c_country_import[c in keys(import_countries_set), t in periods],
            sum(import_flow[n, t] for n in import_countries_set[c]) <= countries_supply[c]
        # Flux d'exportation
        c_export_flow[node in setdiff(export_set, import_set), t in periods],
            sum(arc_flow[(src, node), t] for src in inneighbors(g, node)) == sum(arc_flow[(node, dst), t] for dst in outneighbors(g, node)) + export_flow[node, t]
        # Exportation par pays
        c_country_export[c in keys(export_countries_set), t in periods],
            sum(export_flow[n, t] for n in export_countries_set[c]) == countries_demand[c] * demand_multiplier[t]
        # Importation + exportation pour les nœuds qui sont les deux
        c_import_export_flow[node in intersect(export_set, import_set), t in periods],
            import_flow[node, t] + sum(arc_flow[(src, node), t] for src in inneighbors(g, node)) == sum(arc_flow[(node, dst), t] for dst in outneighbors(g, node)) + export_flow[node, t]
        # Assignation FSRU à un seul port
        c_fsru_assign[f in fsru_set, t in periods],
            sum(assign_fsru_to_port[port, f, t] for port in port_set) <= 1
        # Max FSRU par port
        c_port_assign[p in port_set, t in periods],
            sum(assign_fsru_to_port[p, f, t] for f in fsru_set) <= fsru_per_port[p] * port_upgraded[p, t]
        # Capacités des arcs
        c_arc_capacity[a in arc_set, t in periods],
            arc_flow[a, t] <= arc_capacity[a]
        # Bidirectionnel
        c_bidirectional[i in bidirectional_arc_set, t in periods],
            arc_flow[i, t] + arc_flow[(i[2], i[1]), t] <= arc_capacity[i]
        # Mise à niveau
        c_upgrading[p in port_set, t in periods],
            port_upgraded[p, t] <= sum(port_upgrade[p, k] for k in 1:t)
    end

    end
    @expression(model, capex_cost[t in periods], sum(port_upgrade[p,t]*port_capex[t] for p in port_set))
    @expression(model, opex_cost[t in periods], sum(assign_fsru_to_port[p,f,t]*port_opex for p in port_set, f in fsru_set))
    @expression(model, pipeline_construction_cost[t in periods], sum(port_upgrade[p,t]*fsru_per_port[p]*new_pipeline_length[p]*pipeline_cost_per_km for p in port_set))
    @expression(model, arc_flow_cost[t in periods], sum(arc_flow[a,t]*arc_length[a] for a in arc_set)*flow_cost)
    @expression(model, fsru_price_cost[t in periods], sum(fsru_flow[p,t] for p in port_set)*price_fsru)
    @expression(model, import_price_cost[t in periods], sum(country_price[c]*import_flow[n,t] for c in keys(import_countries_set) for n in import_countries_set[c]))
    @expression(model, total_cost, sum(γ^t*(capex_cost[t] + opex_cost[t] +  pipeline_construction_cost[t] + arc_flow_cost[t] + fsru_price_cost[t] + import_price_cost[t]) for t in periods))
    @objective model Min total_cost
    p = 1e0
    c_map = relax_with_penalty!(model, merge(Dict(model[:c_arc_capacity] .=> p), Dict(model[:c_bidirectional] .=> p)))

    optimize!(model)
    solution_summary(model)
    penalties = Dict(con => value(penalty) for (con, penalty) in c_map if value(penalty) > 0);
    @assert all(>=(0), values(penalties))
    maximum(values(penalties))
    pens = sum(values(penalties))

    penalized_cons = filter(kv -> value(kv.second) > 0, c_map)
    penalized_arcs = [eval(Meta.parse(match(r"\[(.*)\]", name(k)).captures[1]))[1] for k in keys(penalized_cons)] |> unique

    println("\nPort upgrades:")
    for (c, n) in port_dict 
        println(c * "($n)" => round.(Int, value.(port_upgrade)[n, :])')
    end
    println("\nimports:")
    for (c, nodes) in import_countries_set
        println(c => [round(sum(value(import_flow[n, t]) for n in nodes), digits = 3) for t in periods]')
    end
    println("\nexports:")
    for (c, nodes) in export_countries_set    
        println(c => [sum(value(export_flow[n, t]) for t in periods) for n in nodes]')
    end
    println("\nFSRU imports:")
    for (c,n) in port_dict
        println(c*"($n)" => round.(value.(fsru_flow)[n,:], digits =2)')
    end

    println("capex: ", value(sum(capex_cost)) + value(sum(pipeline_construction_cost)))
    println("opex: ", value(sum(opex_cost)))
    fsruimp = value(sum(fsru_flow))
    println("FSRU imports: ", fsruimp," ", fsruimp*price_fsru)

    # Filtre sur les pays BE NL FR 
    ttfimp = value(sum(sum(import_flow[n,:]) for n in import_set if n in reduce(vcat, [import_countries_set["BE"], import_countries_set["NL"], import_countries_set["FR"]])))
    println("TTF imports: ", ttfimp," ", ttfimp*price_ttf)

    # Filtre sur les pays BE NL FR 
    hhimp = value(sum(sum(import_flow[n,:]) for n in import_set if n ∉ reduce(vcat, [import_countries_set["BE"], import_countries_set["NL"], import_countries_set["FR"]])))
    println("HH imports: ", hhimp," ", hhimp*price_hh)

    
    println("penalty: ", pens*p)
    println("total cost (no penalties): ", value(total_cost) -  pens*p)




    
    # Display and registration of plots
    
    if !BROWNFIELD  # brownfield = false
        include("graph_plotting.jl")
        FSRU.GLMakie.activate!(inline=true)

        map = map_network(g, consumers_dict, domestic_dict, port_dict, import_dict, export_dict, ports_coordinates, highlight_arcs = penalized_arcs)
        save("$(countries[ii])_map.png", map)
    end

    colors = [Makie.wong_colors(); [:green, :darkblue, :lightgreen]]
    imports = [c => [round(sum(value(import_flow[n,t]) for n in nodes), digits = 3) for t in periods] for (c, nodes) in import_countries_set]
    sort!(imports, by = p -> first(p.second), rev = true)
    f = Figure(size = (2560, 1000)./3);
    ax=Axis(f[1, 1], xlabel = "Year", ylabel = "bcm", xticks = (collect(1:3:length(periods)), string.(collect(2023:3:2050))), yscale = Makie.pseudolog10, yticks = [0,5,10,20,40,60])
    for (i,(c, ys)) in enumerate(imports) 
        if first(ys) > 0
            lines!(periods, ys, label = c, color = colors[i], linestyle = c in ("NL", "BE", "FR") ? :dash : :solid, linewidth = c in ("NL", "BE", "FR") ? 3 : 2)
        end
    end
    f[1,2] = Legend(f, ax, "Country", margin = (0, 0, 0, 0), halign = :left, valign = :center, tellheight = false, tellwidth = true)

    if BROWNFIELD
        save("pipeline_imports_res_$(countries[ii]).png", f)
    else
        save("pipeline_imports_free_$(countries[ii]).png", f)
    end

    fsru_imports = [c => round.(value.(fsru_flow)[n,:], digits =2).data for (c,n) in port_dict if sum(value.(fsru_flow)[n,:]) > 0]
    sort!(fsru_imports, by = p -> first(p.second), rev = false)
    f = Figure(size = (2560, 1000)./3);
    ax=Axis(f[1, 1], xlabel = "Year", ylabel = "bcm", limits = ((0, length(2022:2050)),(0,37)), xticks = (collect(1:3:length(periods)), string.(collect(2023:3:2050))))
    tbl = (year=Int[],country=String[], imports=Float64[], stackgrp=Int[])
    for (i,(c, ys)) in enumerate(fsru_imports)
        if sum(ys) > 0
            for (t,y) in enumerate(ys)
                push!(tbl.year, t)
                push!(tbl.country, c)
                push!(tbl.stackgrp, i)
                push!(tbl.imports, y)
            end
        end
    end
    barplot!(ax,tbl.year, tbl.imports, stack = tbl.stackgrp, label = tbl.country, color = [colors[g] for g in tbl.stackgrp])
    Legend(f[1,1], reverse([PolyElement(polycolor = colors[i]) for i in 1:length(unique(tbl.country))]), reverse(unique(tbl.country)), "Port", margin = (10, 10, 10, 10), halign = :right, valign = :top, tellheight = false, tellwidth = false)

    if BROWNFIELD
        save("fsru_imports_res_$(countries[ii]).png", f)
    else
        save("fsru_imports_free_$(countries[ii]).png", f)
    end
end
