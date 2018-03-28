function hex2rgb(hex)
	-- We're taking everything as a string
    hex = string.gsub(hex, "#","")
    -- then we convert them into numbers, by also representing the values as numbers rather than
    -- hex values.
    return tonumber( string.sub(hex, 1,2) ), tonumber( string.sub(hex, 3,4) ), tonumber( string.sub(hex, 5,6) ), 1
end

function DiffuseHSV(name)
	return name[index+1][1],name[index+1][2],name[index+1][3],name[index+1][4]
end

function ParticleCommandInit(self)
		self:blend('add');
		self:diffusealpha(0.25);
		self:queuecommand('Reset');
	end
	function ParticleCommandOn(self)
		self:spin();
		self:effectperiod(spinPeriod);
		self:effectmagnitude(0,0,90);
		self:queuecommand('Float');
	end
	function ParticleReset(self)
		local randX = math.random(SCREEN_WIDTH*0.05,SCREEN_WIDTH*0.95);
		local randZoom = math.random(0.25,1);
		self:x(randX);
		self:y(SCREEN_BOTTOM + math.random(32,128));
		self:zoom(randZoom);
	end
	function ParticleFloat(self)
		self:linear(0.5*pWeight);
		self:y(-(SCREEN_HEIGHT*0.75));
		self:sleep(math.random(1,3));
		self:playcommand('Reset');
		self:queuecommand('Float');
	end