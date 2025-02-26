/mob/living/proc/handle_recoil(var/obj/item/gun/G)
	if(!ishuman(src)) //Soj edit, if your not human you dont have recoil. saves on preformance when mobs shoot
		return
	deltimer(recoil_reduction_timer)
	if(G.one_hand_penalty)//If the gun has a two handed penalty and is not weilded.
		if(!G.wielded && !usr.stats.getPerk(PERK_PERFECT_SHOT))
			recoil += G.one_hand_penalty //Then the one hand penalty will be added to the recoil.

	var/debug_recoil = min(0.3, G.fire_delay)
	if(G.fire_delay == 0)
		debug_recoil = 0.3
	if(G.burst > 1)
		debug_recoil = max(debug_recoil, G.burst_delay)

	add_recoil(G.recoil_buildup + debug_recoil) // DEBUG, remove the debug_recoil after testing is over!

/mob/living/proc/external_recoil(var/recoil_buildup) // Used in human_attackhand.dm
	deltimer(recoil_reduction_timer)
	add_recoil(recoil_buildup)

/mob/proc/handle_movement_recoil() // Used in movement/mob.dm
	return // Only the living have recoil

//proc is edited a lot by SoJ
/mob/living/handle_movement_recoil()
	if(!ishuman(src)) //Soj edit, if your not human you dont have recoil. saves on preformance when mobs shoot
		return
	deltimer(recoil_reduction_timer)

	var/base_recoil = 1

	var/mob/living/carbon/human/H = src
	var/suit_stiffness = 0
	var/uniform_stiffness = 0
	if(H.wear_suit)
		suit_stiffness = H.wear_suit.stiffness
	if(H.w_uniform)
		uniform_stiffness = H.w_uniform.stiffness
	base_recoil += suit_stiffness + suit_stiffness * uniform_stiffness // Wearing it under actual armor, or anything too thick is extremely uncomfortable.
	add_recoil(base_recoil)

/mob/living/proc/add_recoil(var/recoil_buildup)
	if(!ishuman(src)) //Soj edit, if your not human you dont have recoil. saves on preformance when mobs shoot
		return
	if(recoil_buildup)
		recoil += recoil_buildup
		update_recoil()

/mob/living/proc/calc_recoil()
	if(!ishuman(src)) //Soj edit, if your not human you dont have recoil. saves on preformance when mobs shoot
		return
	var/minimum = 0.4
	var/scale = 0.8
	var/limit = 2 //minimum / (1 - scale) - Soj edit smallest bit of profrmance, eris will prob change this soon anyways

	if(recoil >= limit)
		recoil *= scale
	else if(recoil < limit && recoil > minimum)
		recoil -= minimum
	else
		recoil = 0

	update_recoil()

/mob/living/proc/calculate_offset(var/offset = 0)
	if(!ishuman(src)) //Soj edit, if your not human you dont have recoil. saves on preformance when mobs shoot
		return
	if(recoil)
		offset += recoil
	var/mob/living/carbon/human/H = src
	if(H.head)
		offset += H.head.obscuration
	offset -= CLAMP(H.stats.getStat(STAT_VIG), 0, STAT_LEVEL_PROF) * 0.1 // Up to max -6 offset
	offset = round(offset)
	offset = CLAMP(offset, 0, MAX_ACCURACY_OFFSET)
	return offset

//Called after setting recoil
/mob/living/proc/update_recoil()
	if(!ishuman(src)) //Soj edit, if your not human you dont have recoil. saves on preformance when mobs shoot
		return
	var/obj/item/gun/G = get_active_hand()
	if(istype(G) && G)
		G.check_safety_cursor(src)

	if(recoil != 0)
		recoil_reduction_timer = addtimer(CALLBACK(src, .proc/calc_recoil), 0.1 SECONDS, TIMER_STOPPABLE)
	else
		deltimer(recoil_reduction_timer)

/mob/living/proc/update_cursor(var/obj/item/gun/G)
	if(get_preference_value(/datum/client_preference/gun_cursor) != GLOB.PREF_YES)
		remove_cursor()
		return
	if(client)
		client.mouse_pointer_icon = initial(client.mouse_pointer_icon)
		var/offset = round(calculate_offset(G.init_offset) * 0.8)
		var/icon/base = find_cursor_icon('icons/obj/gun_cursors/standard/standard.dmi', offset)
		ASSERT(isicon(base))
		client.mouse_pointer_icon = base

/mob/living/proc/remove_cursor()
	if(client)
		client.mouse_pointer_icon = initial(client.mouse_pointer_icon)

/proc/find_cursor_icon(var/icon_file, var/offset)
	var/list/L = GLOB.cursor_icons[icon_file]
	if(L)
		return L["[offset]"]

/proc/add_cursor_icon(var/icon/icon, var/icon_file, var/offset)
	var/list/L = GLOB.cursor_icons[icon_file]
	if(!L)
		GLOB.cursor_icons[icon_file] = list()
		L = GLOB.cursor_icons[icon_file]
	L["[offset]"] = icon

/proc/make_cursor_icon(var/icon_file, var/offset)
	var/icon/base = icon('icons/effects/96x96.dmi')
	var/icon/scaled = icon('icons/obj/gun_cursors/standard/standard.dmi') //Default cursor, cut into pieces according to their direction
	base.Blend(scaled, ICON_OVERLAY, x = 32, y = 32)

	for(var/dir in list(NORTHEAST,NORTHWEST,SOUTHEAST,SOUTHWEST))
		var/icon/overlay = icon('icons/obj/gun_cursors/standard/standard.dmi', "[dir]")
		var/pixel_y
		var/pixel_x
		if(dir & NORTH)
			pixel_y = CLAMP(offset, -MAX_ACCURACY_OFFSET, MAX_ACCURACY_OFFSET)
		if(dir & SOUTH)
			pixel_y = CLAMP(-offset, -MAX_ACCURACY_OFFSET, MAX_ACCURACY_OFFSET)
		if(dir & EAST)
			pixel_x = CLAMP(offset, -MAX_ACCURACY_OFFSET, MAX_ACCURACY_OFFSET)
		if(dir & WEST)
			pixel_x = CLAMP(-offset, -MAX_ACCURACY_OFFSET, MAX_ACCURACY_OFFSET)
		base.Blend(overlay, ICON_OVERLAY, x=32+pixel_x, y=32+pixel_y)
	add_cursor_icon(base, 'icons/obj/gun_cursors/standard/standard.dmi', offset)
	return base

/proc/send_all_cursor_icons(var/client/C)
	var/list/cursor_icons = GLOB.cursor_icons
	for(var/icon_file in cursor_icons)
		var/list/icons = cursor_icons[icon_file]
		for(var/offset in icons)
			var/icon/I = icons[offset]
			C << I
