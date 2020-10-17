remote.add_interface('nauvis-melange', {
	informatron_menu = function(data)
	  	return nauvis_melange_menu(data.player_index)
	end,
	informatron_page_content = function(data)
	  	return nauvis_melange_page_content(data.page_name, data.player_index, data.element)
	end
})

nauvis_melange_menu = function(player_index)
	return {
		['spice-processing'] = 1,
		['alien-breeding'] = 1,
		['spacing-guild'] = 1
	}
end

nauvis_melange_page_content = function(page_name, player_index, element)
	if page_name == 'nauvis-melange' then
		element.add{type='label', name='text_1', caption={'nauvis-melange.text_welcome'}}
	else
		element.add{type='label', name='text_1', caption={'nauvis-melange.text_'..page_name}}
	end
end
