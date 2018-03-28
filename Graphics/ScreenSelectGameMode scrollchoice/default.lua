local cIndex = Var("GameCommand"):GetIndex();
local cName = Var("GameCommand"):GetText();
local cTitle = THEME:GetString( Var "LoadingScreen", cName .. "Title" );

local tweenTimeBetweenItems = 0.0725;

local previewBaseSize = { x = 120, y = 108 };
local previewYOffset = -76; -- was -78

--[[ normal ]]
local NormalPreview = Def.ActorFrame{
	InitCommand=cmd(y,previewYOffset;fov,90);
	LoadActor( THEME:GetPathG("_shared","elements/RoundedCornerBox"), previewBaseSize.x, previewBaseSize.y, color("0.6,0.6,0.6,1") )..{
		Name="NormalPreviewBase";
		GainFocusCommand=cmd(stoptweening;accelerate,tweenTimeBetweenItems;diffusealpha,1);
		LoseFocusCommand=cmd(stoptweening;accelerate,tweenTimeBetweenItems;diffusealpha,0.5);
	};
	LoadActor("_preview shading")..{InitCommand=cmd(zoomy,1.1;y,-0.1);};
	LoadActor("_preview grid")..{InitCommand=cmd(blend,Blend.Add;diffusealpha,0.2;fadetop,0.5;fadebottom,0.5);};
	-- actorframe hacks
	Def.ActorFrame{
		GainFocusCommand=cmd(stoptweening;spin;effectmagnitude,0,-15,-15);
		LoseFocusCommand=cmd(stopeffect;stoptweening;accelerate,tweenTimeBetweenItems;rotationy,0;rotationz,0);
		OffFocusedCommand=cmd(playcommandonleaves,"Fade");
		FadeCommand=cmd(sleep,0.6;linear,0.375;diffusealpha,0);

		LoadActor("_normal arrow")..{
			InitCommand=cmd(x,-16;y,4;z,3;diffuse,HSVA(0,1,0.8,0.75););
			GainFocusCommand=cmd(stoptweening;accelerate,tweenTimeBetweenItems;zoom,1;pulse;effectmagnitude,0.5,0.75,1);
			LoseFocusCommand=cmd(stopeffect;stoptweening;accelerate,tweenTimeBetweenItems;zoom,0.5;);
		};
		LoadActor("_normal arrow")..{
			InitCommand=cmd(y,-16;z,3;diffuse,HSVA(128,1,0.8,0.75););
			GainFocusCommand=cmd(stoptweening;accelerate,tweenTimeBetweenItems;zoom,1;pulse;effectmagnitude,0.6,0.8,1;effectoffset,1);
			LoseFocusCommand=cmd(stopeffect;stoptweening;accelerate,tweenTimeBetweenItems;zoom,0.6;);
		};
		LoadActor("_normal arrow")..{
			InitCommand=cmd(x,16;y,4;z,3;diffuse,HSVA(192,1,0.8,0.75););
			GainFocusCommand=cmd(stoptweening;accelerate,tweenTimeBetweenItems;zoom,1;pulse;effectmagnitude,0.7,0.9,1;effectoffset,2);
			LoseFocusCommand=cmd(stopeffect;stoptweening;accelerate,tweenTimeBetweenItems;zoom,0.7;);
		};
		LoadActor("_normal arrow")..{
			InitCommand=cmd(z,0;blend,Blend.Add);
			GainFocusCommand=cmd(stoptweening;diffusealpha,1;diffuseshift;effecttiming,1.25,1,4,2;effectcolor1,HSVA(0,0,0.65,1);effectcolor2,HSVA(0,0,1,0.625););
			LoseFocusCommand=cmd(stopeffect;stoptweening;accelerate,tweenTimeBetweenItems;zoom,1;diffusealpha,0.625);
		};
	};

	Def.Actor{
		Name="SneakyFooterThing";
		OffFocusedCommand=function(self) MESSAGEMAN:Broadcast("ToSelectMusic"); end;
	};
};

