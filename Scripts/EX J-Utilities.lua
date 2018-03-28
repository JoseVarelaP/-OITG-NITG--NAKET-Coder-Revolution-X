function FullScreen(self)
	self:zoomto(SCREEN_WIDTH+3,SCREEN_HEIGHT)
	Center(self)
end

function Center(self)
	-- This is self-explanatory.
	-- This is to "recreate" the Center() command that exists in SM5.
	self:x(SCREEN_CENTER_X)
	self:y(SCREEN_CENTER_Y)
end

function scale_or_crop_background(self)
	if self:GetWidth() == 640 and self:GetHeight() == 480 then
		self:stretchto( 0,0,SCREEN_WIDTH,SCREEN_HEIGHT );
	else
		self:scaletocover( 0,0,SCREEN_WIDTH,SCREEN_HEIGHT );
	end
end

function ThemeFile( file ) return THEME:GetPath( EC_GRAPHICS, '' , file ) end

function ColCon(n1, n2, n3)
	return (n1/255),(n2/255),(n3/255),1
end

-- I don't think this works right:
--function WideScale(AR4_3, AR16_10) return scale( SCREEN_WIDTH, 640, 960, AR4_3, AR16_10 ); end
function WideScale(AR4_3, AR16_10) return scale( SCREEN_WIDTH, 640, 768, AR4_3, AR16_10 ); end
--function WideScale(AR4_3, AR16_9) return scale( SCREEN_WIDTH, 640, 854, AR4_3, AR16_9 ); end

TitleMenu_OptionColors = {
	HSVA(128, 0.6, 0.325, 0.8),	-- play
	HSVA(192, 0.6, 0.325, 0.8),	-- options
	HSVA( 64, 0.6, 0.325, 0.8),	-- edit
	HSVA(  0, 0.6, 0.325, 0.8),	-- exit
};

TitleMenu_OptionColorsFocused = {
	HSVA(128,0.6,0.85,1),	-- play
	HSVA(192,0.6,0.85,1),	-- options
	HSVA(64,0.6,0.85,1),	-- edit
	HSVA(0,0.6,0.85,1),	-- exit
};

OptionColors = {
	HSVA(128, 0.6, 0.275, 0.53125),	-- play
	HSVA(192, 0.6, 0.275, 0.53125),	-- options
	HSVA( 64, 0.6, 0.275, 0.53125),	-- edit
	HSVA(  0, 0.6, 0.275, 0.53125),	-- exit
	-------------------------------------
	hex2rgb('#44220088'), -- Start Game [O]
	hex2rgb('#00440088'), -- Options    [G]
	hex2rgb('#00004488'), -- Edit       [B]
	hex2rgb('#44000088'), -- Exit       [R]
	-------------------------------------
	hex2rgb('#44440088'), -- Gametypes  [Y]
	hex2rgb('#44004488'), -- Jukebox    [V]
};

OptionColorsFocused = {
	HSVA(128, 1, 0.45, 0.8),	-- play
	HSVA(192, 1, 0.45, 0.8),	-- options
	HSVA( 64, 1, 0.45, 0.8),	-- edit
	HSVA(  0, 1, 0.45, 0.8),	-- exit
	-------------------------------------
	hex2rgb('#663300CC'), -- Start Game [O]
	hex2rgb('#006600CC'), -- Options    [G]
	hex2rgb('#000066CC'), -- Edit       [B]
	hex2rgb('#660000CC'), -- Exit       [R]
	-------------------------------------
	hex2rgb('#666600CC'), -- Gametypes  [Y]
	hex2rgb('#660066CC'), -- Jukebox    [V]
};

OptionColorsBright = {
	HSVA(128,0.6,0.85,1),	-- play
	HSVA(192,0.6,0.85,1),	-- options
	HSVA(64,0.6,0.85,1),	-- edit
	HSVA(0,0.6,0.85,1),	-- exit
	-------------------------------------
	hex2rgb('#AA5500FF'), -- Start Game [O]
	hex2rgb('#00AA00FF'), -- Options    [G]
	hex2rgb('#0000AAFF'), -- Edit       [B]
	hex2rgb('#AA0000FF'), -- Exit       [R]
	-------------------------------------
	hex2rgb('#AAAA00FF'), -- Gametypes  [Y]
	hex2rgb('#AA00AAFF'), -- Jukebox    [V]
};

--[[ song length colors ]]
-- todo: perfect them
SongLengthColors = {
	Normal   = hex2rgb("#FFFFFF"),
	Long     = hex2rgb("#00DD00"),
	Marathon = hex2rgb("#FF8800"),
};