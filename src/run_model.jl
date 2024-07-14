using FSRU, Distances, JuMP

coord_AT = {}
coord_BE = {"ANTWERPEN": (51.217, 4.4), "ZEEBRUGGE": (51.333, 3.2)}
coord_BG = {"VARNA": (43.183, 27.967)}
coord_CY = {"KYRENIA": (35.35, 33.333), "XEROS": (35.133, 32.833), "DHEKELIA": (34.967, 33.717)}
coord_CZ = {}
coord_DE = {"BREMERHAVEN": (53.533, 8.583), "BRAKE": (53.333, 8.483), "BREMEN": (53.133, 8.767), "EMDEN": (53.333, 7.183), "LEER": (53.233, 7.45), "HEILIGENHAFEN": (54.367, 10.983), "STRALSUND": (54.317, 13.1), "SASSNITZ": (54.517, 13.65), "BUSUM": (54.133, 8.867), "ORTH": (54.45, 11.05)}
coord_DK = {"KERTEMINDE": (55.45, 10.667), "THYBORON": (56.7, 8.217), "RODBY HAVN": (54.65, 11.35), "NYSTED": (54.667, 11.733), "AEROSKOBING": (54.883, 10.417), "ENSTED": (55.017, 9.433), "HORSENS": (55.867, 9.85), "ARHUS": (56.15, 10.217), "STUDSTRUP": (56.25, 10.35), "GRENA HAVN": (56.417, 10.933), "HADSUND": (56.717, 10.117), "MARIAGER": (56.65, 9.983), "HIRTSHALS": (57.6, 9.967), "HANSTHOLM": (57.133, 8.6), "NEKSO": (55.067, 15.133), "HASLE": (55.183, 14.7), "CHRISTIANSO HARBOR": (55.317, 15.183), "FAKSE LADEPLADS HAVN": (55.217, 12.167), "KOGE": (55.45, 12.2), "KOBENHAVN": (55.7, 12.617), "TUBORG": (55.717, 12.583), "HELSINGOR": (56.033, 12.617), "FREDERIKSVAERK": (55.967, 12.017), "FREDERIKSSUND": (55.833, 12.05), "KYNDBYVAERKETS HAVN": (55.817, 11.883), "HOLBAEK": (55.717, 11.717), "SKAELSKOR": (55.25, 11.3), "STIGSNAESVAERKET": (55.2, 11.25), "VORDINGBORG": (55, 11.9), "STEGE": (54.983, 12.283), "LEMVIG": (56.583, 8.283), "SKAERBAEK": (55.517, 9.617), "THISTED": (56.95, 8.7), "HUNDESTED": (55.967, 11.85), "NYKOBING (MOR)": (56.767, 11.867), "GULFHAVEN": (55.2, 11.267)}
coord_EE = {"KUNDA": (59.533, 26.533), "TALLINN": (59.45, 24.767), "PALDISKI": (59.35, 24.033), "OSMUSSAAR": (59.3, 23.367)}
coord_ES = {"PUERTO DE ALCUDIA": (39.833, 3.133), "CUETA": (35.9, -5.317), "PALMA DE MALLORCA": (39.567, 2.633), "SANTA CRUZ DE LA PALMA": (28.683, -17.75), "SANTA CRUZ DE TENERIFE": (28.467, -16.233), "LAS PALMAS": (28.15, -15.417), "PUERTO DEL ROSARIO": (28.5, -13.85), "ARRECIFE": (28.95, -13.533), "ROTA": (36.617, -6.333), "CADIZ": (36.533, -6.3), "MALAGA": (36.717, -4.417), "MOTRIL": (36.75, -3.517), "AGUILAS": (37.4, -1.567), "HORNILLO": (37.4, -1.55), "TORREVIEJA": (37.967, -0.683), "ALICANTE": (38.333, -0.483), "PUERTO DE GANDIA": (39, -0.15), "VALENCIA": (39.45, -0.317), "SAGUNTO": (39.65, -0.217), "EL GRAO": (39.967, 0.017), "TARRAGONA": (41.1, 1.233), "BARCELONA": (41.35, 2.167), "SAN FELIU DE GUIXOLS": (41.783, 3.033), "BERMEO": (43.417, -2.717), "PUERTO DE BILBAO": (43.35, -3.05), "SAN CIPRIAN": (43.7, -7.433), "VILLAGARCIA DE AROSA": (42.6, -8.767), "VIGO": (42.233, -8.717), "IBIZA": (38.9, 1.45), "PUERTO DE GARRUCHA": (37.183, -1.817), "VILLANUEVA Y GELTRU": (41.233, 1.733)}
coord_FI = {"TOLKKINEN": (60.033, 25.583), "RAHJA": (64.2, 23.733), "HELSINKI": (60.167, 24.967), "LOVIISA": (60.45, 26.233), "KOTKA": (60.467, 26.967), "PORKKALA": (60.083, 24.383), "KOKKOLA": (63.85, 23.017), "JAKOBSTAD": (63.683, 22.667), "KANTLAX": (63.417, 22.283), "HELLNAS": (63.283, 22.233), "VAASA": (63.1, 21.583), "KASKINEN": (62.383, 21.233), "KRISTINESTAD": (62.283, 21.4), "MANTYLUOTO": (61.6, 21.483), "TAHKOLUOTO": (61.633, 21.4), "RAUMA": (61.133, 21.5), "NAANTALI": (60.467, 22.017), "SIGNILSKAR": (60.2, 19.333), "PORI": (61.483, 21.8), "PARGAS": (60.283, 22.067)}
coord_FR = {"FOS": (43.417, 4.883), "ANTIBES": (43.583, 7.133), "VILLEFRANCHE": (43.7, 7.317), "BASTIA": (42.7, 9.45), "PORT DE PROPRIANO": (41.683, 8.9), "CALVI": (42.567, 8.75), "L'ILE ROUSSE": (42.633, 8.933), "BORDEAUX": (44.867, -0.567), "PAIMPOL": (48.783, -3.05), "RADE DE BREST": (48.383, -4.5), "CONCARNEAU": (47.867, -3.917), "ST NAZAIRE": (47.283, -2.2), "LA PALLICE": (46.167, -1.217), "LA ROCHELLE": (46.15, -1.15), "ROCHEFORT": (45.933, -0.95), "DUNKERQUE PORT EST": (51.05, 2.383), "BOULOGNE-SUR-MER": (50.733, 1.6), "HONFLEUR": (49.417, 0.217), "RADE DE CHERBOURG": (49.65, -1.633), "BAIE DU MARIGOT": (18.067, -63.083), "DUNKERQUE PORT OUEST": (51.067, 2.35), "GRAVELINES": (51, 2.117), "TOULON": (43.1, 5.917), "GRANVILLE": (48.833, -1.6), "LE LEGUE": (48.533, -2.75), "PONTRIEUX": (48.7, -3.15), "PORT DE ROSCOFF-BLOSCON": (48.733, -3.983), "SAINT-VALERY-SUR-SOMME": (50.183, 1.617), "LE TREPORT": (50.067, 1.367), "PORT OF LE HAVRE": (49.483, 0.117)}
coord_GR = {"MILOS": (36.717, 24.45), "SOUDHA": (35.483, 24.183), "IRAKLION": (35.35, 25.15), "SITIA": (35.217, 26.133), "KALI LIMENES": (34.933, 24.833), "LIMIN KOS": (36.9, 27.283), "KALIMNOS": (36.95, 26.983), "LAKKI": (37.133, 26.85), "ORMOS ALIVERIOU": (38.383, 24.05), "PORTHMOS EVRIPOU": (38.467, 23.583), "LARIMNA": (38.567, 23.283), "STILIS": (38.917, 22.617), "TSINGELI": (39.167, 22.85), "VOLOS": (39.367, 22.95), "MILIANA": (39.167, 23.217), "THESSALONIKI": (40.633, 22.933), "YERAKINI": (40.267, 23.467), "STRATONI": (40.517, 23.833), "LAGOS": (41, 25.133), "ALEXANDROUPOLI": (40.833, 25.883), "PLOMARION": (38.983, 26.367), "VRAKHONISIS KALLONIS": (39.083, 26.083), "KHIOS": (38.367, 26.133), "SAMOS": (37.75, 26.967), "PITHAGORION": (37.683, 26.95), "GAVRIO": (37.883, 24.733), "ANDROS": (37.833, 24.95), "MIKONOS": (37.45, 25.333), "LIMIN SIROU": (37.433, 24.95), "NISOS NAXOS": (37.1, 25.367), "DHIAVLOS STENO": (38.45, 23.6), "KERKIRA": (39.617, 19.933), "PREVEZA": (38.95, 20.75), "ARGOSTOLION": (38.183, 20.517), "MESOLONGION": (38.367, 21.417), "ITEA": (38.433, 22.417), "AIYION": (38.25, 22.083), "KATAKOLON": (37.65, 21.317), "PILOS": (36.9, 21.667), "YITHION": (36.75, 22.567), "NAVPLIO": (37.567, 22.8), "MEGARA OIL TERMINAL": (37.967, 23.4), "PAKHI OIL TERMINAL": (37.967, 23.383), "PIRAIEVS": (37.933, 23.65), "ORMOS MIKRO VATHI": (38.433, 23.6), "ASPROPIRGOS": (38.033, 23.6), "ACHLADI": (38.9, 22.817), "AKRA KAVONISI": (35.517, 23.633), "RETHIMNON": (35.367, 24.467), "SPETSES": (37.267, 23.167), "AYIOS NIKOLAOS": (35.2, 25.717), "LAVRIO": (37.7, 24.067)}
coord_HR = {"UMAG": (45.433, 13.517), "PULA": (44.883, 13.8), "SENJ": (44.983, 14.9), "SPLIT": (43.5, 16.433), "PLOCE": (43.05, 17.433), "DUGI RAT": (43.45, 16.65), "KORCULA": (42.933, 17.133)}
coord_HU = {}
coord_IE = {"GALWAY": (53.267, -9.05), "FENIT": (52.267, -9.867), "BANTRY": (51.683, -9.45), "DUBLIN": (53.35, -6.25), "GREENORE": (54.033, -6.133), "KILLYBEGS": (54.633, -8.45), "VALENTIA": (51.933, -10.3), "CASTLETOWN BEARHAVEN": (51.65, -9.917), "KILRUSH": (52.633, -9.5)}
coord_IT = {"PORTO DI BARLETTA": (41.317, 16.283), "VASTO": (42.117, 14.717), "PORTO DI LIDO-VENEZIA": (45.417, 12.433), "TRIESTE": (45.65, 13.767), "CASTELLAMMARE DI STABIA": (40.7, 14.483), "VIBO VALENTIA MARINA": (38.717, 16.133), "MILAZZO": (38.217, 15.25), "TRAPANI": (38.017, 12.5), "MAZARA DEL VALLO": (37.65, 12.583), "PORTO EMPEDOCLE": (37.283, 13.533), "LICATA": (37.1, 13.933), "GELA": (37.067, 14.25), "POZZALLO": (36.717, 14.85), "SIRACUSA": (37.05, 15.283), "TARANTO": (40.467, 17.2), "GALLIPOLI": (40.05, 17.983), "OTRANTO": (40.15, 18.5), "BARI": (41.133, 16.867), "SAN REMO": (43.817, 7.783), "RADA DI VADO": (44.267, 8.433), "GENOVA": (44.4, 8.933), "LA SPEZIA": (44.1, 9.833), "VADA": (43.35, 10.45), "PORTOVECCHIO DI PIOMBINO": (42.933, 10.55), "PORTO SANTO STEFANO": (42.433, 11.117), "CIVITAVECCHIA": (42.1, 11.783), "NAPOLI": (40.85, 14.267), "PORTO VESME": (39.2, 8.4), "ARBATAX": (39.933, 9.7), "SARROCH OIL TERMINAL": (39.083, 9.033), "MELILLI OIL TERMINAL": (37.117, 15.25), "TERMINI IMERESE": (37.983, 13.7), "BRINDISI": (40.65, 17.983)}
coord_LT = {"BUTINGE OIL TERMINAL": (56.033, 20.95)}
coord_LU = {}
coord_LV = {"VENTSPILS": (57.4, 21.533), "LIEPAJA": (56.517, 21.017)}
coord_MT = {"VALLETTA HARBORS": (35.9, 14.517)}
coord_NL = {"TERNEUZEN": (51.35, 3.817), "HARLINGEN": (53.183, 5.417), "SCHEVENINGEN": (52.1, 4.267), "HANSWEERT": (51.45, 4)}
coord_PL = {"PORT POLNOCHNY": (54.4, 18.717), "GDYNIA": (54.533, 18.55)}
coord_PT = {"FUNCHAL": (32.633, -16.917), "PORTO DE LEIXOES": (41.183, -8.7), "SINES": (37.95, -8.867), "ANGRA DO HEROISMO": (38.65, -27.217), "PRAIA DE VITORIA": (38.717, -27.05), "VILA DO PORTO": (36.933, -25.15)}
coord_RO = {"MANGALIA": (43.817, 28.583), "CONSTANTA": (44.167, 28.65)}
coord_SE = {"STENUNGSUND": (58.067, 11.833), "KARLSBORG": (65.8, 23.283), "SANDVIK": (65.733, 23.767), "FJALLBACKA": (58.6, 11.283), "BOVALLSTRAND": (58.483, 11.333), "HUNNEBOSTRAND": (58.433, 11.3), "LYSEKIL": (58.267, 11.433), "MARSTRAND": (57.883, 11.583), "GOTEBORG": (57.7, 11.967), "VARBERG": (57.117, 12.25), "FALKENBERG": (56.9, 12.5), "HOGANAS": (56.2, 12.55), "HELSINGBORG": (56.05, 12.7), "MALMO": (55.617, 13), "LIMHAMN": (55.583, 12.933), "KARLSKRONA": (56.167, 15.6), "BERGKVARA": (56.383, 16.1), "KALMAR": (56.667, 16.367), "STORA JATTERSON": (57.1, 16.567), "TOREHAMN": (65.9, 22.65), "KOPMANHOLMEN": (63.167, 18.583), "HUSUM": (63.333, 19.15), "RUNDVIK": (63.533, 19.45), "NORDMALING": (63.567, 19.483), "KAGEHAMN": (64.833, 21.033), "BRANNFORS": (65.017, 21.383), "LULEA": (65.583, 22.167), "NORRSUNDET": (60.933, 17.167), "SUNDSVALL": (62.383, 17.35), "VIVSTAVARV": (62.483, 17.35), "SORAKER": (62.5, 17.5), "ULVVIK": (62.667, 17.867), "UTANSJO": (62.767, 17.933), "GUSTAVSVIK": (62.833, 17.883), "LUNDE": (62.883, 17.883), "KRAMFORS": (62.933, 17.8), "KARSKAR": (60.683, 17.267), "BOLLSTABRUK": (63, 17.7), "DEGERHAMN": (56.35, 16.417), "STORUGNS": (57.833, 18.8), "KLINTEHAMN": (57.383, 18.2), "VERKEBACK": (57.733, 16.533), "GUSTAVSBERG": (59.317, 18.383), "SANDHAMN": (59.283, 18.917), "STOCKHOLM": (59.333, 18.05), "GRISSLEHAMN": (60.1, 18.817), "HARGSHAMN": (60.183, 18.45), "FIGEHOLM": (57.367, 16.5), "GREBBESTAD": (58.683, 11.267), "DOMSJO": (63.267, 18.733), "OBBOLA": (63.7, 20.333)}
coord_SI = {}
coord_SK = {}

