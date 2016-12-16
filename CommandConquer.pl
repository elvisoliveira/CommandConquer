package CommandConquer;

use Settings;
use Plugins;
use Globals;
use Actor;
use Task;
use Commands;        # Commands::cmdUseSkill
use Log qw(message); # debugger

use utf8;

Plugins::register("CommandConquer", "", \&Unload, \&Reload);

my $hooks = Plugins::addHooks(
	['AI_post', \&default, undef]
);

my $chooks = Commands::register(
	['cc', "Commander interface", \&commandHandler]
);

##### PLUGIN VARIABLES


##### SYSTEM METHODS

sub Unload {
	foreach my $hook (@{$hooks}) {
		Plugins::delHook($hook);
	}
	foreach my $chook (@{$chooks}) {
		Commands::unregister($chook);
	}
	undef @{$hooks};
	undef @{$chooks};
}

sub Reload {
	&Unload;
	&debugger("Reload Successful");
}
	
##### PLUGIN FEATURES

# Add plugin information on screem
sub debugger {
	my $datetime = localtime time;

	# use Data::Dumper;
	# message Dumper($_[0])."\n";
	message "[HAR] $datetime: $_[0].\n";
}

# macro command handler
sub commandHandler {
	### no parameter given
	if (!defined $_[1]) {
		message "usage: c [keep|buff|war]\n", "list";
		return 
	}
	my ($arg, @params) = split(/\s+/, $_[1]);
	
	# Keep em Emperium:
	# 1. http://irowiki.org/classic/Safety_Wall
	#    Find the Emperium position on the map and keep casting "Safety Wall" on it.
	#    Since it cannot be cast on top of an existing "Safety Wall", keep watching untill it is over to cast again.
	# 2. If someone is trying to break the Emperium: 
	#    - http://irowiki.org/classic/Sanctuary
	#      Cast "Sanctuary" on the Emperium cell. As this skill is the only way to heal emperiums. Recast if end.
	#    - http://irowiki.org/classic/Decrease_AGI
	#      Cast "Decrease AGI" on the player. Recast if lose effect.
	#    - http://irowiki.org/classic/Aspersio
	#      Cast "Aspersio" on the player. As the emperium have Holy element, the demage will be down to 0. Recast if end.
	# 
	if ($arg eq 'keep') {
		
	}
	# Buff the nearby guild members.
	if ($arg eq 'buff') {
		
	}
	# War mode:
	# When inside the castle, assist the other players by healing and removing status effects.
	# If nobody needs assistence and we have an enemy nearby that are bein attacked, spam "Lex Aeterna" on it.
	# Wait a while to use the skill:
	# - Blind: Cure
	# - Chaos: Cure
	# - Coma: Heal lv. 1
	# - Curse: Blessing lv. 1
	# - Frozen: Status Recovery
	# - Poison: Slow Poison
	# - Silence: Lex Divina
	# - Stone: Status Recovery
	# - Stun: Status Recovery
	if ($arg eq 'war') {
		
	}
}

##### PLUGIN BEHAVIOR

sub default {
	my (undef, $args) = @_;
	
	my $ID = unpack("V1", $args->{ID});
	
	my %count;
	
	# get the avariable targets
	my $monsters = $Globals::monstersList->getItems();

	# setup the actors list
	foreach my $monster (@{$monsters}) {
		# type >= 100       : monster
		# hair_style != 0x64: not pet
		if ($monster->{type} >= 1000 and $monster->{hair_style} ne 0x64) {
			# count them by the ID
			$count{$monster->{binType}}++;
		}
	}
	
	# loop the actors list
	foreach my $k (keys %count) {
		# &debugger("key: $k / val: $count{$k}");
		# if target is: and the amount is greater than 1
		if($k == "1111") {
			# send massage
			# Misc::sendMessage($messageSender, "pm", "Found", "Rasputin");
		}
		else {
			# teleport
			if (!Misc::useTeleport(1)) {
				&debugger("Unable to tele-search cause we can't teleport!\n");
				return;
			}
		}
	}
}

1;