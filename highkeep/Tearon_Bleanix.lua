function event_combat(e)
	if (e.joined) then
		e.self:Say("The single death of a member of the Paladins of Tunare shall plague your wretched life.");
	end
end

function event_slay(e)
	e.self:Say("Let no evil beings stand in the way of the righteousness of the Paladins of Tunare!");
end


function event_say(e)
	local fac = e.other:GetFaction(e.self);

	if(eq.is_content_flag_enabled("october_1999_temple_era")) then
		if(e.message:findi("hail")) then
			e.self:Say("Beware!!..  Beware, the Teir'Dal walk the halls of Highkeep!!");
		elseif(e.message:findi("princess lenya thex")) then
			e.self:Say("The Princess Lenya Thex is the daughter of His Royal Majesty, King Tearis Thex of Felwithe. She was on her way to Qeynos when we believe she was kidnapped by Carson McCabe, the governor of this vile city. I await the paladin from Felwithe.");
		elseif(e.message:findi("all is not bright above the clouds")) then
			if(fac < 4) then
				e.self:Say("Taken from this place she has been.  Seek the Highpass hussy.  Ask of her.  Only she knows where.  Find the Princess.  Give her this.  Show your allegiance.  This and her key. Then return the room key to me with the prize from the princess.  Become a hero!!");
				e.other:Ding();
				e.other:SummonItem(13108); -- Item: Tearon's Bracer
			else
				e.self:Say("When you have furthered your service to the Paladins of Tunare, we shall make conversation.");
			end
		end
	else
		local Princess_Lenya_Thex = 51176;

		if (e.message:findi("hail")) then
			e.self:Say("Hello sir. Are you a citizen of Highpass?");
		elseif (e.message:findi("not a citizen")) then
			e.self:Say("Nor am I. I find this cities love of greed appalling. Do not you?");
		elseif (e.message:findi("appalling")) then
			e.self:Say("Yes. This city of vices is second only to Neriak. And it is trouble with Neriak that has sent me here. In search of my peoples princess.");
		elseif (e.message:findi("princess")) then
			e.self:Say("The Princess Lenya Thex is the daughter of His Royal Majesty, King Tearis Thex of Felwithe. She was on her way to Qeynos when we believe she was kidnapped by Carson McCabe, the governor of this vile city. I cannot get in the guards are on to me. How do you feel about becoming a hero to the Koada'dal or as you call us, high elves.");
		elseif (e.message:findi("want to be a hero") or e.message:findi("become a hero")) then
			-- :: Match if faction is Amiable or better
			if (fac <= 4) then
				e.self:Say("Well let's get started on making you a hero. You must take Elite Guard Bracer. Look for Princess Lenya. When you find her give her the bracer to prove you are with the Koada'dal. She should trust you then. Then return to me with Princess Lenya and return my bracer. Be safe my friend.");
				-- :: Give item 13108 - Tearons Bracer
				e.other:SummonItem(13108);

				-- :: Spawn one and only one Princess_Lenya_Thex (51176)
				eq.spawn2(Princess_Lenya_Thex, 0, 0, -202, 85, 74, 400);
			else
				e.self:Say("When you have furthered your service to the Paladins of Tunare, we shall make conversation.");
			end
		end
	end
end

function event_timer(e)
	-- :: Match a timer 'depop'
	if (e.timer == "depop") then
		-- :: Stop the timer 'depop' from triggering
		eq.stop_timer("depop");
		-- :: Depop with spawn timer active
		eq.depop_with_timer();
	end
end

function event_trade(e)
	local item_lib = require("items");
	local fac = e.other:GetFaction(e.self);
	local Princess_Lenya_Thex = 51176;

	if(eq.is_content_flag_enabled("october_1999_temple_era")) then
		if(item_lib.check_turn_in(e.trade, {item1 = 12267,item2 = 13109})) then
			e.self:Say("Peace..  I can rest now.  You now hold my Silent Watch Shield.  Protect Felwithe..");
			e.other:SummonItem(9312); -- Item: Silent Watch Shield
			e.other:Ding();
			e.other:Faction(5001,10,0); -- Faction: Anti-mage
			e.other:Faction(226,10,0); -- Faction: Clerics of Tunare
			e.other:Faction(279,10,0); -- Faction: King Tearis Thex
			e.other:AddEXP(2000);
			eq.depop_with_timer();
		end
	else
		if(item_lib.check_turn_in(e.trade, {item1 = 13112})) then
			if(fac <= 4) then
				e.self:Say("King Tearis Thex thanks you my friend. Could you please hand the princess this amulet. It is hers. I pryed it from the hands of some beggar.");
				--:: Give a 13109 - Royal Amulet of Thex
				e.other:SummonItem(13109);
				e.other:Ding();
				e.other:Faction(226, 25, 0); -- Faction: Clerics of Tunare
				e.other:Faction(279, 25, 0); -- Faction: King Tearis Thex
				e.other:Faction(5001, 10, 0); -- Faction: Anti-Mage
				e.other:AddEXP(100);
				-- :: Spawn one and only one Princess_Lenya_Thex (51176), without guild war or pathgrid, at the specified location
				eq.spawn2(Princess_Lenya_Thex, 0, 0, 51, 2, 2.5, 501);
			else
				e.self:Say("When you have furthered your service to the Paladins of Tunare, we shall make conversation.");
				-- Give a 13112 - Tearon's Bracer
				e.other:SummonItem(13112);
			end
		end
	end

	item_lib.return_items(e.self, e.other, e.trade)
end
