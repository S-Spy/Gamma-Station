/mob/living/carbon/human/attack_paw(mob/M)
	..()
	if (M.a_intent == "help")
		help_shake_act(M)
	else
		if (istype(wear_mask, /obj/item/clothing/mask/muzzle))
			return

		for(var/mob/O in viewers(src, null))
			O.show_message(text("\red <B>[M.name] has bit []!</B>", src), 1)

		var/damage = rand(1, 3)
		var/miss_prob = 10
		if(skills)	switch(skills.closecomb)
			if(1)
				miss_prob = 30
				damage *= 0.5
			if(2)
				miss_prob = 20
				damage *= 0.75
			if(3)
				miss_prob = 15
				damage *= 1
			if(5)
				miss_prob = 5
				damage *= 1.2
			if(6)
				miss_prob = 2
				damage *= 1.5


		if(!prob(miss_prob))
			var/dam_zone = pick(BP_CHEST , BP_L_ARM , BP_R_ARM , BP_L_LEG , BP_R_LEG)
			var/obj/item/organ/external/BP = bodyparts_by_name[ran_zone(dam_zone)]
			apply_damage(max(1, round(damage)), BRUTE, BP, run_armor_check(BP, "melee"))

			for(var/datum/disease/D in M.viruses)
				if(istype(D, /datum/disease/jungle_fever))
					var/mob/living/carbon/human/H = src
					src = null
					src = H.monkeyize()
					contract_disease(D,1,0)
		else
			src.attack_missed("paw attack")
	return
