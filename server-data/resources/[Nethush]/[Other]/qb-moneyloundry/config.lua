
Config = {}

-- Police Settings:
Config.PoliceDatabaseName = "police"
Config.RequiredPolice = 1				-- Required Police online to rob an ATM.
Config.PoliceNotfiyEnabled = true		-- police notification upon truck robbery enabled (true) or disabled (false)
Config.PoliceBlipShow = true			-- enable or disable blip on map on police notify
Config.PoliceBlipTime = 30				-- miliseconds that blip is active on map (this value is multiplied with 4 in the script)
Config.PoliceBlipRadius = 50.0			-- set radius of the police notify blip
Config.PoliceBlipAlpha = 250			-- set alpha of the blip
Config.PoliceBlipColor = 5				-- set blip color

Config.DispatchMessage = "^3 10-90 ^0 on an ATM at ^5%s^0"

-- Reward Settings:
Config.EnableDirtyCash = true			-- Set between true(receive dirty cash) or false(receive normal cash)		
Config.MinReward = 2000					-- Set minimum payout
Config.MaxReward = 20000					-- Set maximum payout

-- Other Settings:
Config.RobCooldown = 5 					-- (minutes)
Config.Distance = 1.1 					-- Distance for drawTEXT to show


-- List of ATMs
Config.ATMs = {
  {x=89.75, y=2.35, z=68.31},
  {x=1167.02, y=-456.32, z=66.79},	
  {x=-386.733, y=6045.953, z=31.501},
  {x=-283.15, y=6225.92, z=31.49},
  {x=-133.01, y=6366.47, z=31.48},
  {x=-94.96, y=6455.98, z=31.46},
  {x=155.4300, y=6641.991, z=31.784},
  {x=174.6720, y=6637.218, z=31.784},
  {x=1703.138, y=6426.783, z=32.730},
  {x=1735.114, y=6411.035, z=35.164},
  {x=1702.842, y=4933.593, z=42.051},
  {x=1967.333, y=3744.293, z=32.272},
  {x=1821.917, y=3683.483, z=34.244},
  {x=540.0420, y=2671.007, z=42.177},
  {x=2564.399, y=2585.100, z=38.016},
  {x=2558.683, y=349.6010, z=108.050},
  {x=2558.051, y=389.4817, z=108.660},
  {x=1077.692, y=-775.796, z=58.218},
  {x=1139.018, y=-469.886, z=66.789},
  {x=1153.884, y=-326.540, z=69.245},
  {x=381.2827, y=323.2518, z=103.270},
  {x=285.2029, y=143.5690, z=104.970},
  {x=157.7698, y=233.5450, z=106.450},
  {x=-164.568, y=233.5066, z=94.919},
  {x=-1827.04, y=785.5159, z=138.020},
  {x=-1409.39, y=-99.2603, z=52.473},
  {x=-1205.35, y=-325.579, z=37.870},
  {x=-2072.41, y=-316.959, z=13.345},
  {x=-2975.72, y=379.7737, z=14.992},
  {x=-2957.79, y=488.4, z=15.47},
  {x=-3044.22, y=595.2429, z=7.595},
  {x=-3144.13, y=1127.415, z=20.868},
  {x=-3241.10, y=996.6881, z=12.500},
  {x=-3241.11, y=1009.152, z=12.877},
  {x=-1305.40, y=-706.240, z=25.352},
  {x=-538.225, y=-854.423, z=29.234},
  {x=-711.156, y=-818.958, z=23.768},
  {x=-717.614, y=-915.880, z=19.268},
  {x=-526.566, y=-1222.90, z=18.434},
  {x=-256.0, y=-716.05, z=33.51},
  {x=-258.67, y=-723.47, z=33.44},
  {x=-203.548, y=-861.588, z=30.205},
  {x=112.4102, y=-776.162, z=31.427},
  {x=112.9290, y=-818.710, z=31.386},
  {x=119.9000, y=-883.826, z=31.191},
  {x=-618.74, y=-707.9, z=30.5},
  {x=-146.91, y=-1035.23, z=29.34},
  {x=-846.304, y=-340.402, z=38.687},
  {x=-56.1935, y=-1752.53, z=29.452},
  {x=-261.692, y=-2012.64, z=30.121},
  {x=-273.001, y=-2025.60, z=30.197},
  {x=24.589, y=-946.056, z=29.357},
  {x=-254.112, y=-692.483, z=33.616},
  {x=-1570.197, y=-546.651, z=34.955},
  {x=-1415.909, y=-211.825, z=46.500},
  {x=-1430.112, y=-211.014, z=46.500},
  {x=33.232, y=-1347.849, z=29.497},
  {x=129.216, y=-1292.347, z=29.269},
  {x=287.645, y=-1282.646, z=29.659},
  {x=289.012, y=-1256.545, z=29.440},
  {x=295.839, y=-895.640, z=29.217},
  {x=1686.753, y=4815.809, z=42.008},
  {x=-302.408, y=-829.945, z=32.417},
  {x=5.134, y=-919.949, z=29.557},
  {x=-821.4, y=-1082.25, z=11.13},
  {x=-146.83, y=-1035.24, z=29.34},
  {x=-1109.5, y=-1690.57, z=4.37},
  {x=-1315.46, y=-835.46, z=16.96},
  {x=1172.02, y=2702.46, z=38.18},
  {x=-1091.42, y=2708.52, z=18.95}
}