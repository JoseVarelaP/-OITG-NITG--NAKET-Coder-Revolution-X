local bgColors = {
	Primary   = HSVA(160, 1.0, 0.75, 0.4), -- was 44,1,0.75,0.4
	Secondary = HSVA(176, 0.8, 0.65, 0.4), -- was 52,0.8,0.65,0.4
};

local t = Def.ActorFrame{
	Name="Background";
	InitCommand=cmd(fov,95);

	LoadActor("_bg base")..{ InitCommand=cmd(Center); };
	LoadActor("_bg blur")..{ InitCommand=cmd(Center;diffusealpha,0.6); };
	LoadActor("_bg over1")..{ InitCommand=cmd(Center;diffusealpha,0.35); };
	LoadActor("_bg whiteglow")..{ InitCommand=cmd(Center;diffusealpha,0.5;diffuseshift;effectcolor1,color("1,1,1,1");effectcolor1,color("1,1,1,0.25");effectperiod,30); };
	-- xxx: this one needs overlay in order to function properly...
	LoadActor("_bg over2")..{ InitCommand=cmd(Center;diffusealpha,0.25;diffuseshift;effectcolor1,color("1,1,1,1");effectcolor1,color("1,1,1,0.25");effectperiod,45); };
	LoadActor("_bg over1")..{ InitCommand=cmd(Center;zoom,1.5;diffusealpha,0.45;bob;effectmagnitude,-64,64,0;effectperiod,15;); };
	LoadActor("_bg over2")..{ InitCommand=cmd(Center;zoom,1.25;diffusealpha,0.325;bob;effectmagnitude,0,-24,0;effectperiod,20;effectoffset,0.25); };
	LoadActor("_nexus")..{
		InitCommand=cmd(x,SCREEN_CENTER_X*0.175;y,SCREEN_CENTER_Y;diffusealpha,0.075;blend,'BlendMode_Add';faderight,0.75;rotationy,20);
		OnCommand=cmd(spin;effectperiod,60;effectmagnitude,0,0,15);
	};
	Def.Quad{
		InitCommand=cmd(Center;FullScreen;diffuse,bgColors.Primary;blend,'BlendMode_WeightedMultiply';);
		OnCommand=cmd(diffuseshift;effectperiod,60;effectcolor1,bgColors.Primary;effectcolor2,bgColors.Secondary);
	};
	LoadActor("_diag")..{
		InitCommand=cmd(Center;diffusealpha,0.175;blend,'BlendMode_Add';rotationx,-7;scaletocover,SCREEN_LEFT-(SCREEN_CENTER_X*0.125),SCREEN_TOP,SCREEN_RIGHT+(SCREEN_CENTER_X*0.125),SCREEN_BOTTOM);
		OnCommand=cmd(glowshift;effectcolor1,color("1,1,1,0.125");effectcolor2,color("1,1,1,0.0875");effectperiod,8.25;);
	};
};

local numParticles = 35; -- was 50
local particleGfx = {
	"_a", "_b", "_c", "_d", "_e", "_f", "_g", "_h",
};
local pFrame = Def.ActorFrame{
	InitCommand=cmd(vertalign,bottom;xy,SCREEN_LEFT,SCREEN_CENTER_Y;);
};

for i=1,numParticles do
	local rando = math.random(#particleGfx);
	local pWeight = math.random(4,10);
	local spinPeriod = math.random(6,15);
	pFrame[#pFrame+1] = LoadActor("_particles/"..particleGfx[rando])..{
		InitCommand=cmd(blend,Blend.Add;diffusealpha,0.25;queuecommand,"Reset");
		OnCommand=cmd(spin;effectperiod,spinPeriod;effectmagnitude,0,0,90;queuecommand,"Float";);
		ResetCommand=function(self)
			local randX = math.random(SCREEN_WIDTH*0.05,SCREEN_WIDTH*0.95);
			local randZoom = math.random(0.25,1);
			self:x(randX);
			self:y(SCREEN_BOTTOM + math.random(32,128));
			self:zoom(randZoom);
		end;
		FloatCommand=function(self)
			self:linear(0.5*pWeight);
			self:y(-(SCREEN_HEIGHT*0.75));
			self:sleep(math.random(1,3));
			self:playcommand("Reset");
			self:queuecommand("Float");
		end;
	};
end;
t[#t+1] = pFrame;

local wipeTime = 0.125;
local l2rWipes = 3; -- number of left to right wipes
local r2lWipes = 3; -- number of right to left wipes

local wipeFrame = Def.ActorFrame{
	LoadActor("_wipes/_down2up 1")..{
		InitCommand=cmd(Center;croptop,1;blend,'BlendMode_Add');
		OnCommand=function(self)
			if math.random(512) == 276 then
				self:queuecommand("Go");
			end;
		end;
		GoCommand=cmd(linear,wipeTime;croptop,0.8;linear,wipeTime;croptop,0.6;cropbottom,0.2;linear,wipeTime;croptop,0.4;cropbottom,0.4;linear,wipeTime;croptop,0.2;cropbottom,0.6;linear,wipeTime;croptop,0;cropbottom,0.8;linear,wipeTime;cropbottom,1;);
	};
	LoadActor("_wipes/_left2right "..math.random(1,l2rWipes))..{
		InitCommand=cmd(Center;cropright,1;blend,'BlendMode_Add');
		OnCommand=function(self)
			if math.random(512) == 104 then
				self:queuecommand("Go");
			end;
		end;
		GoCommand=cmd(linear,wipeTime;cropright,0.8;linear,wipeTime;cropright,0.6;cropleft,0.2;linear,wipeTime;cropright,0.4;cropleft,0.4;linear,wipeTime;cropright,0.2;cropleft,0.6;linear,wipeTime;cropright,0;cropleft,0.8;linear,wipeTime;cropleft,1;);
	};
	LoadActor("_wipes/_right2left "..math.random(1,r2lWipes))..{
		InitCommand=cmd(Center;cropleft,1;blend,'BlendMode_Add');
		OnCommand=function(self)
			if math.random(512) == 73 then
				self:queuecommand("Go");
			end;
		end;
		GoCommand=cmd(linear,wipeTime;cropleft,0.8;linear,wipeTime;cropleft,0.6;cropright,0.2;linear,wipeTime;cropleft,0.4;cropright,0.4;linear,wipeTime;cropleft,0.2;cropright,0.6;linear,wipeTime;cropleft,0;cropright,0.8;linear,wipeTime;cropright,1;);
	};
};

t[#t+1] = wipeFrame;

return t;