import_at = {
    'AT': 0.0, 'BE': 0.0, 'BG': 0.0, 'HR': 0.0, 'CY': 0.0, 'CZ': 0.0, 
    'DK': 0.0, 'EE': 0.0, 'FI': 0.0, 'FR': 0.0, 'DE': 0.0, 'GR': 0.0, 
    'HU': 0.0, 'IE': 0.0, 'IT': 0.0, 'LV': 0.0, 'LT': 0.0, 'LU': 0.0, 
    'MT': 0.0, 'NL': 0.0, 'PL': 0.0, 'PT': 0.0, 'RO': 0.0, 'SK': 0.0, 
    'SI': 0.0, 'ES': 0.0, 'SE': 0.0}


import_be = {
    'AT': 0.0, 'BE': 0.0, 'BG': 0.0, 'HR': 0.0, 'CY': 0.0, 'CZ': 0.0, 
    'DK': 0.0705, 'EE': 0.0, 'FI': 0.0, 'FR': 1.5821, 'DE': 0.0, 'GR': 0.0, 
    'HU': 0.0, 'IE': 0.0, 'IT': 0.0, 'LV': 0.0, 'LT': 0.0, 'LU': 0.0, 
    'MT': 0.0, 'NL': 2.2492, 'PL': 0.0, 'PT': 0.0, 'RO': 0.0, 'SK': 0.0, 
    'SI': 0.0, 'ES': 0.0, 'SE': 0.0}

