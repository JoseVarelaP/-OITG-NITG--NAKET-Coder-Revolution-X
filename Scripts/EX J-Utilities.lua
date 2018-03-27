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

function hex2rgb(hex)
	-- We're taking everything as a string
    hex = string.gsub(hex, "#","")
    -- then we convert them into numbers, by also representing the values as numbers rather than
    -- hex values.
    return tonumber( string.sub(hex, 1,2) ), tonumber( string.sub(hex, 3,4) ), tonumber( string.sub(hex, 5,6) ), 1
end