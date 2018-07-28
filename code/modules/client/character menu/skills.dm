/datum/skills
	var/points = 3
	var/catalogue = "general"

	var/EVA = 1
	var/cookery = 1
	var/bartender = 1
	var/botany = 1
	var/closecomb = 1
	var/rangecomb = 1

	var/construction = 1
	var/hacking = 1
	var/electrical = 1
	var/atmospherics = 1
	var/engines = 1

	var/medicine = 1
	var/surgery = 1
	var/chemistry = 1
	var/genetics = 1

	var/xenoscience = 1
	var/rnd = 1
	var/telescience = 1
	var/robotics = 1

	male_mod
		EVA = 0
		cookery = 0
		bartender = 0
		botany = 0
		closecomb = 1
		rangecomb = 1

		construction = 1
		hacking = 0
		electrical = 0
		atmospherics = 0
		engines = 0

		medicine = 0
		surgery = 0
		chemistry = 0
		genetics = 0

		xenoscience = 0
		rnd = 0
		telescience = 0
		robotics = 0

	female_mod
		EVA = 0
		cookery = 1
		bartender = 0
		botany = 1
		closecomb = 0
		rangecomb = 0

		construction = 0
		hacking = 0
		electrical = 0
		atmospherics = 0
		engines = 0

		medicine = 1
		surgery = 0
		chemistry = 0
		genetics = 0

		xenoscience = 0
		rnd = 0
		telescience = 0
		robotics = 0


	neutral_mod
		EVA = 0
		cookery = 0
		bartender = 0
		botany = 0
		closecomb = 0
		rangecomb = 0

		construction = 0
		hacking = 0
		electrical = 0
		atmospherics = 0
		engines = 0

		medicine = 0
		surgery = 0
		chemistry = 0
		genetics = 0

		xenoscience = 0
		rnd = 0
		telescience = 0
		robotics = 0

	proc/AddJobMod(var/job_title)
		if(!job_title)	return
	//надо просмотреть все пометки
		//Ищем датум работы с таким именем
		var/datum/job/Job
		for(var/path in typesof(/datum/job)-/datum/job)
			var/datum/job/j = new path()
			world.log << "name: '[j.title]'"
			world.log << usr.mind.assigned_role //Ошибка тут. Но на что надо заменитьь?
			if(j.title == job_title)
				Job = j
				break


		var/datum/skills/job_skills = JobSkillMods[Job.title]

		EVA 			= min(1, max(6, EVA+job_skills.EVA))
		cookery 		= min(1, max(6, cookery+job_skills.cookery))
		bartender 		= min(1, max(6, bartender+job_skills.bartender))
		botany 			= min(1, max(6, botany+job_skills.botany))
		closecomb 		= min(1, max(6, closecomb+job_skills.closecomb))
		rangecomb 		= min(1, max(6, rangecomb+job_skills.rangecomb))

		construction 	= min(1, max(6, construction+job_skills.construction))
		hacking 		= min(1, max(6, hacking+job_skills.hacking))
		electrical 		= min(1, max(6, electrical+job_skills.electrical))
		atmospherics 	= min(1, max(6, atmospherics+job_skills.atmospherics))
		engines 		= min(1, max(6, engines+job_skills.engines))

		medicine 		= min(1, max(6, medicine+job_skills.medicine))
		surgery 		= min(1, max(6, surgery+job_skills.surgery))
		chemistry 		= min(1, max(6, chemistry+job_skills.chemistry))
		genetics 		= min(1, max(6, genetics+job_skills.genetics))

		xenoscience 	= min(1, max(6, xenoscience+job_skills.xenoscience))
		rnd 			= min(1, max(6, rnd+job_skills.rnd))
		telescience 	= min(1, max(6, telescience+job_skills.telescience))
		robotics 		= min(1, max(6, robotics+job_skills.robotics))

/*
Принцип работы навыков в настройке персонажа:
Есть четыре массива данных о навыках:
 Вложенные очки
 Модификаторы расы
 Модификаторы пола
 Модификаторы вероятных профессий (Пока не обрабатывать)



*/

