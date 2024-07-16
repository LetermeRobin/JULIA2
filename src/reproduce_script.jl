using Pkg
cd(joinpath(@__DIR__, ".."))
Pkg.activate(".")
Pkg.instantiate()

DEMAND = "Ours" # Change to "NZE" or "DE Gov" to test different scenarios
BROWNFIELD = false
__precompile__(false)

include("data.jl")
countries = ["AT", "BE", "BG", "CY", "CZ", "DE", "DK", "EE", "ES", "FI", "FR", "GR", "HR", "HU", "IE", "IT", "LT", "LU", "LV", "MT", "NL", "PL", "PT", "RO", "SE", "SI", "SK"]
coord_countries = [coord_AT, coord_BE, coord_BG, coord_CY, coord_CZ, coord_DE, coord_DK, coord_EE, coord_ES, coord_FI, coord_FR, coord_GR, coord_HR, coord_HU, coord_IE, coord_IT, coord_LT, coord_LU, coord_LV, coord_MT, coord_NL, coord_PL, coord_PT, coord_RO, coord_SE, coord_SI, coord_SK]
country_prices = [country_price_at, country_price_be, country_price_bg, country_price_cy, country_price_cz, country_price_de, country_price_dk, country_price_ee, country_price_es, country_price_fi, country_price_fr, country_price_gr, country_price_hr, country_price_hu, country_price_ie, country_price_it, country_price_lt, country_price_lu, country_price_lv, country_price_mt, country_price_nl, country_price_pl, country_price_pt, country_price_ro, country_price_se, country_price_si, country_price_sk]
import_countries = [import_at, import_be, import_bg, import_cy, import_cz, import_de, import_dk, import_ee, import_es, import_fi, import_fr, import_gr, import_hr, import_hu, import_ie, import_it, import_lt, import_lu, import_lv, import_mt, import_nl, import_pl, import_pt, import_ro, import_se, import_si, import_sk]
export_countries = [export_AT, export_BE, export_BG, export_CY, export_CZ, export_DE, export_DK, export_EE, export_ES, export_FI, export_FR, export_GR, export_HR, export_HU, export_IE, export_IT, export_LT, export_LU, export_LV, export_MT, export_NL, export_PL, export_PT, export_RO, export_SE, export_SI, export_SK]
TOTAL_DEMAND_countries = [TOTAL_DEMAND_AT, TOTAL_DEMAND_BE, TOTAL_DEMAND_BG, TOTAL_DEMAND_CY, TOTAL_DEMAND_CZ, TOTAL_DEMAND_DE, TOTAL_DEMAND_DK, TOTAL_DEMAND_EE, TOTAL_DEMAND_ES, TOTAL_DEMAND_FI, TOTAL_DEMAND_FR, TOTAL_DEMAND_GR, TOTAL_DEMAND_HR, TOTAL_DEMAND_HU, TOTAL_DEMAND_IE, TOTAL_DEMAND_IT, TOTAL_DEMAND_LT, TOTAL_DEMAND_LU, TOTAL_DEMAND_LV, TOTAL_DEMAND_MT, TOTAL_DEMAND_NL, TOTAL_DEMAND_PL, TOTAL_DEMAND_PT, TOTAL_DEMAND_RO, TOTAL_DEMAND_SE, TOTAL_DEMAND_SI, TOTAL_DEMAND_SK]
pattern_countries = [r"^AT..$",r"^BE..$",r"^BG..$",r"^CY..$",r"^CZ..$",r"^DE..$",r"^DK..$",r"^EE..$",r"^ES..$",r"^FI..$",r"^FR..$",r"^GR..$",r"^HR..$",r"^HU..$",r"^IE..$",r"^IT..$",r"^LT..$",r"^LU..$",r"^LV..$",r"^MT..$",r"^NL..$",r"^PL..$",r"^PT..$",r"^RO..$",r"^SE..$",r"^SI..$",r"^SK..$"]

include("graph_construction.jl")
include("run_model.jl")