local t = Def.ActorFrame{
	Def.Quad{
		InitCommand=cmd(FullScreen;Center;diffuse,color("#00000000"));
		TitleMenuOffMessageCommand=function(self,params)
			-- SelectedIndex is zero based.
			self:sleep(1);
			self:decelerate(1);
			self:diffusealpha(1);
		end;
	};
};

return t;