--[[
NAKET Coder's song position meter, accounting for sm-ssc
--]]
local c;

local fFrameWidth = 512;
local fFrameHeight = 14;

local t = Def.ActorFrame{
	BeginCommand=function(self) c = self:GetChildren(); end;
};
t[#t+1] = Def.ActorFrame{
	Name="SongMeter";
	InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_TOP-10;draworder,95);
	OnCommand=cmd(decelerate,0.2;addy,15);
	OffCommand=cmd(accelerate,0.2;addy,-30);

	Def.Quad{
		InitCommand=cmd(zoomto,fFrameWidth+2,fFrameHeight-2;diffuse,color("0,0,0,0.325"));
	};

	Def.SongMeterDisplay {
		Name="SongMeterDisplay";
		StreamWidth=fFrameWidth;

		Stream=Def.Quad {
			InitCommand=cmd(zoomy,6;diffuse,color("#fff22688");diffusebottomedge,color("#ffcc00"));
		};

		Tip=Def.ActorFrame{
			Def.Quad{
				InitCommand=cmd(zoomto,1,6;diffusebottomedge,color("#aaaaaa"));
			};
			Font("mentone","24px")..{
				Name="SongTimer";
				InitCommand=cmd(y,12;zoom,0.5;shadowlength,1;horizalign,right);
				UpdateTimerMessageCommand=function(self)
					local secs, maxSecs;

					if SSC then
						secs = math.max(GAMESTATE:GetCurMusicSeconds(),0);
					else
						-- todo: figure out who's alive instead of risking
						-- "hey this doesn't work" reports when the master
						-- player bombs out for some reason.
						secs = STATSMAN:GetCurStageStats():GetPlayerStageStats(GAMESTATE:GetMasterPlayerNumber()):GetAliveSeconds();
					end;
					local song = GAMESTATE:GetCurrentSong();
					if GAMESTATE:IsCourseMode() then
						local course = GAMESTATE:GetCurrentCourse();
						if course then
							local songEntry = course:GetCourseEntry( GAMESTATE:GetCourseSongIndex() );
							song = songEntry:GetSong()
						end;
					end;
					if song then
						if SSC then
							maxSecs = song:GetStepsSeconds();
						else
							maxSecs = song:MusicLengthSeconds();
						end;
					else
						maxSecs = -1;
					end;
					self:settext( SecondsToMSS(secs) );
				end;
			};
		};
	};
};

local bars = Def.ActorFrame{ };
local bpmFrame = Def.ActorFrame{ Name="BPMFrame"; };
local stopFrame = Def.ActorFrame{ Name="StopFrame"; };
local delayFrame = Def.ActorFrame{ Name="DelayFrame"; };

if SSC then
	local song = GAMESTATE:GetCurrentSong();

	--[[
	if GAMESTATE:IsCourseMode() then
		local course = GAMESTATE:GetCurrentCourse();
		if course then
			local songEntry = course:GetCourseEntry( GAMESTATE:GetCourseSongIndex()+1 );
			if songEntry then
				song = songEntry:GetSong()
			end;
		end;
	end;
	--]]

	if not song then
		return t;
	end;
	local timingData = song:GetTimingData();
	-- ???: if we're using SSC, might as well use the StepsSeconds, which will
	-- almost always be more proper than a r21'd file.
	local songLen = song:MusicLengthSeconds();
	local firstBeatSecs = timingData:GetElapsedTimeFromBeat(song:GetFirstBeat());
	local lastBeatSecs = timingData:GetElapsedTimeFromBeat(song:GetLastBeat());
	local bpms = timingData:GetBPMs();

	local stops = timingData:GetStops();
	for i=1,#stops do
		local data = split("=",stops[i]);
		local beat = data[1];
		local secs = data[2];
		local beatTime = timingData:GetElapsedTimeFromBeat(beat);

		stopFrame[#stopFrame+1] = Def.Quad{
			InitCommand=function(self)
				self:diffuse( HSVA(192,0.4,0.95,0.95) );
				self:shadowlengthy(1);
				self:shadowcolor( color("#FFFFFF") );
				-- set width
				self:zoomto( math.max((secs/songLen)*fFrameWidth,1), fFrameHeight );
				-- find location
				--self:x( scale(beat, song:GetFirstBeat(), song:GetLastBeat(), -fFrameWidth, fFrameWidth) );
				--self:x( scale(beatTime, firstBeatSecs,lastBeatSecs, -fFrameWidth,fFrameWidth) );
				self:x( SCREEN_CENTER_X-(fFrameWidth/2) + scale(beatTime, firstBeatSecs,lastBeatSecs, 0,fFrameWidth) + 1 );
			end;
			OffCommand=cmd(accelerate,0.125;zoomy,0);
		};
	end;

	local delays = timingData:GetDelays();
	for i=1,#delays do
		local data = split("=",delays[i]);
		local beat = data[1];
		local secs = data[2];
		local beatTime = timingData:GetElapsedTimeFromBeat(beat);

		delayFrame[#delayFrame+1] = Def.Quad{
			InitCommand=function(self)
				self:horizalign(left);
				self:diffuse( HSVA(144,0.4,0.95,0.95) );
				self:shadowlengthy(1);
				self:shadowcolor( color("#FFFFFF") );
				-- set width
				self:zoomto( math.max((secs/songLen)*fFrameWidth,1), fFrameHeight );
				-- find location
				self:x( SCREEN_CENTER_X-(fFrameWidth/2) + scale(beatTime, firstBeatSecs,lastBeatSecs, 0,fFrameWidth) + 1 );
			end;
			OffCommand=cmd(accelerate,0.125;zoomy,0);
		};
	end;

	bars[#bars+1] = stopFrame;
	bars[#bars+1] = delayFrame;
	t[#t+1] = bars;
end;

local function UpdateSpecial(self)
	MESSAGEMAN:Broadcast("UpdateTimer");
end;

t.InitCommand=cmd(SetUpdateFunction,UpdateSpecial);

return t;