import_bg = {
    'AT': 0.0, 'BE': 0.0, 'BG': 0.0, 'HR': 0.0, 'CY': 0.0, 'CZ': 0.0, 
    'DK': 0.0, 'EE': 0.0, 'FI': 0.0, 'FR': 0.0, 'DE': 0.0, 'GR': 0.766452, 
    'HU': 0.0, 'IE': 0.0, 'IT': 0.0, 'LV': 0.0, 'LT': 0.0, 'LU': 0.0, 
    'MT': 0.0, 'NL': 0.0, 'PL': 0.0, 'PT': 0.0, 'RO': 0.000539, 'SK': 0.0, 
    'SI': 0.0, 'ES': 0.0, 'SE': 0.0}

import_hr = {
    'AT': 0.011145, 'BE': 0.001597, 'BG': 0.0, 'HR': 0.0, 'CY': 0.0, 'CZ': 0.0, 
    'DK': 0.0, 'EE': 0.0, 'FI': 0.0, 'FR': 0.0, 'DE': 0.0, 'GR': 0.0, 
    'HU': 0.095736, 'IE': 0.0, 'IT': 0.0, 'LV': 0.0, 'LT': 0.0, 'LU': 0.0, 
    'MT': 0.0, 'NL': 0.0, 'PL': 0.0, 'PT': 0.0, 'RO': 0.0, 'SK': 0.0, 
    'SI': 0.386551, 'ES': 0.0, 'SE': 0.0}

import_cy = {
    'AT': 0.0, 'BE': 0.0, 'BG': 0.0, 'HR': 0.0, 'CY': 0.0, 'CZ': 0.0, 
    'DK': 0.0, 'EE': 0.0, 'FI': 0.0, 'FR': 0.0, 'DE': 0.0, 'GR': 0.0, 
    'HU': 0.0, 'IE': 0.0, 'IT': 0.0, 'LV': 0.0, 'LT': 0.0, 'LU': 0.0, 
    'MT': 0.0, 'NL': 0.0, 'PL': 0.0, 'PT': 0.0, 'RO': 0.0, 'SK': 0.0, 
    'SI': 0.0, 'ES': 0.0, 'SE': 0.0}

import_cz = {
    'AT': 0.0, 'BE': 0.0, 'BG': 0.0, 'HR': 0.0, 'CY': 0.0, 'CZ': 0.0, 
    'DK': 0.0, 'EE': 0.0, 'FI': 0.0, 'FR': 0.0, 'DE': 0.0, 'GR': 0.0, 
    'HU': 0.0, 'IE': 0.0, 'IT': 0.0, 'LV': 0.0, 'LT': 0.0, 'LU': 0.0, 
    'MT': 0.0, 'NL': 0.0, 'PL': 0.0, 'PT': 0.0, 'RO': 0.0, 'SK': 0.0, 
    'SI': 0.0, 'ES': 0.0, 'SE': 0.0}

import_dk = {
    'AT': 0.0, 'BE': 0.0, 'BG': 0.0, 'HR': 0.0, 'CY': 0.0, 'CZ': 0.0, 
    'DK': 0.0, 'EE': 0.0, 'FI': 0.0, 'FR': 0.0, 'DE': 0.0, 'GR': 0.0, 
    'HU': 0.0, 'IE': 0.0, 'IT': 0.0, 'LV': 0.0, 'LT': 0.0, 'LU': 0.0, 
    'MT': 0.0, 'NL': 0.0, 'PL': 0.0, 'PT': 0.0, 'RO': 0.0, 'SK': 0.0, 
    'SI': 0.0, 'ES': 0.0, 'SE': 0.0}

import_de = {
    'AT': 0.0, 'BE': 0.0, 'BG': 0.0, 'HR': 0.0, 'CY': 0.0, 'CZ': 0.0, 
    'DK': 0.0, 'EE': 0.0, 'FI': 0.0, 'FR': 0.0, 'DE': 0.0, 'GR': 0.0, 
    'HU': 0.0, 'IE': 0.0, 'IT': 0.0, 'LV': 0.0, 'LT': 0.0, 'LU': 0.0, 
    'MT': 0.0, 'NL': 0.0, 'PL': 0.0, 'PT': 0.0, 'RO': 0.0, 'SK': 0.0, 
    'SI': 0.0, 'ES': 0.0, 'SE': 0.0}

import_ee = {
    'AT': 0.0, 'BE': 0.0, 'BG': 0.0, 'HR': 0.0, 'CY': 0.0, 'CZ': 0.0, 
    'DK': 0.0, 'EE': 0.0, 'FI': 0.0, 'FR': 0.0, 'DE': 0.0, 'GR': 0.0, 
    'HU': 0.0, 'IE': 0.0, 'IT': 0.0, 'LV': 0.0, 'LT': 0.06655, 'LU': 0.0, 
    'MT': 0.0, 'NL': 0.0, 'PL': 0.0, 'PT': 0.0, 'RO': 0.0, 'SK': 0.0, 
    'SI': 0.0, 'ES': 0.0, 'SE': 0.0}

import_ie = {
    'AT': 0.0, 'BE': 0.0, 'BG': 0.0, 'HR': 0.0, 'CY': 0.0, 'CZ': 0.0, 
    'DK': 0.0, 'EE': 0.0, 'FI': 0.0, 'FR': 0.0, 'DE': 0.0, 'GR': 0.0, 
    'HU': 0.0, 'IE': 0.0, 'IT': 0.0, 'LV': 0.0, 'LT': 0.0, 'LU': 0.0, 
    'MT': 0.0, 'NL': 0.0, 'PL': 0.0, 'PT': 0.0, 'RO': 0.0, 'SK': 0.0, 
    'SI': 0.0, 'ES': 0.0, 'SE': 0.0}

import_gr = {
    'AT': 0.0, 'BE': 0.0, 'BG': 0.0, 'HR': 0.0, 'CY': 0.0, 'CZ': 0.0, 
    'DK': 0.0, 'EE': 0.0, 'FI': 0.0, 'FR': 0.0, 'DE': 0.0, 'GR': 0.0, 
    'HU': 0.0, 'IE': 0.0, 'IT': 0.0, 'LV': 0.0, 'LT': 0.0, 'LU': 0.0, 
    'MT': 0.0, 'NL': 0.0, 'PL': 0.0, 'PT': 0.0, 'RO': 0.0, 'SK': 0.0, 
    'SI': 0.0, 'ES': 0.038995, 'SE': 0.0058}

import_es = {
    'AT': 0.0, 'BE': 0.002656, 'BG': 0.0, 'HR': 0.0, 'CY': 0.0, 'CZ': 0.0, 
    'DK': 0.0, 'EE': 0.0, 'FI': 0.0, 'FR': 1.695126, 'DE': 0.0, 'GR': 0.0, 
    'HU': 0.0, 'IE': 0.0, 'IT': 0.0, 'LV': 0.0, 'LT': 0.0, 'LU': 0.0, 
    'MT': 0.0, 'NL': 0.000017, 'PL': 0.0, 'PT': 0.416749, 'RO': 0.0, 'SK': 0.0, 
    'SI': 0.0, 'ES': 0.0, 'SE': 0.0}

import_fr = {
    'AT': 0.0, 'BE': 0.076036, 'BG': 0.0, 'HR': 0.0, 'CY': 0.0, 'CZ': 0.0, 
    'DK': 0.0, 'EE': 0.0, 'FI': 0.0, 'FR': 0.0, 'DE': 0.150836, 'GR': 0.0, 
    'HU': 0.0, 'IE': 0.0, 'IT': 0.0, 'LV': 0.0, 'LT': 0.0, 'LU': 0.0, 
    'MT': 0.0, 'NL': 2.144371, 'PL': 0.0, 'PT': 0.0, 'RO': 0.0, 'SK': 0.0, 
    'SI': 0.0, 'ES': 1.070599, 'SE': 0.0}

import_hr = {
    'AT': 0.011145, 'BE': 0.001597, 'BG': 0.0, 'HR': 0.0, 'CY': 0.0, 'CZ': 0.0, 
    'DK': 0.0, 'EE': 0.0, 'FI': 0.0, 'FR': 0.0, 'DE': 0.0, 'GR': 0.0, 
    'HU': 0.095736, 'IE': 0.0, 'IT': 0.0, 'LV': 0.0, 'LT': 0.0, 'LU': 0.0, 
    'MT': 0.0, 'NL': 0.0, 'PL': 0.0, 'PT': 0.0, 'RO': 0.0, 'SK': 0.0, 
    'SI': 0.386551, 'ES': 0.0, 'SE': 0.0}