--[[ extra ]]
local ExtraPreview = Def.ActorFrame{
	InitCommand=cmd(y,previewYOffset;fov,90);
	LoadActor( THEME:GetPathG("_shared","elements/RoundedCornerBox"), previewBaseSize.x, previewBaseSize.y, color("0.125,0.45,0.6,1") )..{
		Name="ExtraPreviewBase";
		GainFocusCommand=cmd(stoptweening;accelerate,tweenTimeBetweenItems;diffusealpha,1);
		LoseFocusCommand=cmd(stoptweening;accelerate,tweenTimeBetweenItems;diffusealpha,0.5);
	};
	LoadActor("_preview shading")..{InitCommand=cmd(zoomy,1.1;y,-0.1);};
	LoadActor("_preview grid")..{InitCommand=cmd(blend,Blend.Add;diffusealpha,0.2;fadetop,0.5;fadebottom,0.5);};
	Def.ActorFrame{
		OnCommand=cmd(spin;effectmagnitude,0,0,15);
		OffFocusedCommand=cmd(playcommandonleaves,"Fade");
		FadeCommand=cmd(sleep,0.6;linear,0.375;diffusealpha,0);
		GainFocusCommand=cmd(effectmagnitude,0,0,45);
		LoseFocusCommand=cmd(effectmagnitude,0,0,15);

		LoadActor("_normal arrow")..{
			Name="Top";
			InitCommand=cmd(y,32;diffusealpha,0.75);
			GainFocusCommand=cmd(stoptweening;accelerate,tweenTimeBetweenItems;zoom,0.8;addy,12);
			LoseFocusCommand=cmd(stopeffect;stoptweening;accelerate,tweenTimeBetweenItems;zoom,0.6;addy,-12);
		};
		LoadActor("_normal arrow")..{
			Name="Bottom";
			InitCommand=cmd(y,-32;rotationz,180;diffusealpha,0.75);
			GainFocusCommand=cmd(stoptweening;accelerate,tweenTimeBetweenItems;zoom,0.8;addy,-12);
			LoseFocusCommand=cmd(stopeffect;stoptweening;accelerate,tweenTimeBetweenItems;zoom,0.6;addy,12);
		};
		LoadActor("_normal arrow")..{
			Name="Left";
			InitCommand=cmd(x,32;rotationz,-90;diffusealpha,0.75);
			GainFocusCommand=cmd(stoptweening;accelerate,tweenTimeBetweenItems;zoom,0.8;addx,12);
			LoseFocusCommand=cmd(stopeffect;stoptweening;accelerate,tweenTimeBetweenItems;zoom,0.6;addx,-12);
		};
		LoadActor("_normal arrow")..{
			Name="Right";
			InitCommand=cmd(x,-32;rotationz,90;diffusealpha,0.75);
			GainFocusCommand=cmd(stoptweening;accelerate,tweenTimeBetweenItems;zoom,0.8;addx,-12);
			LoseFocusCommand=cmd(stopeffect;stoptweening;accelerate,tweenTimeBetweenItems;zoom,0.6;addx,12);
		};
	};
};

--[[ online ]]
local OnlinePreview = Def.ActorFrame{
	InitCommand=cmd(y,previewYOffset;fov,90);
	LoadActor( THEME:GetPathG("_shared","elements/RoundedCornerBox"), previewBaseSize.x, previewBaseSize.y, color("0.6,0.6,0.6,1") )..{
		Name="OnlinePreviewBase";
		GainFocusCommand=cmd(stoptweening;accelerate,tweenTimeBetweenItems;diffusealpha,1);
		LoseFocusCommand=cmd(stoptweening;accelerate,tweenTimeBetweenItems;diffusealpha,0.5);
	};
};

--[[ under construction ]]
local ConstructionPreview = Def.ActorFrame{
	InitCommand=cmd(y,previewYOffset;fov,90);
	LoadActor( THEME:GetPathG("_shared","elements/RoundedCornerBox"), previewBaseSize.x, previewBaseSize.y, color("0.6,0.48,0.06,1") )..{
		Name="ConstructionPreviewBase";
		GainFocusCommand=cmd(stoptweening;accelerate,tweenTimeBetweenItems;diffusealpha,1);
		LoseFocusCommand=cmd(stoptweening;accelerate,tweenTimeBetweenItems;diffusealpha,0.5);
	};
	LoadActor("_preview shading")..{InitCommand=cmd(zoomy,1.1;y,-0.1);};
	LoadActor("_preview grid")..{InitCommand=cmd(blend,Blend.Add;diffusealpha,0.2;fadetop,0.5;fadebottom,0.5);};
	Def.ActorFrame{
		Name="TopBottomCautionStripe";
		InitCommand=cmd(y,-32;);
		Def.Quad{
			Name="YellowBase";
			InitCommand=cmd(zoomto,120,15;diffuse,HSVA(48,1,1,0.5));
			GainFocusCommand=cmd(accelerate,tweenTimeBetweenItems;diffuse,HSVA(48,1,1,0.9));
			LoseFocusCommand=cmd(stoptweening;accelerate,tweenTimeBetweenItems;diffuse,HSVA(48,1,1,0.5));
		};
		LoadActor("_construction stripe")..{
			InitCommand=cmd(zoomx,1.875;customtexturerect,0,0,2,1);
			GainFocusCommand=cmd(texcoordvelocity,0.2,0);
			LoseFocusCommand=cmd(stoptweening;texcoordvelocity,0,0);
		};
	};
	Def.ActorFrame{
		Name="BottomCautionStripe";
		InitCommand=cmd(y,32;);
		Def.Quad{
			Name="YellowBase";
			InitCommand=cmd(zoomto,120,15;diffuse,HSVA(48,1,1,0.5));
			GainFocusCommand=cmd(accelerate,tweenTimeBetweenItems;diffuse,HSVA(48,1,1,0.9));
			LoseFocusCommand=cmd(stoptweening;accelerate,tweenTimeBetweenItems;diffuse,HSVA(48,1,1,0.5));
		};
		LoadActor("_construction stripe")..{
			InitCommand=cmd(zoomx,1.875;customtexturerect,0,0,2,1);
			GainFocusCommand=cmd(texcoordvelocity,-0.2,0);
			LoseFocusCommand=cmd(stoptweening;texcoordvelocity,0,0);
		};
	};
	LoadActor("_preview msgline")..{
		InitCommand=cmd(y,8;);
	};
	LoadActor("_construction shadow")..{
		InitCommand=cmd(y,-8;blend,Blend.Add;diffusealpha,0.375);
		GainFocusCommand=cmd(stoptweening;pulse;effectmagnitude,0.8,0.975,1;);
		LoseFocusCommand=cmd(stoptweening;stopeffect;accelerate,0.1;zoom,1);
	};
	LoadActor("_construction main")..{
		InitCommand=cmd(y,-8;);
	};
};

