Config = Config or {}

Config.Locations = {['X'] = -845.34, ['Y'] = -1088.40, ['Z'] = 11.63}

Config.CraftingItems = {
    [1] = {
      name = "lockpick",
      amount = 50,
      info = {},
      costs = {
        ["metalscrap"] = 22,
        ["plastic"] = 32,
      },
      type = "item",
      slot = 1,
      threshold = 0,
      points = 3,
  },
  [2] = {
    name = "toolkit",
    amount = 50,
    info = {},
    costs = {
      ["metalscrap"] = 30,
      ["plastic"] = 42,
    },
    type = "item",
    slot = 2,
    threshold = 0,
    points = 3,
  },
  [3] = {
    name = "electronickit",
    amount = 50,
    info = {},
    costs = {
      ["metalscrap"] = 30,
      ["plastic"] = 45,
      ["aluminum"] = 28,
    },
    type = "item",
    slot = 3,
    threshold = 0,
    points = 5,
  },
  [4] = {
    name = "plastic-bag",
    amount = 50,
    info = {},
    costs = {
      ["plastic"] = 8,
    },
    type = "item",
    slot = 4,
    threshold = 0,
    points = 2,
  },
  [5] = {
    name = "handcuffs",
    amount = 50,
    info = {},
    costs = {
      ["metalscrap"] = 36,
      ["steel"] = 24,
      ["aluminum"] = 28,
    },
    type = "item",
    slot = 5,
    threshold = 75,
    points = 6,
  },
  [6] = {
    name = "pistol_ammo",
    amount = 50,
    info = {},
    costs = {
      ["metalscrap"] = 50,
      ["steel"] = 37,
      ["copper"] = 26,
    },
    type = "item",
    slot = 6,
    threshold = 115,
    points = 8,
  },
  [7] = {
    name = "armor",
    amount = 50,
    info = {},
    costs = {
      ["iron"] = 33,
      ["steel"] = 44,
      ["plastic"] = 55,
      ["aluminum"] = 22,
    },
    type = "item",
    slot = 7,
    threshold = 150,
    points = 11,
  },
  [8] = {
    name = "repairkit",
    amount = 50,
    info = {},
    costs = {
      ["metalscrap"] = 32,
      ["steel"] = 43,
      ["plastic"] = 61,
    },
    type = "item",
    slot = 8,
    threshold = 170,
    points = 7,
  },
  [9] = {
    name = "ironoxide",
    amount = 50,
    info = {},
    costs = {
      ["iron"] = 60,
      ["glass"] = 30,
    },
    type = "item",
    slot = 9,
    threshold = 200,
    points = 6,
  },
  [10] = {
    name = "aluminumoxide",
    amount = 50,
    info = {},
    costs = {
      ["aluminum"] = 60,
      ["glass"] = 30,
    },
    type = "item",
    slot = 10,
    threshold = 210,
    points = 5,
  },
}

Config.CraftingWeapons = {
  [1] = {
    name = "weapon_assaultrifle_mk2",
    amount = 50,
    info = {
      ammo = 30,
      quality = 100.0,
    },
    costs = {
      ["rifle-body"] = 1,
      ["rifle-clip"] = 1,
      ["rifle-stock"] = 1,
      ["rifle-trigger"] = 1,
    },
    type = "weapon",
    slot = 1,
    description = '[1x Rifle Body, 1x Rifle Clip, 1x Rifle Stock, 1x Rifle Trigger]', 
  },
  [2] = {
    name = "rifle_ammo",
    amount = 50,
    info = {},
    costs = {
      ["metalscrap"] = 64,
      ["steel"] = 46,
      ["copper"] = 35,
    },
    type = "item",
    slot = 2,
    description = '[64x Metaal Schroot, 46x Staal, 35x Koper]', 
  },
}