/datum/preferences/proc/job_skill_mods()
	var/datum/skills/skills = new /datum/skills/neutral_mod() //Создаем датум с модификаторами о твсех профессий сразу

	for(var/path in typesof(/datum/job)-/datum/job)//Идет проверка каждой работы
		var/datum/job/Job = new path()
		var/datum/skills/job_skills = JobSkillMods[Job.title]
		if(!job_skills)	continue

		if(GetJobDepartment(Job, 3) || GetJobDepartment(Job, 2) || GetJobDepartment(Job, 1))
			if(job_skills.EVA >	skills.EVA)						skills.EVA = job_skills.EVA
			if(job_skills.cookery >	skills.cookery)				skills.cookery = job_skills.cookery
			if(job_skills.bartender > skills.bartender)			skills.bartender = job_skills.bartender
			if(job_skills.botany > skills.botany)				skills.botany = job_skills.botany
			if(job_skills.closecomb > skills.closecomb)			skills.closecomb = job_skills.closecomb
			if(job_skills.rangecomb > skills.rangecomb)			skills.rangecomb = job_skills.rangecomb

			if(job_skills.construction > skills.construction)	skills.construction = job_skills.construction
			if(job_skills.hacking >	skills.hacking)				skills.hacking = job_skills.hacking
			if(job_skills.electrical > skills.electrical)		skills.electrical = job_skills.electrical
			if(job_skills.atmospherics > skills.atmospherics)	skills.atmospherics = job_skills.atmospherics
			if(job_skills.engines >	skills.engines)				skills.engines = job_skills.engines

			if(job_skills.medicine > skills.medicine)			skills.medicine = job_skills.medicine
			if(job_skills.surgery >	skills.surgery)				skills.surgery = job_skills.surgery
			if(job_skills.chemistry > skills.chemistry)			skills.chemistry = job_skills.chemistry
			if(job_skills.genetics > skills.genetics)			skills.genetics = job_skills.genetics

			if(job_skills.xenoscience >	skills.xenoscience)		skills.xenoscience = job_skills.xenoscience
			if(job_skills.rnd >	skills.rnd)						skills.rnd = job_skills.rnd
			if(job_skills.telescience >	skills.telescience)		skills.telescience = job_skills.telescience
			if(job_skills.robotics > skills.robotics)			skills.robotics = job_skills.robotics

	return skills


/datum/preferences/proc/update_skills()
	var/datum/species/race = all_species[species]
	var/datum/skills/species_mod = race.skills_modificator
	var/datum/skills/gender_mod
	switch(gender)
		if("male")		gender_mod = new/datum/skills/male_mod
		if("female")	gender_mod = new/datum/skills/female_mod
		else		 	gender_mod = new/datum/skills/neutral_mod

	Skills.EVA 			= max(1, min(6, (Skill_points.EVA	  		+ species_mod.EVA			+ gender_mod.EVA)))
	Skills.cookery 		= max(1, min(6, (Skill_points.cookery		+ species_mod.cookery		+ gender_mod.cookery)))
	Skills.bartender 	= max(1, min(6, (Skill_points.bartender		+ species_mod.bartender		+ gender_mod.bartender)))
	Skills.botany 		= max(1, min(6, (Skill_points.botany		+ species_mod.botany		+ gender_mod.botany)))
	Skills.closecomb 	= max(1, min(6, (Skill_points.closecomb		+ species_mod.closecomb		+ gender_mod.closecomb)))
	Skills.rangecomb 	= max(1, min(6, (Skill_points.rangecomb		+ species_mod.rangecomb		+ gender_mod.rangecomb)))

	Skills.construction = max(1, min(6, (Skill_points.construction	+ species_mod.construction	+ gender_mod.construction)))
	Skills.hacking 		= max(1, min(6, (Skill_points.hacking		+ species_mod.hacking		+ gender_mod.hacking)))
	Skills.electrical 	= max(1, min(6, (Skill_points.electrical	+ species_mod.electrical	+ gender_mod.electrical)))
	Skills.atmospherics = max(1, min(6, (Skill_points.atmospherics	+ species_mod.atmospherics	+ gender_mod.atmospherics)))
	Skills.engines 		= max(1, min(6, (Skill_points.engines		+ species_mod.engines		+ gender_mod.engines)))

	Skills.medicine 	= max(1, min(6, (Skill_points.medicine		+ species_mod.medicine		+ gender_mod.medicine)))
	Skills.surgery 		= max(1, min(6, (Skill_points.surgery		+ species_mod.surgery		+ gender_mod.surgery)))
	Skills.chemistry 	= max(1, min(6, (Skill_points.chemistry		+ species_mod.chemistry		+ gender_mod.chemistry)))
	Skills.genetics 	= max(1, min(6, (Skill_points.genetics		+ species_mod.genetics		+ gender_mod.genetics)))

	Skills.xenoscience 	= max(1, min(6, (Skill_points.xenoscience	+ species_mod.xenoscience	+ gender_mod.xenoscience)))
	Skills.rnd 			= max(1, min(6, (Skill_points.rnd			+ species_mod.rnd			+ gender_mod.rnd)))
	Skills.telescience 	= max(1, min(6, (Skill_points.telescience	+ species_mod.telescience	+ gender_mod.telescience)))
	Skills.robotics 	= max(1, min(6, (Skill_points.robotics		+ species_mod.robotics		+ gender_mod.robotics)))








