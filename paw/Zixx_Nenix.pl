sub EVENT_SPAWN {
	quest::shout("Well done, lowling. Now hand over the eye or I shall clothe my charming daughter with your skin!");
	quest::settimer("depop", 600);
}

sub EVENT_TIMER {
	if ($timer = "depop") {
		quest::depop(18225);
	}
}

sub EVENT_AGGRO {
	quest::say("I grow impatient...");
}

sub EVENT_SAY {
	if ($text =~ /hail/i) {
		quest::say("Produce the eye at once!");
	}
}

sub EVENT_ITEM {
	if ($item = 13985) {
		quest::say("Very good, lowling. You have chosen the reasonable path of submission and cooperation. Now begone.");
		quest::exp(115000);
		quest::ding();
		quest::depop(18225);
	}
}
