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

function ColCon(n1, n2, n3)
	return (n1/255),(n2/255),(n3/255),1
end

-- I don't think this works right:
--function WideScale(AR4_3, AR16_10) return scale( SCREEN_WIDTH, 640, 960, AR4_3, AR16_10 ); end
function WideScale(AR4_3, AR16_10) return scale( SCREEN_WIDTH, 640, 768, AR4_3, AR16_10 ); end
--function WideScale(AR4_3, AR16_9) return scale( SCREEN_WIDTH, 640, 854, AR4_3, AR16_9 ); end