import_it = {
    'AT': 0.0, 'BE': 0.0, 'BG': 0.0, 'HR': 0.0, 'CY': 0.0, 'CZ': 0.0, 
    'DK': 0.0, 'EE': 0.0, 'FI': 0.0, 'FR': 0.016995, 'DE': 0.0, 'GR': 0.0, 
    'HU': 0.0, 'IE': 0.0, 'IT': 0.0, 'LV': 0.0, 'LT': 0.0, 'LU': 0.0, 
    'MT': 0.0, 'NL': 0.373015, 'PL': 0.0, 'PT': 0.0, 'RO': 0.0, 'SK': 0.0, 
    'SI': 0.022753, 'ES': 0.918329, 'SE': 0.0}

import_lv = {
    'AT': 0.0, 'BE': 0.0, 'BG': 0.0, 'HR': 0.0, 'CY': 0.0, 'CZ': 0.0, 
    'DK': 0.0, 'EE': 0.0, 'FI': 0.0, 'FR': 0.0, 'DE': 0.0, 'GR': 0.0, 
    'HU': 0.0, 'IE': 0.0, 'IT': 0.0, 'LV': 0.0, 'LT': 0.0, 'LU': 0.0, 
    'MT': 0.0, 'NL': 0.0, 'PL': 0.0, 'PT': 0.0, 'RO': 0.0, 'SK': 0.0, 
    'SI': 0.0, 'ES': 0.0, 'SE': 0.0}

import_lt = {
    'AT': 0.0, 'BE': 0.0, 'BG': 0.0, 'HR': 0.0, 'CY': 0.0, 'CZ': 0.0, 
    'DK': 0.0, 'EE': 0.0, 'FI': 0.0, 'FR': 0.0, 'DE': 0.0, 'GR': 0.0, 
    'HU': 0.0, 'IE': 0.0, 'IT': 0.0, 'LV': 0.0, 'LT': 0.0, 'LU': 0.0, 
    'MT': 0.0, 'NL': 0.0, 'PL': 0.0, 'PT': 0.0, 'RO': 0.0, 'SK': 0.0, 
    'SI': 0.0, 'ES': 0.0, 'SE': 0.0}

import_lu = {
    'AT': 0.0, 'BE': 0.0, 'BG': 0.0, 'HR': 0.0, 'CY': 0.0, 'CZ': 0.0, 
    'DK': 0.0, 'EE': 0.0, 'FI': 0.0, 'FR': 0.051891, 'DE': 0.0, 'GR': 0.0, 
    'HU': 0.0, 'IE': 0.0, 'IT': 0.0, 'LV': 0.0, 'LT': 0.0, 'LU': 0.0, 
    'MT': 0.0, 'NL': 0.005601, 'PL': 0.0, 'PT': 0.0, 'RO': 0.0, 'SK': 0.0, 
    'SI': 0.0, 'ES': 0.0, 'SE': 0.0}

import_hu = {
    'AT': 0.0, 'BE': 0.0, 'BG': 0.0, 'HR': 0.0, 'CY': 0.0, 'CZ': 0.0, 
    'DK': 0.0, 'EE': 0.0, 'FI': 0.0, 'FR': 0.0, 'DE': 0.0, 'GR': 0.0, 
    'HU': 0.0, 'IE': 0.0, 'IT': 0.0, 'LV': 0.0, 'LT': 0.0, 'LU': 0.0, 
    'MT': 0.0, 'NL': 0.0, 'PL': 0.0, 'PT': 0.0, 'RO': 0.0, 'SK': 0.0, 
    'SI': 0.0, 'ES': 0.0, 'SE': 0.0}

import_mt = {
    'AT': 0.0, 'BE': 0.0, 'BG': 0.0, 'HR': 0.0, 'CY': 0.0, 'CZ': 0.0, 
    'DK': 0.0, 'EE': 0.0, 'FI': 0.0, 'FR': 0.0, 'DE': 0.0, 'GR': 0.0, 
    'HU': 0.0, 'IE': 0.0, 'IT': 0.0, 'LV': 0.0, 'LT': 0.0, 'LU': 0.0, 
    'MT': 0.0, 'NL': 0.0, 'PL': 0.0, 'PT': 0.0, 'RO': 0.0, 'SK': 0.0, 
    'SI': 0.0, 'ES': 0.0, 'SE': 0.0}

import_nl = {
    'AT': 0.0, 'BE': 1.220783, 'BG': 0.0, 'HR': 0.0, 'CY': 0.0, 'CZ': 0.0, 
    'DK': 0.011432, 'EE': 0.0, 'FI': 0.0, 'FR': 3.199986, 'DE': 0.0, 'GR': 0.0, 
    'HU': 0.0, 'IE': 0.0, 'IT': 0.0, 'LV': 0.0, 'LT': 0.0, 'LU': 0.0, 
    'MT': 0.0, 'NL': 0.0, 'PL': 0.0, 'PT': 0.0, 'RO': 0.0, 'SK': 0.0, 
    'SI': 0.0, 'ES': 1.866299, 'SE': 0.0}

import_pl = {
    'AT': 0.0, 'BE': 0.0, 'BG': 0.0, 'HR': 0.0, 'CY': 0.0, 'CZ': 0.0, 
    'DK': 0.0, 'EE': 0.0, 'FI': 0.0, 'FR': 0.0, 'DE': 0.0, 'GR': 0.0, 
    'HU': 0.0, 'IE': 0.0, 'IT': 0.0, 'LV': 0.0, 'LT': 0.002097, 'LU': 0.0, 
    'MT': 0.0, 'NL': 0.0, 'PL': 0.0, 'PT': 0.0, 'RO': 0.0, 'SK': 0.0, 
    'SI': 0.0, 'ES': 0.0, 'SE': 0.0}

import_pt = {
    'AT': 0.0, 'BE': 0.0, 'BG': 0.0, 'HR': 0.0, 'CY': 0.0, 'CZ': 0.0, 
    'DK': 0.0, 'EE': 0.0, 'FI': 0.0, 'FR': 0.0, 'DE': 0.0, 'GR': 0.0, 
    'HU': 0.0, 'IE': 0.0, 'IT': 0.0, 'LV': 0.0, 'LT': 0.0, 'LU': 0.0, 
    'MT': 0.0, 'NL': 0.0, 'PL': 0.0, 'PT': 0.0, 'RO': 0.0, 'SK': 0.0, 
    'SI': 0.0, 'ES': 1.61503, 'SE': 0.0, }

import_ro = {
    'AT': 0.0, 'BE': 0.0, 'BG': 2.024023, 'HR': 0.0, 'CY': 0.0, 'CZ': 0.0, 
    'DK': 0.0, 'EE': 0.0, 'FI': 0.0, 'FR': 0.0, 'DE': 0.0, 'GR': 0.004789, 
    'HU': 0.417758, 'IE': 0.0, 'IT': 0.000026, 'LV': 0.0, 'LT': 0.0, 'LU': 0.0, 
    'MT': 0.0, 'NL': 0.0, 'PL': 0.0, 'PT': 0.0, 'RO': 0.0, 'SK': 0.029515, 
    'SI': 0.0, 'ES': 0.0, 'SE': 0.0 }

import_se = {
    'AT': 0.0, 'BE': 0.0, 'BG': 0.0, 'HR': 0.0, 'CY': 0.0, 'CZ': 0.0, 
    'DK': 0.0, 'EE': 0.0, 'FI': 0.0, 'FR': 0.0, 'DE': 0.0, 'GR': 0.0, 
    'HU': 0.0, 'IE': 0.0, 'IT': 0.0, 'LV': 0.0, 'LT': 0.0, 'LU': 0.0, 
    'MT': 0.0, 'NL': 0.0, 'PL': 0.0, 'PT': 0.0, 'RO': 0.0, 'SK': 0.0, 
    'SI': 0.0, 'ES': 0.0, 'SE': 0.0}

import_si = {
    'AT': 0.0, 'BE': 0.0, 'BG': 0.0, 'HR': 0.0, 'CY': 0.0, 'CZ': 0.0, 
    'DK': 0.0, 'EE': 0.0, 'FI': 0.0, 'FR': 0.0, 'DE': 0.0, 'GR': 0.0, 
    'HU': 0.0, 'IE': 0.0, 'IT': 0.0, 'LV': 0.0, 'LT': 0.0, 'LU': 0.0, 
    'MT': 0.0, 'NL': 0.0, 'PL': 0.0, 'PT': 0.0, 'RO': 0.0, 'SK': 0.0, 
    'SI': 0.0, 'ES': 0.0, 'SE': 0.0}