--[[ disabled ]]
local DisabledPreview = Def.ActorFrame{
	InitCommand=cmd(y,previewYOffset;fov,90);
	LoadActor( THEME:GetPathG("_shared","elements/RoundedCornerBox"), previewBaseSize.x, previewBaseSize.y, color("0.6,0.3,0.3,1") )..{
		Name="DisabledPreviewBase";
		GainFocusCommand=cmd(stoptweening;accelerate,tweenTimeBetweenItems;diffusealpha,1);
		LoseFocusCommand=cmd(stoptweening;accelerate,tweenTimeBetweenItems;diffusealpha,0.5);
	};
	LoadActor("_preview shading")..{InitCommand=cmd(zoomy,1.1;y,-0.1);};
	LoadActor("_preview grid")..{InitCommand=cmd(blend,Blend.Add;diffusealpha,0.2;fadetop,0.5;fadebottom,0.5);};
	LoadActor("_preview msgline")..{
		InitCommand=cmd(y,8;);
	};
	LoadActor("_disabled shadow")..{
		InitCommand=cmd(y,-4;blend,Blend.Add;diffusealpha,0.375);
		GainFocusCommand=cmd(stoptweening;pulse;effectmagnitude,0.8,0.975,1;);
		LoseFocusCommand=cmd(stoptweening;stopeffect;accelerate,0.1;zoom,1);
	};
	LoadActor("_disabled main")..{
		InitCommand=cmd(y,-4;);
	};
};

local previews = {
	Normal = NormalPreview,
	Extra  = ExtraPreview,
	Online = ConstructionPreview,
	--Online = OnlinePreview,
};

local t = Def.ActorFrame{
	LoadActor("_base")..{
		GainFocusCommand=cmd(stoptweening;accelerate,tweenTimeBetweenItems;diffuse,color("1,1,1,1"));
		LoseFocusCommand=cmd(stoptweening;accelerate,tweenTimeBetweenItems;diffuse,color("0.5,0.5,0.5,0.75"));
	};
	Def.ActorFrame{
		Name="ExplainFrame";
		InitCommand=cmd(y,60);

		LoadActor( THEME:GetPathG("_shared","elements/RoundedCornerBox"), 124, 128, color("0.43,0.43,0.43,1") )..{
			Name="ExplainBase";
		};
		-- todo: separate the noise out into a scrollable texture and use a mask
		LoadActor("_explain active")..{
			GainFocusCommand=cmd(stoptweening;accelerate,tweenTimeBetweenItems;diffusealpha,1);
			LoseFocusCommand=cmd(stoptweening;accelerate,tweenTimeBetweenItems;diffusealpha,0);
		};
	};
	LoadActor("_text "..cName)..{
		InitCommand=cmd(y,56);
		GainFocusCommand=cmd(stoptweening;accelerate,tweenTimeBetweenItems;diffusealpha,1);
		LoseFocusCommand=cmd(stoptweening;accelerate,tweenTimeBetweenItems;diffusealpha,0.5);
	};
};

t[#t+1] = previews[cName]; 

return t;

--[[
local previewsOld = {
	Normal = "normal",
	Online = "construction",
	Extra  = "disabled",
};
LoadActor("_preview "..previewsOld[cName])..{
	InitCommand=cmd(y,-78);
	GainFocusCommand=cmd(stoptweening;accelerate,tweenTimeBetweenItems;diffusealpha,1);
	LoseFocusCommand=cmd(stoptweening;accelerate,tweenTimeBetweenItems;diffusealpha,0.5);
};
--]]