local sounds = {}
sounds.travel_worm = {}
sounds.travel_worm.slimy = {
	variations = {
		{
			filename = '__base__/sound/creatures/worm-folding-1.ogg',
		},
		{
			filename = '__base__/sound/creatures/worm-folding-2.ogg',
		},
		{
			filename = '__base__/sound/creatures/worm-folding-3.ogg',
		},
		{
			filename = '__base__/sound/creatures/worm-standup-small-1.ogg',
		},
		{
			filename = '__base__/sound/creatures/worm-standup-small-2.ogg',
		},
		{
			filename = '__base__/sound/creatures/worm-standup-small-3.ogg',
		}
	}
}
sounds.travel_worm.roaring = {
	variations = {
		{
			filename = '__base__/sound/creatures/worm-roar-1.ogg',
			volume = 0.6
		},
		{
			filename = '__base__/sound/creatures/worm-roar-2.ogg',
			volume = 0.6
		},
		{
			filename = '__base__/sound/creatures/worm-roar-3.ogg',
			volume = 0.6
		},
		{
			filename = '__base__/sound/creatures/worm-roar-4.ogg',
			volume = 0.6
		},
		{
			filename = '__base__/sound/creatures/worm-roar-alt-1.ogg',
			volume = 0.6
		},
		{
			filename = '__base__/sound/creatures/worm-roar-alt-2.ogg',
			volume = 0.6
		},
		{
			filename = '__base__/sound/creatures/worm-roar-alt-3.ogg',
			volume = 0.6
		},
		{
			filename = '__base__/sound/creatures/worm-roar-alt-4.ogg',
			volume = 0.6
		},
		{
			filename = '__base__/sound/creatures/worm-roar-alt-5.ogg',
			volume = 0.6
		}
    },
    audible_distance_modifier = 2.0
}
sounds.travel_worm.breathing = {
	variations = {
		{
			filename = '__base__/sound/creatures/worm-breathe-01.ogg',
			volume = 0.6
		},
		{
			filename = '__base__/sound/creatures/worm-breathe-02.ogg',
			volume = 0.6
		},
		{
			filename = '__base__/sound/creatures/worm-breathe-03.ogg',
			volume = 0.6
		},
		{
			filename = '__base__/sound/creatures/worm-breathe-04.ogg',
			volume = 0.6
		},
		{
			filename = '__base__/sound/creatures/worm-breathe-05.ogg',
			volume = 0.6
		},
		{
			filename = '__base__/sound/creatures/worm-breathe-06.ogg',
			volume = 0.6
		},
		{
			filename = '__base__/sound/creatures/worm-breathe-07.ogg',
			volume = 0.6
		},
		{
			filename = '__base__/sound/creatures/worm-breathe-08.ogg',
			volume = 0.6
		}
	}
}
sounds.travel_worm.attacking = {
	begin_sound = {
		{
			filename = "__base__/sound/creatures/worm-spit-start.ogg",
			volume = 0.0
		},
		{
			filename = "__base__/sound/creatures/worm-spit-start-2.ogg",
			volume = 0.0
		},
		{
			filename = "__base__/sound/creatures/worm-spit-start-3.ogg",
			volume = 0.0
		},
	},
	end_sound = {
		{
			filename = "__base__/sound/creatures/worm-spit-end.ogg",
			volume = 0.0
		}
	}
}
sounds.travel_worm.idling = sounds.travel_worm.breathing
sounds.travel_worm.impact = sounds.travel_worm.roaring
sounds.travel_worm.mined = sounds.travel_worm.slimy
sounds.travel_worm.starting = sounds.travel_worm.roaring
sounds.travel_worm.stopping = sounds.travel_worm.roaring
sounds.travel_worm.working = {
	variations = {
		{
			filename = '__base__/sound/creatures/worm-folding-1.ogg',
		},
		{
			filename = '__base__/sound/creatures/worm-folding-2.ogg',
		},
		{
			filename = '__base__/sound/creatures/worm-folding-3.ogg',
		},
		{
			filename = '__base__/sound/creatures/worm-standup-small-1.ogg',
		},
		{
			filename = '__base__/sound/creatures/worm-standup-small-2.ogg',
		},
		{
			filename = '__base__/sound/creatures/worm-standup-small-3.ogg',
		},
		{
			filename = '__base__/sound/creatures/worm-breathe-01.ogg',
			volume = 0.6
		},
		{
			filename = '__base__/sound/creatures/worm-breathe-02.ogg',
			volume = 0.6
		},
		{
			filename = '__base__/sound/creatures/worm-breathe-03.ogg',
			volume = 0.6
		},
		{
			filename = '__base__/sound/creatures/worm-breathe-04.ogg',
			volume = 0.6
		},
		{
			filename = '__base__/sound/creatures/worm-breathe-05.ogg',
			volume = 0.6
		},
		{
			filename = '__base__/sound/creatures/worm-breathe-06.ogg',
			volume = 0.6
		},
		{
			filename = '__base__/sound/creatures/worm-breathe-07.ogg',
			volume = 0.6
		},
		{
			filename = '__base__/sound/creatures/worm-breathe-08.ogg',
			volume = 0.6
		}
	}
}
return sounds.travel_worm