/datum/preferences/proc/table_skills(var/skill_level, var/job_level)
	var/dat = {"<table bgcolor="gray" bordercolor="black" border=1 cellspacing=1><tr height=15>"}
	dat += {"<td bgcolor="blue" width=15>"}
	dat += {"<td bgcolor="[(skill_level>=2) ? "blue" : ((skill_level+job_level>=2) ? "#AAAAFF" : "gray")]" width=15>"}
	dat += {"<td bgcolor="[(skill_level>=3) ? "blue" : ((skill_level+job_level>=3) ? "#AAAAFF" : "gray")]" width=15>"}
	dat += {"<td bgcolor="[(skill_level>=4) ? "blue" : ((skill_level+job_level>=4) ? "#AAAAFF" : "gray")]" width=15>"}
	dat += {"<td bgcolor="[(skill_level>=5) ? "blue" : ((skill_level+job_level>=5) ? "#AAAAFF" : "gray")]" width=15>"}
	dat += {"<td bgcolor="[(skill_level>=6) ? "blue" : ((skill_level+job_level>=6) ? "#AAAAFF" : "gray")]" width=15>"}
	dat += "</tr></table>"
	return dat

/datum/preferences/proc/text_advice(var/text)
	usr << browse_rsc(new/icon('icons/misc/interface.dmi', "vopros"),"vopros.png")
	return {"<abbr title="[text]"><img src='vopros.png'></abbr>"}

/datum/preferences/proc/skill_buttons(var/skill_level, var/type_skill)
	var/dat = (skill_level<=1) ? "<b>-</b>" : {"<a href='?_src_=prefs;preference=skills;task=skill_remove;type=[type_skill]'><b>-</b></a>"}
	dat+= " [skill_level] "
	dat+= (Skills.points<=0 || skill_level>=6) ? "<b>+</b>" : {"<a href='?_src_=prefs;preference=skills;task=skill_add;type=[type_skill]'><b>+</b></a>"}

	//Тут определяем влияние возможной выбранной профессии, отображая уровни скилла другим цветом
	var/job_skill = 0
	var/datum/skills/S = job_skill_mods()
	switch(type_skill)
		if("eva") 			job_skill = S.EVA
		if("cookery") 		job_skill = S.cookery
		if("bartender") 	job_skill = S.bartender
		if("botany") 		job_skill = S.botany
		if("closecomb") 	job_skill = S.closecomb
		if("rangecomb") 	job_skill = S.rangecomb

		if("construction") 	job_skill = S.construction
		if("hacking") 		job_skill = S.hacking
		if("electrical") 	job_skill = S.electrical
		if("atmospherics") 	job_skill = S.atmospherics
		if("engines") 		job_skill = S.engines

		if("medicine") 		job_skill = S.medicine
		if("surgery") 		job_skill = S.surgery
		if("chemistry") 	job_skill = S.chemistry
		if("genetics") 		job_skill = S.genetics

		if("xenoscience") 	job_skill = S.xenoscience
		if("rnd") 			job_skill = S.rnd
		if("telescience") 	job_skill = S.telescience
		if("robotics") 		job_skill = S.robotics



	return "</td><td>[dat]</td><td>[table_skills(skill_level, job_skill)]</td></tr>"




