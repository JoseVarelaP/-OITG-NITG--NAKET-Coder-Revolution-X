-- theme identification file
SSC = (GetProductName() == "sm-ssc");
NITG = (GetProductName() == "OpenITG PC FUCK DEV");

function ScreenCompanyIntroText()
	return "NAKET Coder Revolution X is copyright ©2008-2010 NAKET Team and StepMania Underground. All rights reserved. This theme uses extensions by KKI Labs (http://kki.ajworld.net/) and vyhd (GenreGen). For updates and more information, please visit the StepMania Underground website: http://smug.boxorroxors.net/\n\nPresented by the NAKET Team:\nNAKET Coder, Synikal, Anonymous Zig, Vacant Vagrant, PhosphorusGL"
end

local function part2()
	return PREFSMAN:GetPreference('PAL') and "PAL" or "NTSC";
end;

local function part3()
	return SSC and "SSC" or "SM4";
end;

themeInfo = {
	ProductCode = "NKT-NCRX-"..part3(),
	Name = "NAKET Coder Revolution X",
	Version = "v4.23.26 ".. part2(),
	Date = "20100320",
};