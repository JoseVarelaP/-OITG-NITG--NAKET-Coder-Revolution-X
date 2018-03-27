-- the SSC Color Library (borrowed for NCRX w/permission) v0.01
-- usage: Colors.[color] where [color] is from the below list.

Colors =
{
Black			 = 0,0,0,1;
White			 = 1,1,1,1;
--[[                    Hue  Sat.  Value*
					  0-360  0-1   0-1
* also known as Brightness and/or Luminosity. However, HSV != HSL != HSB?
]]

--[[ ROYGBIV ]]
Red				 = HSV(  0, 1.00, 1.00);
Orange			 = HSV( 45, 1.00, 1.00);
Yellow			 = HSV( 60, 1.00, 1.00);
Green			 = HSV(120, 1.00, 0.75);
Blue			 = HSV(240, 1.00, 1.00);
Indigo			 = HSV(275, 1.00, 0.75);
Violet			 = HSV(300, 0.45, 0.95);

--[[ more colors sourced from elsewhere ]]
-- http://people.csail.mit.edu/jaffer/Color/crayola.txt
Aquamarine		 = HSV(184, 0.47, 0.89); -- #78DCE3
Cerulean		 = HSV(194, 0.86, 0.84); -- #1DACD6
CottonCandy		 = HSV(325, 0.26, 1.00); -- #FFBDE3
ForestGreen		 = HSV(138, 0.37, 0.68); -- #6DAE81
GrannySmith		 = HSV(113, 0.30, 0.89); -- #A8E4A0
Manatee			 = HSV(231, 0.11, 0.67); -- #979AAA
MidnightBlue	 = HSV(210, 0.78, 0.46); -- #1A4876
OuterSpace		 = HSV(191, 0.14, 0.30); -- #414A4C
PineGreen		 = HSV(176, 0.84, 0.50); -- #158078

-- http://people.csail.mit.edu/jaffer/Color/cne-2007-rgb.txt
CellarBlack		 = HSV(202, 0.72, 0.30); -- #15384C
DuckEggBlue		 = HSV(180, 0.34, 0.93); -- #9EEEEEE
IceBlue			 = HSV(197, 0.26, 0.90); -- #AAD4E5 (more blue)
IcyBlue			 = HSV(180, 0.22, 0.90); -- #B2E5E5 (more green)
LuminousAqua	 = HSV(209, 0.57, 0.70); -- #4C80B2
NeonMint		 = HSV(149, 0.78, 1.00); -- #37FF99
PaleTurquoise	 = HSV(141, 0.31, 1.00); -- #B1FFCC
PhosphorGreen	 = HSV(120, 0.80, 1.00); -- #33FF33
Princess		 = HSV(323, 0.93, 0.85); -- #D8108C
SlateGreen		 = HSV(170, 0.41, 0.56); -- #548E84
SlateGrey		 = HSV(221, 0.16, 0.63); -- #8890A1
Stormy			 = HSV(206, 0.58, 0.60); -- #407299

-- http://people.csail.mit.edu/jaffer/Color/Resene-2007-rgb.txt ? it's long...
-- and if you want more, http://people.csail.mit.edu/jaffer/Color/Dictionaries
-- and http://www.uize.com/examples/sortable-color-table.html

--[[ here are some X11/CSS named colors I like ]]
AliceBlue		 = HSV(208, 0.06, 1.00); -- #F0F8FF
Azure			 = HSV(180, 0.06, 1.00); -- #F0FFFF
Bisque			 = HSV( 33, 0.23, 1.00); -- #FFE4C4
Cornflower		 = HSV(219, 0.58, 0.93); -- #6495ED
Crimson			 = HSV(348, 0.91, 0.86); -- #DC143C
FloralWhite		 = HSV( 40, 0.06, 1.00); -- #FFFAF0
GhostWhite		 = HSV(240, 0.03, 1.00); -- #F8F8FF
Honeydew		 = HSV(120, 0.06, 1.00); -- #F0FFF0
LavenderBlush	 = HSV(340, 0.06, 1.00); -- #FFF0F5
LightBlue		 = HSV(195, 0.25, 0.90); -- #ADD8E6
LightCyan		 = HSV(180, 0.12, 1.00); -- #E0FFFF
LightPink		 = HSV(351, 0.29, 1.00); -- #FFB6C1
LightSkyBlue	 = HSV(203, 0.46, 0.98); -- #87CEFA
MintCream		 = HSV(150, 0.04, 1.00); -- #F5FFFA
Seashell		 = HSV( 25, 0.07, 1.00); -- #FFF5EE
Snow			 = HSV(  0, 0.02, 1.00); -- #FFFAFA
YellowGreen		 = HSV( 80, 0.76, 0.80); -- # (great for DDR Extreme)

-- add your own colors here:
TechGreen		 = HSV(175, 1.00, 1.00);

--[[ end color table -------------------------------------------------------- ]]
};

--[[ see http://en.wikipedia.org/wiki/X11_color_names#Color_variations ]]
function ColorVariant(c,variant)
	local newColor = {};
	local variantMultiples = {
		(93.2/100),	-- 2
		(80.4/100),	-- 3
		(54.8/100),	-- 4
	};
	local multiplyBy = variantMultiples[variant] or 1;

	newColor[1] = c[1] * multiplyBy;
	newColor[2] = c[2] * multiplyBy;
	newColor[3] = c[3] * multiplyBy;
	newColor[4] = c[4];
	return newColor;
end;