/datum/preferences/proc/ShowSkills(mob/user)
	update_skills()



	var/advice11 = text_advice("Умение правильно и быстро надевать скафандр, а так же передвигаться и работать в нем.")
	var/advice12 = text_advice("Навык готовки еды, пользования микроволновкой и прочим кухонным оборудованием.")
	var/advice13 = text_advice("Умение, помогающее смешивать алкогольные коктейли и другие напитки.")
	var/advice14 = text_advice("Способности к садоводству и работе с растениями, в том числе выведению новых видов.")
	var/advice15 = text_advice("Навыки безоружного боя и владения холодным оружием.")
	var/advice16 = text_advice("Навык обращения с различными видами огнестрельного и лазерного оружия.")

	var/advice21 = text_advice("Навыки постройки различных структур - от столов и табуреток до укрепленных стен.")
	var/advice22 = text_advice("Умение обхода электронных охранных систем, таких, как программа закрытой двери.")
	var/advice23 = text_advice("Навык работы с электрооборудованием и электрическими кабелями.")
	var/advice24 = text_advice("Умение работать с источниками энергии - от дизельных генераторов до карманной черной дыры.")
	var/advice25 = text_advice("Навыки обслуживания и установки самых различных труб и газовых систем.")

	var/advice31 = text_advice("Умение обращаться с общим медицинским оборудованием и лекарствами.")
	var/advice32 = text_advice("Навыки проведения хирургических операций и владение хирургическими инструментами.")
	var/advice33 = text_advice("Набор знаний о свойствах различных веществ и умение создавать из них различные лекарства и яды.")
	var/advice34 = text_advice("Навыки манипулирования генным кодом живых существ с помощью специализированного оборудования.")

	var/advice41 = text_advice("Навыки обращения с инопланетными организмами. В первую очередь, со слизнями.")
	var/advice42 = text_advice("Умение работать со сложным научным оборудованием и производить с его помощью научне открытия.")
	var/advice43 = text_advice("Умение обращаться с разного рода телепортерами и блю-спейс машинами.")
	var/advice44 = text_advice("Навыки обслуживания и взаимодействия с роботами и экзоскелетами.")