import_sk = {
    'AT': 0.0, 'BE': 0.0, 'BG': 0.0, 'HR': 0.0, 'CY': 0.0, 'CZ': 0.0, 
    'DK': 0.0, 'EE': 0.0, 'FI': 0.0, 'FR': 0.0, 'DE': 0.0, 'GR': 0.0, 
    'HU': 0.0, 'IE': 0.0, 'IT': 0.0, 'LV': 0.0, 'LT': 0.0, 'LU': 0.0, 
    'MT': 0.0, 'NL': 0.0, 'PL': 0.0, 'PT': 0.0, 'RO': 0.0, 'SK': 0.0, 
    'SI': 0.0, 'ES': 0.0, 'SE': 0.0}

country_price_at = Dict("DE" => price_hh, "CZ" => price_hh, "SK" => price_hh, "HU" => price_hh, "SI" => price_hh, "IT" => price_hh, "LI" => price_hh)
country_price_be = Dict("FR" => price_ttf, "LU" => price_ttf, "DE" => price_ttf, "NL" => price_ttf)
country_price_bg = Dict("RO" => price_hh, "GR" => price_hh)
country_price_cy = Dict()
country_price_cz = Dict("DE" => price_hh, "PL" => price_hh, "SK" => price_hh, "AT" => price_hh)
country_price_hr = Dict("SI" => price_hh, "HU" => price_hh)
country_price_dk = Dict("DE" => price_hh)
country_price_es = Dict("PT" => price_hh, "FR" => price_hh)
country_price_ee = Dict("LV" => price_hh)
country_price_fi = Dict("SE" => price_hh, "NO" => price_hh, "RU" => price_hh)
country_price_fr = Dict("BE" => price_ttf, "LU" => price_ttf, "DE" => price_ttf, "CH" => price_ttf, "IT" => price_ttf, "ES" => price_ttf)
country_price_gr = Dict("BG" => price_hh)
country_price_hu = Dict("AT" => price_hh, "SK" => price_hh, "RO" => price_hh, "HR" => price_hh, "SI" => price_hh)
country_price_ie = Dict()
country_price_it = Dict("FR" => price_hh, "AT" => price_hh, "SI" => price_hh)
country_price_lv = Dict("EE" => price_hh, "LT" => price_hh)
country_price_lt = Dict("LV" => price_hh, "BY" => price_hh, "PL" => price_hh)
country_price_lu = Dict("BE" => price_ttf, "DE" => price_ttf, "FR" => price_ttf)
country_price_mt = Dict()
country_price_nl = Dict("BE" => price_ttf, "DE" => price_ttf)
country_price_pl = Dict("DE" => price_hh, "CZ" => price_hh, "SK" => price_hh, "LT" => price_hh)
country_price_pt = Dict("ES" => price_hh)
country_price_cz = Dict("DE" => price_hh, "PL" => price_hh, "SK" => price_hh, "AT" => price_hh)
country_price_ro = Dict("UA" => price_hh, "MD" => price_hh, "HU" => price_hh, "RS" => price_hh, "BG" => price_hh)
country_price_sk = Dict("CZ" => price_hh, "PL" => price_hh, "UA" => price_hh, "HU" => price_hh, "AT" => price_hh)
country_price_si = Dict("IT" => price_hh, "AT" => price_hh, "HU" => price_hh, "HR" => price_hh)
country_price_se = Dict("FI" => price_hh)

TOTAL_DEMAND_BE = range(24.1743, 0., length(2025:2050))[2:end]
TOTAL_DEMAND_BG = range(2.911098, 0., length(2025:2050))[2:end]
TOTAL_DEMAND_CZ = range(8.612009, 0., length(2025:2050))[2:end]
TOTAL_DEMAND_DK = range(2.717321, 0., length(2025:2050))[2:end]
TOTAL_DEMAND_DE = range(87.694613, 0., length(2025:2050))[2:end]
TOTAL_DEMAND_EE = range(0.42, 0., length(2025:2050))[2:end]
TOTAL_DEMAND_IE = range(3.846409, 0., length(2025:2050))[2:end]
TOTAL_DEMAND_GR = range(5.727447, 0., length(2025:2050))[2:end]
TOTAL_DEMAND_ES = range(39.692252, 0., length(2025:2050))[2:end]
TOTAL_DEMAND_FR = range(55.350689, 0., length(2025:2050))[2:end]
TOTAL_DEMAND_HR = range(3.0215, 0., length(2025:2050))[2:end]
TOTAL_DEMAND_IT = range(72.591358, 0., length(2025:2050))[2:end]
TOTAL_DEMAND_LV = range(0.841405, 0., length(2025:2050))[2:end]
TOTAL_DEMAND_LT = range(3.5438, 0., length(2025:2050))[2:end]
TOTAL_DEMAND_LU = range(0.588969, 0., length(2025:2050))[2:end]
TOTAL_DEMAND_HU = range(9.314, 0., length(2025:2050))[2:end]
TOTAL_DEMAND_MT = range(0.384442, 0., length(2025:2050))[2:end]
TOTAL_DEMAND_NL = range(38.999713, 0., length(2025:2050))[2:end]
TOTAL_DEMAND_AT = range(12.19007, 0., length(2025:2050))[2:end]
TOTAL_DEMAND_PL = range(15.198471, 0., length(2025:2050))[2:end]
TOTAL_DEMAND_PT = range(5.802921, 0., length(2025:2050))[2:end]
TOTAL_DEMAND_RO = range(2.851023, 0., length(2025:2050))[2:end]
TOTAL_DEMAND_SI = range(0.8353, 0., length(2025:2050))[2:end]
TOTAL_DEMAND_SK = range(6.191, 0., length(2025:2050))[2:end]
TOTAL_DEMAND_FI = range(1.368, 0., length(2025:2050))[2:end]
TOTAL_DEMAND_SE = range(0.751766, 0., length(2025:2050))[2:end]

export_AT = {"AT": 0.0, "BE": 0.0, "BG": 0.0, "CY": 0.0, "CZ": 0.0,
            "DE": 0.0, "DK": 0.0, "EE": 0.0, "ES": 0.0, "FI": 0.0,
            "FR": 0.0, "GR": 0.0, "HR": 0.0, "HU": 0.0, "IE": 0.0,
            "IT": 1.028123, "LT": 0.0, "LU": 0.0, "LV": 0.0, "MT": 0.0,
            "NL": 0.0, "PL": 0.0, "PT": 0.0, "RO": 0.0, "SE": 0.0,
            "SI": 0.0, "SK": 0.0}

export_BE = {"AT": 0.0, "BE": 0.0, "BG": 0.0, "CY": 0.0, "CZ": 0.0,
            "DE": 0.0, "DK": 0.0, "EE": 0.0, "ES": 0.095, "FI": 0.0,
            "FR": 0.0, "GR": 0.0, "HR": 0.0, "HU": 0.0, "IE": 0.0,
            "IT": 0.0, "LT": 0.0, "LU": 0.0, "LV": 0.0, "MT": 0.0,
            "NL": 2.44, "PL": 0.00019, "PT": 0.0, "RO": 0.0, "SE": 0.0,
            "SI": 0.0, "SK": 0.0}

export_BG = {"AT": 0.0, "BE": 0.0, "BG": 0.0, "CY": 0.0, "CZ": 0.0,
            "DE": 0.0, "DK": 0.0, "EE": 0.0, "ES": 0.0, "FI": 0.0,
            "FR": 0.0, "GR": 0.481896, "HR": 0.000327, "HU": 0.0, "IE": 0.0,
            "IT": 0.0, "LT": 0.0, "LU": 0.0, "LV": 0.0, "MT": 0.0,
            "NL": 0.0, "PL": 0.0, "PT": 0.0, "RO": 0.000699, "SE": 0.0,
            "SI": 0.0, "SK": 0.0}

export_CY = {"AT": 0.0, "BE": 0.0, "BG": 0.0, "CY": 0.0, "CZ": 0.0,
            "DE": 0.0, "DK": 0.0, "EE": 0.0, "ES": 0.0, "FI": 0.0,
            "FR": 0.0, "GR": 0.0, "HR": 0.0, "HU": 0.0, "IE": 0.0,
            "IT": 0.0, "LT": 0.0, "LU": 0.0, "LV": 0.0, "MT": 0.0,
            "NL": 0.0, "PL": 0.0, "PT": 0.0, "RO": 0.0, "SE": 0.0,
            "SI": 0.0, "SK": 0.0}

