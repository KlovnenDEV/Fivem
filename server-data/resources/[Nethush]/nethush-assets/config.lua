Config = {}

Config.Keys = {
 ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
 ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
 ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
 ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
 ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
 ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
 ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
 ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
 ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

Config.Blips = {

    [1] = {['Name'] = 'Lottery', ['SpriteId'] = 605, ['Color'] = 2, ['Scale'] = 0.6, ['X'] = -1679.74, ['Y'] = -1111.39, ['Z'] = 13.15},
    [2] = {['Name'] = 'Drone Shop', ['SpriteId'] = 627, ['Color'] = 2, ['Scale'] = 0.9, ['X'] = -932.9287, ['Y'] = -383.5694, ['Z'] = 38.9613},
    [3] = {['Name'] = 'Mechanic', ['SpriteId'] = 72, ['Color'] = 81, ['Scale'] = 1.0, ['X'] =  -347.1, ['Y'] = -124.38, ['Z'] = 38.29},
    [4] = {['Name'] = 'Fish Boat', ['SpriteId'] = 410, ['Color'] = 1, ['Scale'] = 0.8, ['X'] = 1551.37, ['Y'] = 3799.74, ['Z'] = 34.41},
    [5] = {['Name'] = 'Tesla VehicleShop', ['SpriteId'] = 326, ['Color'] = 1, ['Scale'] = 0.8, ['X'] = 375.2585, ['Y'] = -750.9224, ['Z'] = 37.7529},
    [6] = {['Name'] = 'Cityhall', ['SpriteId'] = 590, ['Color'] = 0, ['Scale'] = 0.8, ['X'] = -234.5143, ['Y'] = -920.9106, ['Z'] = 32.3122},
    [7] = {['Name'] = 'Weapon Repair', ['SpriteId'] = 173, ['Color'] = 1, ['Scale'] = 0.5, ['X'] = 964.02, ['Y'] = -1267.41, ['Z'] = 34.97},
    [8] = {['Name'] = 'Pawn Shop', ['SpriteId'] = 605, ['Color'] = 46, ['Scale'] = 0.5, ['X'] = 182.26, ['Y'] = -1319.10, ['Z'] = 29.31},
    [9] = {['Name'] = 'Gold Sell', ['SpriteId'] = 605, ['Color'] = 35, ['Scale'] = 0.5, ['X'] = -1468.99, ['Y'] = -406.36, ['Z'] = 36.81},
    [10] = {['Name'] = 'Cherries Farm', ['SpriteId'] = 570, ['Color'] = 46, ['Scale'] = 0.8, ['X'] = 417.0845, ['Y'] = 6520.1616, ['Z'] = 27.7061},
    [11] = {['Name'] = 'Amazon Job', ['SpriteId'] = 535, ['Color'] = 46, ['Scale'] = 0.5, ['X'] = 79.0891, ['Y'] = 108.7839, ['Z'] = 78.8331},
    [12] = {['Name'] = 'Amazon Refuil', ['SpriteId'] = 535, ['Color'] = 46, ['Scale'] = 0.5, ['X'] = 113.3055, ['Y'] = 94.5515, ['Z'] = 80.7766},
    [13] = {['Name'] = 'Ammunation', ['SpriteId'] = 110, ['Color'] = 1, ['Scale'] = 0.6, ['X'] = 19.293, ['Y'] = -1110.566, ['Z'] = 29.797},
    [14] = {['Name'] = 'Locksmith', ['SpriteId'] = 134, ['Color'] = 1, ['Scale'] = 0.68, ['X'] = 170.14, ['Y'] = -1799.22, ['Z'] = 29.31},

}
Config.PropList = {
    -- Casual Props
    ['Drill'] = {
        ['name'] = 'Drill',
        ['prop'] = 'hei_prop_heist_drill',
        ['hash'] = GetHashKey('hei_prop_heist_drill'),
        ['bone-index'] = {
            ['bone'] = 57005,
            ['X'] = 0.14,
            ['Y'] = 0.0,
            ['Z'] = -0.01,
            ['XR'] = 90.0,
            ['YR'] = -90.0,
            ['ZR'] = 180.0,
        },
    },
    ['Duffel'] = {
        ['name'] = 'Duffle Bag',
        ['prop'] = 'xm_prop_x17_bag_01a',
        ['hash'] = GetHashKey('xm_prop_x17_bag_01a'),
        ['bone-index'] = {
            ['bone'] = 28422,
            ['X'] = 0.27,
            ['Y'] = 0.15,
            ['Z'] = 0.05,
            ['XR'] = 35.0,
            ['YR'] = -125.0,
            ['ZR'] = 50.0,
        },
    },
    ['Cup'] = {
        ['name'] = 'Paper Cup',
        ['prop'] = 'prop_cs_paper_cup',
        ['hash'] = GetHashKey('prop_cs_paper_cup'),
        ['bone-index'] = {
            ['bone'] = 28422,
            ['X'] = 0.0,
            ['Y'] = 0.0,
            ['Z'] = 0.0,
            ['XR'] = 0.0,
            ['YR'] = 0.0,
            ['ZR'] = 0.0,
        },
    },
    ['FishingRod'] = {
        ['name'] = 'Fishing rod',
        ['prop'] = 'prop_fishing_rod_01',
        ['hash'] = GetHashKey('prop_fishing_rod_01'),
        ['bone-index'] = {
            ['bone'] = 18905,
            ['X'] = 0.08,
            ['Y'] = 0.0,
            ['Z'] = 0.0,
            ['XR'] = -100.0,
            ['YR'] = 0.0,
            ['ZR'] = -20.0,
        },
    },
    ['Boombox'] = {
        ['name'] = 'Boombox',
        ['prop'] = 'prop_boombox_01',
        ['hash'] = GetHashKey('prop_boombox_01'),
        ['bone-index'] = {
            ['bone'] = 1,
            ['X'] = 1,
            ['Y'] = 1,
            ['Z'] = 1,
            ['XR'] = 1,
            ['YR'] = 1,
            ['ZR'] = 1,
        },
    },
    ['Pills'] = {
        ['name'] = 'Pills',
        ['prop'] = 'prop_cs_pills',
        ['hash'] = GetHashKey('prop_cs_pills'),
        ['bone-index'] = {
            ['bone'] = 1,
            ['X'] = 1,
            ['Y'] = 1,
            ['Z'] = 1,
            ['XR'] = 1,
            ['YR'] = 1,
            ['ZR'] = 1,
        },
    },    
["glasswhiskey"] = {
    ['name'] = 'glasswhiskey',
	["prop"] = "prop_drink_whisky",
    ['hash'] = GetHashKey('prop_drink_whisky'),
	['bone-index'] = {
        ['bone'] = 28422,
        ['X'] = 0.0,
        ['Y'] = 0.0,
        ['Z'] = 0.0,
        ['XR'] = 0.0,
        ['YR'] = 0.0,
        ['ZR'] = 0.0,
	},
},
["bloodymary"] = {
    ['name'] = 'bloodymary',
    ["prop"] = "prop_cocktail",
    ['hash'] = GetHashKey('prop_cocktail'),
    ['bone-index'] = {
        ['bone'] = 28422,
        ['X'] = 0.0,
        ['Y'] = 0.0,
        ['Z'] = 0.0,
        ['XR'] = 0.0,
        ['YR'] = 0.0,
        ['ZR'] = 0.0,
},
},
["pinacolada"] = {
    ['name'] = 'pinacolada',
    ["prop"] = "prop_cocktail",
    ['hash'] = GetHashKey('prop_cocktail'),
    ['bone-index'] = {
        ['bone'] = 28422,
        ['X'] = 0.0,
        ['Y'] = 0.0,
        ['Z'] = 0.0,
        ['XR'] = 0.0,
        ['YR'] = 0.0,
        ['ZR'] = 0.0,
},
},
	["glasswine"] = {
        ['name'] = 'glasswine',
		["prop"] = "p_wine_glass_s",
        ['hash'] = GetHashKey('p_wine_glass_s'),
        ['bone-index'] = {
		["bone"] = 28422,
		["x"] = 0.01,
		["y"] = -0.01,
		["z"] = -0.06,
		["xR"] = 0.0,
		["yR"] = 0.0,
		["zR"] = 0.0
	},},
	["energydrink"] = {
        ['name'] = 'energydrink',
		["prop"] = "prop_energy_drink",
        ['hash'] = GetHashKey('prop_energy_drink'),
        ['bone-index'] = {
		["bone"] = 28422,
		["x"] = 0.0,
		["y"] = 0.0,
		["z"] = 0.0,
		["xR"] = 0.0,
		["yR"] = 0.0,
		["zR"] = 0.0
	},},
	["beer"] = {
        ['name'] = 'beer',
		["prop"] = "prop_beer_bottle",
        ['hash'] = GetHashKey('prop_beer_bottle'),
        ['bone-index'] = {
		["bone"] = 28422,
		["x"] = 0.0,
		["y"] = 0.0,
		["z"] = -0.15,
		["xR"] = 0.0,
		["yR"] = 0.0,
		["zR"] = 0.0
	},},
	["dusche"] = {
        ['name'] = 'dusche',
		["prop"] = "prop_amb_beer_bottle",
        ['hash'] = GetHashKey('prop_amb_beer_bottle'),
        ['bone-index'] = {
		["bone"] = 28422,
		["x"] = 0.0,
		["y"] = 0.0,
		["z"] = 0.0,
		["xR"] = 0.0,
		["yR"] = 0.0,
		["zR"] = 0.0
	},},
	["whiskey"] = {
        ['name'] = 'whiskey',
		["prop"] = "prop_whiskey_bottle",
        ['hash'] = GetHashKey('p_whiskey_bottle_s'),
        ['bone-index'] = {
		["bone"] = 28422,
		["x"] = 0.0,
		["y"] = 0.0,
		["z"] = 0.0,
		["xR"] = 0.0,
		["yR"] = 0.0,
		["zR"] = 0.0
	},},
	["vodka"] = {
        ['name'] = 'vodka',
		["prop"] = "prop_vodka_bottle",
        ['hash'] = GetHashKey('prop_vodka_bottle'),
        ['bone-index'] = {
		["bone"] = 28422,
		["x"] = 0.0,
		["y"] = 0.0,
		["z"] = -0.15,
		["xR"] = 0.0,
		["yR"] = 0.0,
		["zR"] = 0.0
	},},
	["tequila"] = {
        ['name'] = 'tequila',
        ["prop"] = "prop_tequila_bottle",
        ['hash'] = GetHashKey('prop_tequila_bottle'),
        ['bone-index'] = {
		["bone"] = 28422,
		["x"] = 0.0,
		["y"] = 0.0,
		["z"] = -0.15,
		["xR"] = 0.0,
		["yR"] = 0.0,
		["zR"] = 0.0
	},},
	["champagne"] = {
        ['name'] = 'champagne',
        ["prop"] = "prop_wine_white",
        ['hash'] = GetHashKey('prop_wine_white'),
        ['bone-index'] = {
		["bone"] = 28422,
		["x"] = 0.0,
		["y"] = 0.0,
		["z"] = -0.15,
		["xR"] = 0.0,
		["yR"] = 0.0,
		["zR"] = 0.0
	},},
	["whitewine"] = {
        ['name'] = 'whitewine',
		["prop"] = "prop_drink_whtwine",
        ['hash'] = GetHashKey('prop_drink_whtwine'),
        ['bone-index'] = {
		["bone"] = 28422,
		["x"] = 0.0,
		["y"] = 0.0,
		["z"] = -0.15,
		["xR"] = 0.0,
		["yR"] = 0.0,
		["zR"] = 0.0
	},},
    ['ShoppingBag'] = {
        ['name'] = 'Shopping Bags',
        ['prop'] = 'prop_shopping_bags01', 
        ['hash'] = GetHashKey('prop_shopping_bags01'),
        ['bone-index'] = {
            ['bone'] = 28422,
            ['X'] = 0.05,
            ['Y'] = 0.0,
            ['Z'] = 0.0,
            ['XR'] = 35.0,
            ['YR'] = -125.0,
            ['ZR'] = 0.0,
        },
    },
    ['CrackPipe'] = {
        ['name'] = 'Crack Pipe',
        ['prop'] = 'prop_cs_crackpipe',
        ['hash'] = GetHashKey('prop_cs_crackpipe'),
        ['bone-index'] = {
            ['bone'] = 28422,
            ['X'] = 0.0,
            ['Y'] = 0.05,
            ['Z'] = 0.0,
            ['XR'] = 135.0,
            ['YR'] = -100.0,
            ['ZR'] = 0.0,
        },
    },
    ['Bong'] = {
        ['name'] = 'Bong',
        ['prop'] = 'prop_bong_01',
        ['hash'] = GetHashKey('prop_bong_01'),
        ['bone-index'] = {
            ['bone'] = 18905,
            ['X'] = 0.11,
            ['Y'] = -0.23,
            ['Z'] = 0.01,
            ['XR'] = -90.0,
            ['YR'] = 0.0,
            ['ZR'] = 0.0,
        },
    },
    ['HealthPack'] = {
        ['name'] = 'EMS Kit',
        ['prop'] = 'prop_ld_health_pack',
        ['hash'] = GetHashKey('prop_ld_health_pack'),
        ['bone-index'] = {
            ['bone'] = 18905,
            ['X'] = 0.15,
            ['Y'] = 0.08,
            ['Z'] = 0.1,
            ['XR'] = 180.0,
            ['YR'] = 220.0,
            ['ZR'] = 0.0,
        },
    },
    ['ReporterCam'] = {
        ['name'] = 'Weazel News Camera',
        ['prop'] = 'prop_v_cam_01',
        ['hash'] = GetHashKey('prop_v_cam_01'),
        ['bone-index'] = {
            ['bone'] = 57005,
            ['X'] = 0.13,
            ['Y'] = 0.25,
            ['Z'] = -0.03,
            ['XR'] = -85.0,
            ['YR'] = 0.0,
            ['ZR'] = -80.0,
        },
    },
    ['ReporterMic'] = {
        ['name'] = 'Weazel News Mic',
        ['prop'] = 'p_ing_microphonel_01',
        ['hash'] = GetHashKey('p_ing_microphonel_01'),
        ['bone-index'] = {
            ['bone'] = 18905,
            ['X'] = 0.1,
            ['Y'] = 0.05,
            ['Z'] = 0.0,
            ['XR'] = -85.0,
            ['YR'] = -80.0,
            ['ZR'] = -80.0,
        },
    },
    ['BriefCase'] = {
        ['name'] = 'Briefcase',
        ['prop'] = 'prop_ld_case_01',
        ['hash'] = GetHashKey('prop_ld_case_01'),
        ['bone-index'] = {
            ['bone'] = 28422,
            ['X'] = 0.09,
            ['Y'] = -0.012,
            ['Z'] = 0.01,
            ['XR'] = 320.0,
            ['YR'] = -100.0,
            ['ZR'] = 0.0,
        },
    },
    ['GunCase'] = {
        ['name'] = 'A weapon case',
        ['prop'] = 'prop_box_guncase_01a',
        ['hash'] = GetHashKey('prop_box_guncase_01a'),
        ['bone-index'] = {
            ['bone'] = 28422,
            ['X'] = 0.18,
            ['Y'] = 0.05,
            ['Z'] = 0.0,
            ['XR'] = 215.0,
            ['YR'] = -175.0,
            ['ZR'] = 100.0,
        },
    },
    ['Tablet'] = {
        ['name'] = 'A police tablet',
        ['prop'] = 'prop_cs_tablet',
        ['hash'] = GetHashKey('prop_cs_tablet'),
        ['bone-index'] = {
            ['bone'] = 60309,
            ['X'] = 0.03,
            ['Y'] = 0.002,
            ['Z'] = -0.0,
            ['XR'] = 0.0,
            ['YR'] = 160.0,
            ['ZR'] = 0.0,
        },
    }, 
    ['StolenTv'] = {
        ['name'] = 'A flatscreen',
        ['prop'] = 'prop_tv_flat_02',
        ['hash'] = GetHashKey('prop_tv_flat_02'),
        ['bone-index'] = {
            ['bone'] = 57005,
            ['X'] = 0.15,
            ['Y'] = 0.10,
            ['Z'] = -0.20,
            ['XR'] = -50.00,
            ['YR'] = 250.00,
            ['ZR'] = 10.00,
        },
    },
    ['StolenPc'] = {
        ['name'] = 'A computer',
        ['prop'] = 'prop_dyn_pc_02',
        ['hash'] = GetHashKey('prop_dyn_pc_02'),
        ['bone-index'] = {
            ['bone'] = 57005,
            ['X'] = 0.15,
            ['Y'] = 0.10,
            ['Z'] = -0.22,
            ['XR'] = -80.00,
            ['YR'] = -15.00,
            ['ZR'] = -60.00,
        },
    },
    ['StolenMicro'] = {
        ['name'] = 'A microwave',
        ['prop'] = 'prop_microwave_1',
        ['hash'] = GetHashKey('prop_microwave_1'),
        ['bone-index'] = {
            ['bone'] = 57005,
            ['X'] = 0.30,
            ['Y'] = 0.15,
            ['Z'] = -0.20,
            ['XR'] = -50.00,
            ['YR'] = 250.00,
            ['ZR'] = 10.00,
        },
    },
    -- Food Props
    ['hamburger'] = {
        ['name'] = 'Hamburger',
        ['prop'] = 'prop_cs_burger_01',
        ['hash'] = GetHashKey('prop_cs_burger_01'),
        ['bone-index'] = {
            ['bone'] = 18905,
            ['X'] = 0.13,
            ['Y'] = 0.07,
            ['Z'] = 0.02,
            ['XR'] = 120.0,
            ['YR'] = 16.0,
            ['ZR'] = 60.0,
        },
    },
    ['sandwich'] = {
        ['name'] = 'Sandwich',
        ['prop'] = 'prop_sandwich_01',
        ['hash'] = GetHashKey('prop_sandwich_01'),
        ['bone-index'] = {
            ['bone'] = 18905,
            ['X'] = 0.13,
            ['Y'] = 0.05,
            ['Z'] = 0.02,
            ['XR'] = -50.0,
            ['YR'] = 16.0,
            ['ZR'] = 60.0,
        },
    },
    ['chocolade'] = {
        ['name'] = 'Chocolate',
        ['prop'] = 'prop_choc_meto',
        ['hash'] = GetHashKey('prop_choc_meto'),
        ['bone-index'] = {
            ['bone'] = 18905,
            ['X'] = 0.13,
            ['Y'] = 0.05,
            ['Z'] = 0.02,
            ['XR'] = -50.0,
            ['YR'] = 16.0,
            ['ZR'] = 60.0,
        },
    },
    ['donut'] = {
        ['name'] = 'Donut',
        ['prop'] = 'prop_amb_donut',
        ['hash'] = GetHashKey('prop_amb_donut'),
        ['bone-index'] = {
            ['bone'] = 18905,
            ['X'] = 0.13,
            ['Y'] = 0.05,
            ['Z'] = 0.02,
            ['XR'] = -50.0,
            ['YR'] = 16.0,
            ['ZR'] = 60.0,
        },
    },
    ['taco'] = {
        ['name'] = 'Taco',
        ['prop'] = 'prop_taco_01',
        ['hash'] = GetHashKey('prop_taco_01'),
        ['bone-index'] = {
            ['bone'] = 18905,
            ['X'] = 0.13,
            ['Y'] = 0.07,
            ['Z'] = 0.02,
            ['XR'] = 160.0,
            ['YR'] = 0.0,
            ['ZR'] = -50.0,
        },
    },
    ['burger-fries'] = {
        ['name'] = 'Fries',
        ['prop'] = 'prop_food_bs_chips',
        ['hash'] = GetHashKey('prop_food_bs_chips'),
        ['bone-index'] = {
            ['bone'] = 18905,
            ['X'] = 0.12,
            ['Y'] = 0.04,
            ['Z'] = 0.05,
            ['XR'] = 130.0,
            ['YR'] = 8.0,
            ['ZR'] = 200.0,
        },
    },
    -- Drink Props
    ['water'] = {
        ['name'] = 'Bottle of water',
        ['prop'] = 'prop_ld_flow_bottle',
        ['hash'] = GetHashKey('prop_ld_flow_bottle'),
        ['bone-index'] = {
            ['bone'] = 28422,
            ['X'] = 0.0,
            ['Y'] = 0.0,
            ['Z'] = 0.0,
            ['XR'] = 0.0,
            ['YR'] = 0.0,
            ['ZR'] = 0.0,
        },
    },
    ['coffee'] = {
        ['name'] = 'Coffee',
        ['prop'] = 'p_amb_coffeecup_01',
        ['hash'] = GetHashKey('p_amb_coffeecup_01'),
        ['bone-index'] = {
            ['bone'] = 28422,
            ['X'] = 0.0,
            ['Y'] = 0.0,
            ['Z'] = 0.0,
            ['XR'] = 0.0,
            ['YR'] = 0.0,
            ['ZR'] = 0.0,
        },
    },
    ['cola'] = {
        ['name'] = 'Coca Cola can',
        ['prop'] = 'prop_ecola_can',
        ['hash'] = GetHashKey('prop_ecola_can'),
        ['bone-index'] = {
            ['bone'] = 28422,
            ['X'] = 0.0,
            ['Y'] = 0.0,
            ['Z'] = 0.0,
            ['XR'] = 0.0,
            ['YR'] = 0.0,
            ['ZR'] = 0.0,
        },
    },
    ['burger-soft'] = {
        ['name'] = 'Soft Drink',
        ['prop'] = 'ng_proc_sodacup_01a',
        ['hash'] = GetHashKey('ng_proc_sodacup_01a'),
        ['bone-index'] = {
            ['bone'] = 28422,
            ['X'] = 0.0,
            ['Y'] = 0.0,
            ['Z'] = -0.07,
            ['XR'] = 0.0,
            ['YR'] = 0.0,
            ['ZR'] = 0.0,
        },
    },
}

Config.RemoveObjects = {
    [1] = {['X'] = 145.4186, ['Y'] = -1041.813, ['Z'] = 29.64255, ['Model'] = 'v_ilev_gb_teldr'},
    [2] = {['X'] = 309.7491, ['Y'] = -280.1797, ['Z'] = 54.43926, ['Model'] = 'v_ilev_gb_teldr'},
    [3] = {['X'] = -355.3892, ['Y'] = -51.06768, ['Z'] = 49.31105, ['Model'] = 'v_ilev_gb_teldr'},
    [4] = {['X'] = -1214.906, ['Y'] = -334.7281, ['Z'] = 38.05551, ['Model'] = 'v_ilev_gb_teldr'},
    [5] = {['X'] = -2960.176, ['Y'] = 479.0105, ['Z'] = 15.97156, ['Model'] = 'v_ilev_gb_teldr'},
    [6] = {['X'] = -108.9147, ['Y'] = 6469.104, ['Z'] = 31.91028, ['Model'] = 'v_ilev_cbankcountdoor01'},
    [7] = {['X'] = 206.5274, ['Y'] = -803.4797, ['Z'] = 30.95355, ['Model'] = 'prop_sec_barrier_ld_01a'},
    [8] = {['X'] = 230.9218, ['Y'] = -816.153, ['Z'] = 30.16897, ['Model'] = 'prop_sec_barrier_ld_01a'},
    [9] = {['X'] = 261.89, ['Y'] = 223.14, ['Z'] = 106.28, ['Model'] = 'hei_prop_hei_securitypanel'},
    [10] = {['X'] = 1101.84, ['Y'] = -3198.12, ['Z'] = -38.99, ['Model'] = 'bkr_prop_coke_boxeddoll'},
    [11] = {['X'] = -1195.76, ['Y'] = -898.06, ['Z'] = 13.99, ['Model'] = 'bs_cj_int_door_24'},
    [12] = {['X'] = -1194.39, ['Y'] = -894.78, ['Z'] = 13.99, ['Model'] = 'prop_food_bs_tray_02'},
}

Config.BlacklistedScenarios = {
 ['TYPES'] = {
     "WORLD_VEHICLE_MILITARY_PLANES_SMALL",
     "WORLD_VEHICLE_MILITARY_PLANES_BIG",
 },
 ['GROUPS'] = {
     2017590552,
     2141866469,
     1409640232,
     `ng_planes`,
 }
}

Config.BlacklistedVehs = {
 [`SHAMAL`] = true,
 [`LUXOR`] = true,
 [`LUXOR2`] = true,
 [`JET`] = true,
 [`LAZER`] = true,
 [`BUZZARD`] = true,
 [`BUZZARD2`] = true,
 [`ANNIHILATOR`] = true,
 [`SAVAGE`] = true,
 [`TITAN`] = true,
 [`RHINO`] = true,
 [`POLICE`] = true,
 [`POLICE2`] = true,
 [`POLICE3`] = true,
 [`POLICE4`] = true,
 [`POLICEB`] = true,
 [`POLICET`] = true,
 [`SHERIFF`] = true,
 [`SHERIFF2`] = true,
 [`MULE`] = true,
 [`MAVERICK`] = true,
 [`BLIMP`] = true,
 [`CARGOBOB`] = true,   
 [`CARGOBOB2`] = true,   
 [`CARGOBOB3`] = true,   
 [`CARGOBOB4`] = true,   
}

Config.BlacklistedPeds = {
 [`s_m_y_ranger_01`] = true,
 [`s_m_y_sheriff_01`] = true,
 [`s_m_y_cop_01`] = true,
 [`s_f_y_sheriff_01`] = true,
 [`s_f_y_cop_01`] = true,
 [`s_m_y_hwaycop_01`] = true,
}