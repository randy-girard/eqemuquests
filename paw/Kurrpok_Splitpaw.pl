sub EVENT_SPAWN {
	quest::addloot(13985);
	my $random = int(rand 20);
	if($random == 19) {
		quest::addloot(5317);
	}
	if($random == 10) {
		quest::addloot(7323);
	}
	if($random < 4) {
		my $random2 = int(rand 3);
		if($random2 == 0) {
			quest::addloot(2305);
		}
		elsif($random2 == 1) {
			quest::addloot(2306);
		}
		elsif($random2 == 2) {
			quest::addloot(2307);
		}
	}
}

sub EVENT_DEATH_COMPLETE {
	quest::say("Yap...my eye...*whine*...");
	quest::spawn2(18225, 31, 0, 30, 479, 3.5, 224);
}