export_CZ = {"AT": 0.0, "BE": 0.0, "BG": 0.0, "CY": 0.0, "CZ": 0.0,
            "DE": 0.0, "DK": 0.0, "EE": 0.0, "ES": 0.0, "FI": 0.0,
            "FR": 0.0, "GR": 0.0, "HR": 0.000090, "HU": 0.0, "IE": 0.0,
            "IT": 0.0, "LT": 0.0, "LU": 0.0, "LV": 0.0, "MT": 0.0,
            "NL": 0.0, "PL": 0.00354, "PT": 0.0, "RO": 0.0, "SE": 0.0,
            "SI": 0.0, "SK": 0.0}

export_DE = {"AT": 0.0, "BE": 6.543, "BG": 0.0, "CY": 0.0, "CZ": 0.0,
            "DE": 0.0, "DK": 0.003610, "EE": 0.0, "ES": 0.104589, "FI": 0.0,
            "FR": 0.0, "GR": 0.0, "HR": 0.0, "HU": 0.0, "IE": 0.0,
            "IT": 0.0, "LT": 0.0, "LU": 0.0, "LV": 0.0, "MT": 0.0,
            "NL": 10.15, "PL": 0.025106, "PT": 0.0, "RO": 0.0, "SE": 0.0,
            "SI": 0.0, "SK": 0.0}

export_DK = {"AT": 0.0, "BE": 0.0, "BG": 0.0, "CY": 0.0, "CZ": 0.0,
            "DE": 0.0, "DK": 0.0, "EE": 0.0, "ES": 0.0, "FI": 0.0,
            "FR": 0.0, "GR": 0.0, "HR": 0.0, "HU": 0.0, "IE": 0.0,
            "IT": 0.0, "LT": 0.0, "LU": 0.0, "LV": 0.0, "MT": 0.0,
            "NL": 0.0, "PL": 0.003882, "PT": 0.0, "RO": 0.0, "SE": 0.0,
            "SI": 0.0, "SK": 0.0}

export_EE = {"AT": 0.0, "BE": 0.0, "BG": 0.0, "CY": 0.0, "CZ": 0.0,
            "DE": 0.0, "DK": 0.0, "EE": 0.0, "ES": 0.0, "FI": 0.0,
            "FR": 0.0, "GR": 0.0, "HR": 0.0, "HU": 0.0, "IE": 0.0,
            "IT": 0.0, "LT": 0.0174, "LU": 0.0, "LV": 0.0, "MT": 0.0,
            "NL": 0.0, "PL": 0.0, "PT": 0.0, "RO": 0.0, "SE": 0.0,
            "SI": 0.0, "SK": 0.0}

export_ES = {"AT": 0.0, "BE": 0.0, "BG": 0.0, "CY": 0.0, "CZ": 0.0,
            "DE": 0.0, "DK": 0.0, "EE": 0.0, "ES": 0.0, "FI": 0.0,
            "FR": 1.964, "GR": 0.0, "HR": 0.0, "HU": 0.0, "IE": 0.0,
            "IT": 0.0, "LT": 0.0, "LU": 0.0, "LV": 0.0, "MT": 0.0,
            "NL": 0.0, "PL": 0.0, "PT": 0.0, "RO": 0.0, "SE": 0.0,
            "SI": 0.0, "SK": 0.0}

export_FI = {"AT": 0.0, "BE": 0.0, "BG": 0.0, "CY": 0.0, "CZ": 0.0,
            "DE": 0.0, "DK": 0.0, "EE": 0.0, "ES": 0.004297, "FI": 0.0,
            "FR": 0.0, "GR": 0.0, "HR": 0.0, "HU": 0.0, "IE": 0.0,
            "IT": 0.0, "LT": 0.0, "LU": 0.0, "LV": 0.0, "MT": 0.0,
            "NL": 0.0, "PL": 0.0, "PT": 0.0, "RO": 0.0, "SE": 0.0,
            "SI": 0.0, "SK": 0.0}

export_FR = {"AT": 0.0, "BE": 0.0425, "BG": 0.0, "CY": 0.0, "CZ": 0.0,
            "DE": 0.0, "DK": 0.0, "EE": 0.0, "ES": 3.273225, "FI": 0.0,
            "FR": 0.0, "GR": 0.0, "HR": 0.0, "HU": 0.0, "IE": 0.0,
            "IT": 0.0, "LT": 0.0, "LU": 0.0, "LV": 0.0, "MT": 0.0,
            "NL": 03.274273, "PL": 0.0, "PT": 0.0, "RO": 0.0, "SE": 0.0,
            "SI": 0.0, "SK": 0.0}

export_GR = {"AT": 0.0, "BE": 0.0, "BG": 0.0, "CY": 0.0, "CZ": 0.0,
            "DE": 0.0, "DK": 0.0, "EE": 0.0, "ES": 0.046971, "FI": 0.0,
            "FR": 0.0, "GR": 0.0, "HR": 0.0, "HU": 0.0, "IE": 0.0,
            "IT": 0.0, "LT": 0.0, "LU": 0.0, "LV": 0.0, "MT": 0.0,
            "NL": 0.0, "PL": 0.0, "PT": 0.0, "RO": 0.0, "SE": 0.0,
            "SI": 0.0, "SK": 0.0}

export_HR = {"AT": 0.0, "BE": 0.0, "BG": 0.0, "CY": 0.0, "CZ": 0.0,
            "DE": 0.0, "DK": 0.0, "EE": 0.0, "ES": 0.015123, "FI": 0.0,
            "FR": 0.0, "GR": 0.0, "HR": 0.0, "HU": 0.0, "IE": 0.0,
            "IT": 0.0, "LT": 0.0, "LU": 0.0, "LV": 0.0, "MT": 0.0,
            "NL": 0.0, "PL": 0.0, "PT": 0.0, "RO": 0.0, "SE": 0.0,
            "SI": 0.0, "SK": 0.0}

export_HU = {"AT": 0.0, "BE": 0.0, "BG": 0.0, "CY": 0.0, "CZ": 0.0,
            "DE": 0.0, "DK": 0.0, "EE": 0.0, "ES": 0.0, "FI": 0.0,
            "FR": 0.0, "GR": 0.0, "HR": 1.019835, "HU": 0.0, "IE": 0.0,
            "IT": 0.0, "LT": 0.0, "LU": 0.0, "LV": 0.0, "MT": 0.0,
            "NL": 0.0, "PL": 0.072342, "PT": 0.0, "RO": 0.0, "SE": 0.0,
            "SI": 0.0, "SK": 0.0}

export_IE = {"AT": 0.0, "BE": 0.0, "BG": 0.0, "CY": 0.0, "CZ": 0.0,
            "DE": 0.0, "DK": 0.0, "EE": 0.0, "ES": 0.0, "FI": 0.0,
            "FR": 0.0, "GR": 0.0, "HR": 0.0, "HU": 0.0, "IE": 0.0,
            "IT": 0.0, "LT": 0.0, "LU": 0.0, "LV": 0.0, "MT": 0.0,
            "NL": 0.0, "PL": 0.0, "PT": 0.0, "RO": 0.0, "SE": 0.0,
            "SI": 0.0, "SK": 0.0}

export_IT = {"AT": 0.0, "BE": 0.0, "BG": 0.0, "CY": 0.0, "CZ": 0.0,
            "DE": 0.0, "DK": 0.0, "EE": 0.0, "ES": 0.799413, "FI": 0.0,
            "FR": 0.125564, "GR": 0.0, "HR": 0.029072, "HU": 0.0, "IE": 0.0,
            "IT": 0.0, "LT": 0.0, "LU": 0.0, "LV": 0.0, "MT": 0.0,
            "NL": 1.788259, "PL": 0.000026, "PT": 0.0, "RO": 0.0, "SE": 0.0,
            "SI": 0.0, "SK": 0.0}

export_LT = {"AT": 0.0, "BE": 0.0, "BG": 0.0, "CY": 0.0, "CZ": 0.0,
            "DE": 0.0, "DK": 0.0, "EE": 0.0, "ES": 0.0, "FI": 0.0,
            "FR": 0.0, "GR": 0.0, "HR": 0.0, "HU": 0.0, "IE": 0.0,
            "IT": 0.0, "LT": 0.0, "LU": 0.0, "LV": 0.0, "MT": 0.0,
            "NL": 0.0, "PL": 0.125462, "PT": 0.0, "RO": 0.0, "SE": 0.0,
            "SI": 0.0, "SK": 0.0}

export_LU = {"AT": 0.0, "BE": 0.1454, "BG": 0.0, "CY": 0.0, "CZ": 0.0,
            "DE": 0.0, "DK": 0.0, "EE": 0.0, "ES": 0.0, "FI": 0.0,
            "FR": 0.0, "GR": 0.0, "HR": 0.0, "HU": 0.0, "IE": 0.0,
            "IT": 0.0, "LT": 0.0, "LU": 0.0, "LV": 0.0, "MT": 0.0,
            "NL": 0.000089, "PL": 0.0, "PT": 0.0, "RO": 0.0, "SE": 0.0,
            "SI": 0.0, "SK": 0.0}