//Заголовки
	. = {"<tt><center>
<table width=80% align=center>
	<tr><td>Points: [Skills.points]</td></tr>
	<tr><td><table width=100%><tr><td><b>
	[(Skills.catalogue!="general")     ? "<a href='?_src_=prefs;preference=skills;task=open;type=general'>    General    </a>" : "General"]
	</b></td><td><b>
	[(Skills.catalogue!="engineering") ? "<a href='?_src_=prefs;preference=skills;task=open;type=engineering'>Engineering</a>" : "<b>Engineering"]
	</b></td><td><b>
	[(Skills.catalogue!="medical")    ? "<a href='?_src_=prefs;preference=skills;task=open;type=medical'>   Medical</a>" : "Medical"]
	</b></td><td><b>
	[(Skills.catalogue!="science")     ? "<a href='?_src_=prefs;preference=skills;task=open;type=science'>    Science</a>" : "Science"]
	</b></td><td align=center>|</td>
	<td align=right><a href='?_src_=prefs;preference=skills;task=open;type=reset'><b>Reset Skills</b>
	</td></tr></table></td></tr>
	<tr><td><hr></td></tr>
	<tr><td><table width=100%>"}


//Сами навыки
	switch(Skills.catalogue)
		if("general")	. += {"
<tr><td width=40%>EVA [advice11]					[skill_buttons(Skills.EVA, "eva")]
<tr><td>Cookery [advice12]							[skill_buttons(Skills.cookery, "cookery")]
<tr><td>Bartender [advice13]						[skill_buttons(Skills.bartender, "bartender")]
<tr><td>Botany [advice14]							[skill_buttons(Skills.botany, "botany")]
<tr><td>Close Combat [advice15]						[skill_buttons(Skills.closecomb, "closecomb")]
<tr><td>Range Combat [advice16]						[skill_buttons(Skills.rangecomb, "rangecomb")]
"}


		if("engineering")	. += {"
<tr><td width=45%>Construction [advice21]			[skill_buttons(Skills.construction, "construction")]
<tr><td>Hacking [advice22]							[skill_buttons(Skills.hacking, "hacking")]
<tr><td>Electrical engineering [advice23]			[skill_buttons(Skills.electrical, "electrical")]
<tr><td>Engines [advice24]							[skill_buttons(Skills.engines, "engines")]
<tr><td>Atmospherics [advice25]						[skill_buttons(Skills.atmospherics, "atmospherics")]
"}

		if("medical")	. += {"
		<tr><td width=45%>Medicine [advice31]		[skill_buttons(Skills.medicine, "medicine")]
		<tr><td>Surgery [advice32]					[skill_buttons(Skills.surgery, "surgery")]
		<tr><td>Chemistry [advice33]				[skill_buttons(Skills.chemistry, "chemistry")]
		<tr><td>Genetics [advice34]					[skill_buttons(Skills.genetics, "genetics")]
		"}

		if("science")	. += {"
		<tr><td width=45%>Xenoscience [advice41]	[skill_buttons(Skills.xenoscience, "xenoscience")]
		<tr><td>Research & Development [advice42]	[skill_buttons(Skills.rnd, "rnd")]
		<tr><td>Telescience [advice43]				[skill_buttons(Skills.telescience, "telescience")]
		<tr><td>Robotics [advice44]					[skill_buttons(Skills.robotics, "robotics")]
		"}


	. += {"</table></td></tr></center>
</table>
</tt>"}



/datum/preferences/proc/process_link_skills(mob/user, list/href_list)
	if(href_list["preference"] == "skills")
		if(href_list["task"]=="open")
			switch(href_list["type"])//Переключение между разделами
				if("general")		Skills.catalogue = "general"
				if("engineering")	Skills.catalogue = "engineering"
				if("medical")		Skills.catalogue = "medical"
				if("science")		Skills.catalogue = "science"
				if("reset")			ResetSkills()
		else if(href_list["task"])
			switch(href_list["type"])//Увеличение и уменьшение навыка
				if("eva")			Skill_points.EVA 			+= (href_list["task"]=="skill_add") ? 1 : -1
				if("cookery")		Skill_points.cookery 		+= (href_list["task"]=="skill_add") ? 1 : -1
				if("bartender")		Skill_points.bartender 		+= (href_list["task"]=="skill_add") ? 1 : -1
				if("botany")		Skill_points.botany 		+= (href_list["task"]=="skill_add") ? 1 : -1
				if("closecomb")		Skill_points.closecomb 		+= (href_list["task"]=="skill_add") ? 1 : -1
				if("rangecomb")		Skill_points.rangecomb 		+= (href_list["task"]=="skill_add") ? 1 : -1

				if("construction")	Skill_points.construction 	+= (href_list["task"]=="skill_add") ? 1 : -1
				if("hacking")		Skill_points.hacking 		+= (href_list["task"]=="skill_add") ? 1 : -1
				if("electrical")	Skill_points.electrical 	+= (href_list["task"]=="skill_add") ? 1 : -1
				if("atmospherics")	Skill_points.atmospherics 	+= (href_list["task"]=="skill_add") ? 1 : -1

				if("medicine")		Skill_points.medicine 		+= (href_list["task"]=="skill_add") ? 1 : -1
				if("surgery")		Skill_points.surgery 		+= (href_list["task"]=="skill_add") ? 1 : -1
				if("chemistry")		Skill_points.chemistry 		+= (href_list["task"]=="skill_add") ? 1 : -1
				if("genetics")		Skill_points.genetics 		+= (href_list["task"]=="skill_add") ? 1 : -1

				if("xenoscience")	Skill_points.xenoscience 	+= (href_list["task"]=="skill_add") ? 1 : -1
				if("rnd")			Skill_points.rnd 			+= (href_list["task"]=="skill_add") ? 1 : -1
				if("telescience")	Skill_points.telescience 	+= (href_list["task"]=="skill_add") ? 1 : -1
				if("robotics")		Skill_points.robotics 		+= (href_list["task"]=="skill_add") ? 1 : -1


			//Соответственно уменьшение или увеличение скиллпоинтов
			if(href_list["task"]=="skill_add")			Skills.points--
			else if(href_list["task"]=="skill_remove")	Skills.points++

			update_skills()



/datum/preferences/proc/ResetSkills()//Обнуление всех вложенных очков
	del Skills
	Skills = new/datum/skills

var/list/JobSkillMods = list()

proc/load_job_skills()
	for(var/datum/job/job in SSjob.occupations)
		var/datum/skills/neutral_mod/JobSkills = new
		var/list/skill_mods = splittext(file2text("data/job_skills/[job.title].txt"), "\n")
		for(var/string in skill_mods)
			string = replacetext(string, " ", "")
			var/list/string_vars = splittext(string, "=")
			switch(string_vars[1])
				if("EVA")			JobSkills.EVA 		= string_vars[2]
				if("cookery")		JobSkills.cookery 	= string_vars[2]
				if("bartender")		JobSkills.bartender = string_vars[2]
				if("botany")		JobSkills.botany 	= string_vars[2]
				if("closecomb")		JobSkills.closecomb = string_vars[2]
				if("rangecomb")		JobSkills.rangecomb = string_vars[2]

				if("construction")	JobSkills.construction 	= string_vars[2]
				if("hacking")		JobSkills.hacking 		= string_vars[2]
				if("electrical")	JobSkills.electrical 	= string_vars[2]
				if("atmospherics")	JobSkills.atmospherics 	= string_vars[2]
				if("engines")		JobSkills.engines 		= string_vars[2]

				if("medicine")		JobSkills.medicine 	= string_vars[2]
				if("surgery")		JobSkills.surgery 	= string_vars[2]
				if("chemistry")		JobSkills.chemistry = string_vars[2]
				if("genetics")		JobSkills.genetics 	= string_vars[2]

				if("xenoscience")	JobSkills.xenoscience 	= string_vars[2]
				if("rnd")			JobSkills.rnd 			= string_vars[2]
				if("telescience")	JobSkills.telescience 	= string_vars[2]
				if("robotics")		JobSkills.robotics 		= string_vars[2]

				else save_job_skills(job.title)

		JobSkillMods[job.title] = JobSkills

proc/save_job_skills(var/job_title)
	if(!fexists("data/job_skills/[job_title].txt"))
		var/dat = "EVA = 0\n"
		dat += "cookery = 0\n"
		dat += "bartender = 0\n"
		dat += "botany = 0\n"
		dat += "closecomb = 0\n"
		dat += "rangecomb = 0\n"

		dat += "construction = 0\n"
		dat += "hacking = 0\n"
		dat += "electrical = 0\n"
		dat += "atmospherics = 0\n"
		dat += "engines = 0\n"

		dat += "medicine = 0\n"
		dat += "surgery = 0\n"
		dat += "chemistry = 0\n"
		dat += "genetics = 0\n"

		dat += "xenoscience = 0\n"
		dat += "rnd = 0\n"
		dat += "telescience = 0\n"
		dat += "robotics = 0\n"

		text2file(dat, "data/job_skills/[job_title].txt")

world/New()
	..()
	load_job_skills()