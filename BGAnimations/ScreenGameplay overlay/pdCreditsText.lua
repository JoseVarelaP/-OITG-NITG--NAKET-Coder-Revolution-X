local text = ...;
assert(text);

local c;

-- based off of rise_of_the_dopefish.cs which in turn is based off of
-- code from the GPL'd release of Rise of the Triad.

-- main constants
local FINEANGLES = 4096; -- original 2048
local FINEANGLEQUAD = (FINEANGLES/4);
local NUMSINANGLES = FINEANGLES + FINEANGLEQUAD+1;
local PI = 3.141592657;

local height;
local angle = 0;
local anglestep = (PI/2/FINEANGLEQUAD);

local speed = 24;
local choke = 56;

local ret = Def.ActorFrame{
	BeginCommand=function(self) c = self:GetChildren(); end;

	Font("handelgothic", "20px")..{
		Name="Text_Minus2";
		Text=text;
		InitCommand=cmd(shadowlength,0;playcommand,"Position";diffusealpha,0.625;diffusecolor,HSV(176,40/100,1);zoom,1.5);
		PositionCommand=cmd(x,2;y,2;z,-3);
	};

	Font("handelgothic", "20px")..{
		Name="Text_Minus1";
		Text=text;
		InitCommand=cmd(shadowlength,0;playcommand,"Position";diffusealpha,0.75;diffusecolor,HSV(144,34/100,1);zoom,1.1);
		PositionCommand=cmd(z,-1);
	};

	Font("handelgothic", "20px")..{
		Name="TextMain";
		Text=text;
		InitCommand=cmd(shadowlength,0);
		PauseStatusChangedMessageCommand=function(self,params)
			self:diffuse( PlayerColor(params.PlayerNumber) );
		end;
	};
};

function PDUpdate(self)
	angle = angle + anglestep;

	local newX = ( math.cos(angle * speed) * ((SCREEN_CENTER_X/choke)*0.5) );
	local newY = ( math.sin(angle * speed) * ((SCREEN_CENTER_Y/choke)*0.5) );

	c.Text_Minus1:x( newX );
	c.Text_Minus1:y( newY );

	c.Text_Minus2:x( newX );
	c.Text_Minus2:y( newY );
end;

ret.InitCommand=cmd(fov,45;SetUpdateRate,60;SetUpdateFunction,PDUpdate);

return ret;