export_LV = {"AT": 0.0, "BE": 0.0, "BG": 0.0, "CY": 0.0, "CZ": 0.0,
            "DE": 0.0, "DK": 0.0, "EE": 0.0, "ES": 0.0, "FI": 0.0,
            "FR": 0.0, "GR": 0.0, "HR": 0.0, "HU": 0.0, "IE": 0.0,
            "IT": 0.0, "LT": 1.5526, "LU": 0.0, "LV": 0.0, "MT": 0.0,
            "NL": 0.0, "PL": 0.000038, "PT": 0.0, "RO": 0.0, "SE": 0.0,
            "SI": 0.0, "SK": 0.0}

export_MT = {"AT": 0.0, "BE": 0.0, "BG": 0.0, "CY": 0.0, "CZ": 0.0,
            "DE": 0.0, "DK": 0.986275, "EE": 0.0, "ES": 0.526836, "FI": 0.0,
            "FR": 0.0, "GR": 0.0, "HR": 0.0, "HU": 0.0, "IE": 0.0,
            "IT": 0.0, "LT": 0.0, "LU": 0.0, "LV": 0.0, "MT": 0.0,
            "NL": 0.0, "PL": 0.0, "PT": 0.0, "RO": 0.0, "SE": 0.0,
            "SI": 0.0, "SK": 0.0}

export_NL = {"AT": 0.0, "BE": 1.7164, "BG": 0.0, "CY": 0.0, "CZ": 0.0,
            "DE": 0.0, "DK": 0.0, "EE": 0.0, "ES": 0.0, "FI": 0.0,
            "FR": 0.0, "GR": 0.0, "HR": 0.0, "HU": 0.0, "IE": 0.0,
            "IT": 0.0, "LT": 0.0, "LU": 0.0, "LV": 0.0, "MT": 0.0,
            "NL": 0.0, "PL": 0.0, "PT": 0.0, "RO": 0.0, "SE": 0.0,
            "SI": 0.0, "SK": 0.0}

export_PL = {"AT": 0.0, "BE": 0.0, "BG": 0.0, "CY": 0.0, "CZ": 0.0,
            "DE": 0.0, "DK": 0.664384, "EE": 0.0, "ES": 0.0, "FI": 0.0,
            "FR": 0.0, "GR": 0.0, "HR": 0.0, "HU": 0.0, "IE": 0.0,
            "IT": 0.0, "LT": 0.4212, "LU": 0.0, "LV": 0.0, "MT": 0.0,
            "NL": 0.0, "PL": 0.0, "PT": 0.0, "RO": 0.0, "SE": 0.0,
            "SI": 0.0, "SK": 0.0}

export_PT = {"AT": 0.0, "BE": 0.0, "BG": 0.0, "CY": 0.0, "CZ": 0.0,
            "DE": 0.0, "DK": 0.0, "EE": 0.0, "ES": 0.0, "FI": 0.0,
            "FR": 0.0, "GR": 0.0, "HR": 0.0, "HU": 0.0, "IE": 0.0,
            "IT": 0.0, "LT": 0.0, "LU": 0.0, "LV": 0.0, "MT": 0.0,
            "NL": 0.0, "PL": 0.0, "PT": 0.522735, "RO": 0.0, "SE": 0.0,
            "SI": 0.0, "SK": 0.0}

export_RO = {"AT": 0.0, "BE": 0.0, "BG": 0.0, "CY": 0.0, "CZ": 0.0,
            "DE": 0.0, "DK": 0.0, "EE": 0.0, "ES": 0.0, "FI": 0.0,
            "FR": 0.0, "GR": 0.0, "HR": 0.0, "HU": 0.0, "IE": 0.0,
            "IT": 0.0, "LT": 0.0, "LU": 0.0, "LV": 0.0, "MT": 0.0,
            "NL": 0.0, "PL": 0.0, "PT": 0.0, "RO": 0.0, "SE": 0.0,
            "SI": 0.0, "SK": 0.0}

export_SE = {"AT": 0.0, "BE": 0.0, "BG": 0.0, "CY": 0.0, "CZ": 0.0,
            "DE": 0.0, "DK": 0.587975, "EE": 0.0, "ES": 0.008579, "FI": 0.0,
            "FR": 0.0, "GR": 0.0, "HR": 0.0, "HU": 0.0, "IE": 0.0,
            "IT": 0.0, "LT": 0.0, "LU": 0.0, "LV": 0.0, "MT": 0.0,
            "NL": 0.0, "PL": 0.0, "PT": 0.0, "RO": 0.0, "SE": 0.0,
            "SI": 0.0, "SK": 0.0}

export_SI = {"AT": 0.0, "BE": 0.0, "BG": 0.0, "CY": 0.0, "CZ": 0.0,
            "DE": 0.0, "DK": 0.0, "EE": 0.0, "ES": 0.0, "FI": 0.0,
            "FR": 0.0, "GR": 0.0, "HR": 0.012354, "HU": 0.0, "IE": 0.0,
            "IT": 1.425147, "LT": 0.0, "LU": 0.0, "LV": 0.0, "MT": 0.0,
            "NL": 0.0, "PL": 0.0, "PT": 0.0, "RO": 0.0, "SE": 0.0,
            "SI": 0.0, "SK": 0.0}

export_SK = {"AT": 0.0, "BE": 0.0, "BG": 0.0, "CY": 0.0, "CZ": 0.0,
            "DE": 0.0, "DK": 0.0, "EE": 0.0, "ES": 0.0, "FI": 0.0,
            "FR": 0.0, "GR": 0.0, "HR": 0.000322, "HU": 0.0, "IE": 0.0,
            "IT": 0.0, "LT": 0.0, "LU": 0.0, "LV": 0.0, "MT": 0.0,
            "NL": 0.0, "PL": 0.00016, "PT": 0.0, "RO": 0.0, "SE": 0.0,
            "SI": 0.0, "SK": 0.0}

countries = ["AT", "BE", "BG", "CY", "CZ", "DE", "DK", "EE", "ES", "FI", "FR", "GR", "HR", "HU", "IE", "IT", "LT", "LU", "LV", "MT", "NL", "PL", "PT", "RO", "SE", "SI", "SK"]
countries_lowercase = [lowercase(country) for country in countries]

coord_countries = [f"coord_{country}" for country in countries] 
country_prices : [f"country_price_{country}" for country in countries_lowercase]
import_countries = [f"import_{country}" for country in countries_lowercase]
export_countries = [f"export_{country}" for country in countries]
TOTAL_DEMANDE_countries = [f"TOTLA_DEMAND_{country}" for country in countries]

g, consumers_dict, domestic_dict, port_dict, import_dict, export_dict  = create_graph(ports_coordinates)

##Sets 
begin
    periods = 1:length(2023:2050)
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
    fsru_set = 1:12
    demand_nodes_set = union(Set(domestic_set), Set(consumers_set))
    supply_nodes_set = union(Set(port_set), Set(import_set))
