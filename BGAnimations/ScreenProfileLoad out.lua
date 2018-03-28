-- profiles will not be loaded at this point.
local t = Def.ActorFrame{
	Def.Actor{ OnCommand=cmd(sleep,1.5); };
};

for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	t[#t+1] = Font("mentone","24px")..{
		InitCommand=cmd(shadowlength,1;CenterY;diffusealpha,0);
		BeginCommand=function(self)
			self:x( pn == PLAYER_1 and SCREEN_CENTER_X*0.5 or SCREEN_CENTER_X*1.5 );
			self:diffuse(PlayerColor(pn));
			self:settext("Welcome!");
		end;
		OnCommand=cmd(linear,0.75;diffusealpha,1;sleep,0.25;bouncebegin,0.45;addy,SCREEN_WIDTH);
	};
end;

return t;