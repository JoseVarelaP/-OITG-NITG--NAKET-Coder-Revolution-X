local cIndex = Var("GameCommand"):GetIndex();
local cName = Var("GameCommand"):GetText();
local cTitle = THEME:GetString( Var "LoadingScreen", cName .. "Title" );

--[[
design idea:
same tilted rounded rectangle for the DifficultyList
endcaps showing color based on mode
cool little things that scroll when focused
faint noise in the BG of main for lose focus
]]

local ModeColors = {
	color("0,0.8,1,1"), -- Normal  (Blue)
	--color("1,0,0,1"), -- Workout (Red)
	color("0,0.8,0,1")  -- Online  (Green)
};

local t = Def.ActorFrame{
	LoadActor("_base")..{
		GainFocusCommand=function(self)
			-- the bad part about sm4 theming is that sometimes you need long
			-- form commands to get something done.
			local thisColor = ModeColors[cIndex+1];
			(cmd(stoptweening;linear,0.5;diffuse,color("#FFFFFFFF")))(self);

			self:diffuseshift();
			self:effectperiod(4);
			self:effectcolor1( color("#FFFFFFFF") );

			local colorHSV = ColorToHSV(thisColor);
			colorHSV.Sat = 0.1;

			self:effectcolor2( HSVToColor(colorHSV) );
		end;
		LoseFocusCommand=cmd(stoptweening;stopeffect;diffuse,color("#CCCCCCFF"));
	};

	LoadActor( "_"..string.lower(cTitle) )..{
		InitCommand=cmd(y,18;zoomx,1.2);
		OnCommand=cmd(texcoordvelocity,-0.2,0;customtexturerect,0,0,1.2,1;diffuseshift;effectperiod,2;effectcolor1,color("1,1,1,0.5");effectcolor2,color("1,1,1,0.85"));
		GainFocusCommand=cmd(stoptweening;linear,0.2;diffusealpha,1);
		LoseFocusCommand=cmd(stoptweening;linear,0.2;diffusealpha,0);
	};

	-- endcap
	Def.Sprite{
		GainFocusCommand=function(self)
			self:finishtweening();
			self:Load( THEME:GetPathG("ScreenSelectGameMode icon", "choice/_endcap on" ) );

			self:spring(0.1);
			self:diffuse( ModeColors[cIndex+1] );
			self:zoom(1.25);
			self:x(24);
		end;
		LoseFocusCommand=function(self)
			self:finishtweening();
			self:Load( THEME:GetPathG("ScreenSelectGameMode icon", "choice/_endcap off" ) );

			self:spring(0.1);
			self:diffuse( color("1,1,1,1") );
			self:zoom(1.0);
			self:x(0);
		end;
	};

	Font("scooter", "32px metal")..{
		Text=cTitle;
		InitCommand=cmd(shadowlength,0);
		DisabledCommand=cmd(diffuse,color("#888888"));
		LoseFocusCommand=cmd(stoptweening;stopeffect);
		GainFocusCommand=cmd(stoptweening;diffuseshift;effectperiod,1;effectcolor1,1,1,1,1;effectcolor2,ModeColors[cIndex+1]);
		OffFocusedCommand=cmd(stoptweening;linear,0.5;diffuse,color("1,0.95,0.75,1"));
	};

	Def.Actor{
		GainFocusCommand=function(self)
			MESSAGEMAN:Broadcast("SelectGameModeChanged",{ Name = cTitle });
		end;
	};
};

return t;