end
##Parameters 
begin
    γ = 0.99
    demand_multiplier = range(start = 1, stop = 0, length = length(periods)+1)[2:end]
    arc_capacity = Dict([a => get_prop(g, a..., :capacity_Mm3_per_d)*365/1000 for a in arc_set]) #bcm3 per year
    arc_bidirectional = Dict([a => get_prop(g, a..., :is_bidirectional) for a in arc_set])
    arc_length = Dict(a => get_prop(g, a..., :length_km) for a in arc_set)
    flow_cost = 0. #2.64e-5 #M€/km/bcm
    ##Supply
    #import    
    countries_supply = Dict("BE" => 26.58, "AT" => 0.39, "NO" => 49.24, "CZ" => 11.96, "CH" => 1.69, "FR" => 0.42, "PL" => 0.3, "DK" => 0.001, "NL" => 26.15, "FI" => 0.) #bcm3 per year
    price_fsru = 35.29*9769444.44/1e6 #ACER EU spot price [EUR/MWh] converted to M€/bcm (avg 31/03 -> 31/12 2023)
    price_ttf = price_fsru + 2.89*9769444.44/1e6 #add ACER TTF benchmark, converted (avg 31/03 -> 31/12 2023)
    price_hh = 2.496*35315000*1.0867/1e6 #$/mmbtu (US EIA) converted to M€/bcm (US EIA) (avg 04 -> 12 2023)
    country_price = Dict("BE" => price_ttf, "AT" => price_hh, "NO" => price_hh, "CZ" => price_hh, "CH" => price_hh, "FR" => price_ttf, "PL" => price_hh, "DK" => price_hh, "NL" => price_ttf, "FI" => 0.)
    total_import = sum(values(countries_supply))
    #ports
    fsru_per_port = Dict(port_set .=> 1); 
    fsru_per_port[port_dict["Wilhelmshaven"]] = 2
    new_pipeline_length = Dict(node => haversine(ports_coordinates[city], get_prop(g,node,:coordinates))/1000 for (city, node) in port_dict) #km
    investment_horizon = 10
    pipeline_cost_per_km = 0.3  #(capex + opex, depends on diameter) #M€
    total_capex = 1000 - new_pipeline_length[port_dict["Wilhelmshaven"]]*pipeline_cost_per_km*fsru_per_port[port_dict["Wilhelmshaven"]]
    port_capex = fill(sum(total_capex/investment_horizon/(1 + (1-γ))^t for t in 1:investment_horizon), length(periods))
    port_opex = 0.02*total_capex #opex per fsru in use
    #FSRUs
    fsru_cap = Dict(fsru_set .=> 5) #bcm per year
    #all
    total_supply = sum(values(countries_supply))
    ##Demand
    if DEMAND == "Ours"
        TOTAL_DEMAND = range(86.7,0.,length(2022:2050))[2:end]
    elseif DEMAND == "NZE"
        TOTAL_DEMAND = [[(812+855)/2, 812, (794+812)/2]; range(794,582,length(2026:2030)); range(582,0.,length(2030:2050))[2:end]]*0.1
    elseif DEMAND == "DE Gov"
        TOTAL_DEMAND = [[86.0, 85.0, 82.0, 80.3, 78.7, 77.1, 75.5]; range(74.1, 0.,length(2030:2050))]
    else 
        error("Invalid DEMAND parameter \"$DEMAND\"")
    end
    #export
    countries_demand = Dict("BE" => 0., "AT" => 8.03, "LU" => 0., "CZ" => 29.57, "CH" => 3.36, "FR" => 1.37, "PL" => 3.76, "FI" => 0., "DK" => 2.17, "NL" => 2.77) #bcm3 per year 
    total_export = sum(values(countries_demand))                                                  
    #domestic
    total_domestic_demand = 0.59.*TOTAL_DEMAND #bcm3 per year
    TOT = sum(get_prop(g, n, :gdp_percentage) for n in domestic_set)
    nodal_domestic_demand = Dict((n,t) => get_prop(g, n, :gdp_percentage)*total_domestic_demand[t]*1/TOT for n in domestic_set for t in 1:length(periods))
    #industrial
    total_industrial_demand = 0.41.*TOTAL_DEMAND #bcm3 per year
    nodal_industrial_demand = Dict((n,t) => get_prop(g, n, :demand_percentage)*total_industrial_demand[t] for n in consumers_set for t in 1:length(periods))
    #all demand 
    nodal_demand = merge(nodal_domestic_demand, nodal_industrial_demand)
    println("2022: total supply (imports) = $total_supply\ntotal demand = $(TOTAL_DEMAND[1])\ntotal exports = $total_export\nleaving ", TOTAL_DEMAND[1] + total_export - total_supply, " of capacity needed")
end
##Model
begin
    model = Model(HiGHS.Optimizer)
    @variables model begin 
        port_upgrade[port_set,periods], Bin
        port_upgraded[port_set,periods], Bin
        assign_fsru_to_port[port_set, fsru_set,periods], Bin
        0 <= arc_flow[i in arc_set, periods] 
        0 <= import_flow[import_set, periods]
        0 <= export_flow[export_set, periods]
        0 <= fsru_flow[port_set,periods]
    end
    @constraints model begin
        #demand satisfaction and flow conservation
        c_demand_flow[node in setdiff(demand_nodes_set, port_set), t in periods],
            sum(arc_flow[(src, node),t] for src in inneighbors(g, node)) == sum(arc_flow[(node,dst),t] for dst in outneighbors(g, node)) + nodal_demand[(node,t)]
        #demand satisfaction and flow conservation at ports
        c_demand_flow_port[node in port_set,t in periods],
                fsru_flow[node,t] + sum(arc_flow[(src, node),t] for src in inneighbors(g, node)) == sum(arc_flow[(node,dst),t] for dst in outneighbors(g, node)) + nodal_demand[(node,t)]
        #fsru port capacity
        c_fsru_port_capacity[p in port_set,t in periods],
            fsru_flow[p,t] <= sum(assign_fsru_to_port[p, f, t]*fsru_cap[f] for f in fsru_set)
        #import flow
        c_import_flow[node in setdiff(import_set,export_set),t in periods],
            import_flow[node,t] + sum(arc_flow[(src, node),t] for src in inneighbors(g, node)) == sum(arc_flow[(node,dst),t] for dst in outneighbors(g, node))
        #country import 
        c_country_import[c in keys(import_countries_set),t in periods],
            sum(import_flow[n,t] for n in import_countries_set[c]) <= countries_supply[c]
        #export flow
        c_export_flow[node in setdiff(export_set, import_set), t in periods],
            sum(arc_flow[(src, node), t] for src in inneighbors(g, node)) == sum(arc_flow[(node,dst),t] for dst in outneighbors(g, node)) + export_flow[node,t]
        #country export 
        c_country_export[c in keys(export_countries_set),t in periods],
            sum(export_flow[n,t] for n in export_countries_set[c]) == countries_demand[c]*demand_multiplier[t]
        #import + export for nodes that are both
        c_import_export_flow[node in intersect(export_set, import_set),t in periods],
            import_flow[node, t] + sum(arc_flow[(src, node),t] for src in inneighbors(g, node)) == sum(arc_flow[(node,dst),t] for dst in outneighbors(g, node)) + export_flow[node,t]
        #assign FSRU to one port only
        c_fsru_assign[f in fsru_set,t in periods],
            sum(assign_fsru_to_port[port, f, t] for port in port_set) <= 1
        #max fsru per port
        c_port_assign[p in port_set,t in periods],
            sum(assign_fsru_to_port[p, f, t] for f in fsru_set) <= fsru_per_port[p]*port_upgraded[p,t]
        #arc capacities
        c_arc_capacity[a in arc_set,t in periods],
            arc_flow[a,t] <= arc_capacity[a]
        #bidirectional
        c_bidirectional[i in bidirectional_arc_set,t in periods],
            arc_flow[i,t] + arc_flow[(i[2], i[1]),t] <= arc_capacity[i]
        #upgrading
        c_upgrading[p in port_set, t in periods],
            port_upgraded[p,t] <= sum(port_upgrade[p,k] for k in 1:t)

            
    end
    if BROWNFIELD 
        @constraints model begin
            port_upgrade[port_dict["Wilhelmshaven"],1] == 1
            port_upgrade[port_dict["Brunsbüttel"],1] == 1
            port_upgrade[port_dict["Lubmin"],1] == 1
            port_upgrade[port_dict["Stade"],2] == 1
            port_upgrade[port_dict["Mukran"],2] == 1
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
end;
#optimize!(model) #Infeasible

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
for (c,n) in port_dict 
    println(c*"($n)" => round.(Int,value.(port_upgrade)[n,:])')
end
println("\nimports:")
for (c, nodes) in import_countries_set
    println(c => [round(sum(value(import_flow[n,t]) for n in nodes), digits = 3) for t in periods]')
end
println("\nexports:")
for (c, nodes) in export_countries_set    
    println(c => [sum(value(export_flow[n,t]) for n in nodes) for t in periods]')
end
println("\nFSRU imports:")
for (c,n) in port_dict
    println(c*"($n)" => round.(value.(fsru_flow)[n,:], digits =2)')
end


println("capex: ", value(sum(capex_cost)) + value(sum(pipeline_construction_cost)))
println("opex: ", value(sum(opex_cost)))
fsruimp = value(sum(fsru_flow))
println("FSRU imports: ", fsruimp," ", fsruimp*price_fsru)
ttfimp = value(sum(sum(import_flow[n,:]) for n in import_set if n in reduce(vcat, [import_countries_set["BE"], import_countries_set["NL"], import_countries_set["FR"]])))
println("TTF imports: ", ttfimp," ", ttfimp*price_ttf)
hhimp = value(sum(sum(import_flow[n,:]) for n in import_set if n ∉ reduce(vcat, [import_countries_set["BE"], import_countries_set["NL"], import_countries_set["FR"]])))
println("HH imports: ", hhimp," ", hhimp*price_hh)
println("penalty: ", pens*p)
println("total cost (no penalties): ", value(total_cost) -  pens*p)
