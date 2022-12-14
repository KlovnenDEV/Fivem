Config = {}

Config.Jobs = {
    ["electrician"] = "Electrician",
}

Config.Locations = {
    jobs = {
        ["electrician"] = {
            [1] = {
                coords = {x = 1761.46, y = 2540.41, z = 45.56, h = 272.249},
            },
            [2] = {
                coords = {x = 1718.54, y = 2527.802, z = 45.56, h = 272.249},
            },
            [3] = {
                coords = {x = 1700.199, y = 2474.811, z = 45.56, h = 272.249},
            },
            [4] = {
                coords = {x = 1664.827, y = 2501.58, z = 45.56, h = 272.249},
            },
            [5] = {
                coords = {x = 1621.622, y = 2509.302, z = 45.56, h = 272.249},
            },
            [6] = {
                coords = {x = 1627.936, y = 2538.393, z = 45.56, h = 272.249},
            },
            [7] = {
                coords = {x = 1625.1, y = 2575.988, z = 45.56, h = 272.249},
            },
        },
    },
    ["freedom"] = {
        coords = {x = 1779.58, y = 2572.41, z = 45.79, h = 3.5, r = 1.0}, 
    },
    ["outside"] = {
        coords = {x = 1848.13, y = 2586.05, z = 45.67, h = 269.5, r = 1.0}, 
    },
    ["yard"] = {
        coords = {x = 1765.67, y = 2565.91, z = 45.56, h = 1.5, r = 1.0}, 
    },
    ["middle"] = {
        coords = {x = 1723.952, y = 2535, z = 45.5649, h = 123.5},
    },
    ["escapefix"] = {
        coords = {x = 296.22, y = -992.08, z = 45.5649, h = -99.0},
    },
    ["shop"] = {
        coords = {x = 1779.6, y = 2589.82, z = 45.79, h = 0.5, r = 1.0},
    },
    spawns = {
        [1] = {
            animation = "bumsleep",
            coords = {x = 1779.433, y = 2580.534, z = 45.797, h = 45.0},
        },
        --[[[2] = {
            animation = "lean",
            coords = {x = 1650.812, y = 2540.582, z = 45.564, h = 230.436},
        },
        [3] = {
            animation = "lean",
            coords = {x = 1654.959, y = 2545.535, z = 45.564, h = 230.436},
        },
        [4] = {
            animation = "lean",
            coords = {x = 1697.106, y = 2525.558, z = 45.564, h = 187.208},
        },
        [5] = {
            animation = "chair4",
            coords = {x = 1673.084, y = 2519.823, z = 45.564, h = 229.542},
        },
        [6] = {
            animation = "chair",
            coords = {x = 1666.029, y = 2511.367, z = 45.564, h = 233.888},
        },
        [7] = {
            animation = "chair4",
            coords = {x = 1691.229, y = 2509.635, z = 45.564, h = 52.432},
        },
        [8] = {
            animation = "finger2",
            coords = {x = 1770.59, y = 2536.064, z = 45.564, h = 258.113},
        },
        [9] = {
            animation = "smoke",
            coords = {x = 1789.62, y = 2585.79, z = 45.79, h = 88.5, r = 1.0}, 
        },
        [10] = {
            animation = "smoke",
            coords = {x = 1769.29, y = 2577.96, z = 50.54, h = 270.5, r = 1.0}, 
        },
        [11] = {
            animation = "smoke",
            coords = {x = 1769.36, y = 2589.7, z = 50.54, h = 278.5, r = 1.0}, 
        },]]
    }
}

Config.CanteenItems = {
    [1] = {
        name = "sandwich",
        price = 4,
        amount = 50,
        info = {},
        type = "item",
        slot = 1,
    },
    [2] = {
        name = "water_bottle",
        price = 4,
        amount = 50,
        info = {},
        type = "item",
        slot = 2,
    },
}