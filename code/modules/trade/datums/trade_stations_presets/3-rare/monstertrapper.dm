// roach toxin bottles defined in module/reagents/reagent_containters/glass/bottle.dm
/datum/trade_station/trapper
	name_pool = list(
		"EXT 'Armitage'" = "Exterminator 'Armitage':\n\"Greetings, Colony. We're in a bit of a rough spot at the moment. Got any traps to spare?\".",
	)
	uid = "trapper"
	start_discovered = FALSE
	spawn_always = TRUE
	markup = UNIQUE_GOODS
	offer_limit = 5
	base_income = 3200
	secret_inv_threshold = 2000
	recommendation_threshold = 4000
	stations_recommended = list("illegal2")
	recommendations_needed = 2
	assortiment = list(
		"Roach Cubes and Eggs" = list(
			/obj/item/storage/deferred/roacheggs,	// make egg box
			/obj/item/reagent_containers/food/snacks/cube/roachling = custom_good_amount_range(list(1, 5)),
			/obj/item/reagent_containers/food/snacks/cube/roach = custom_good_amount_range(list(1, 5)),
			/obj/item/reagent_containers/food/snacks/cube/jager = custom_good_amount_range(list(1, 5)),
			/obj/item/reagent_containers/food/snacks/cube/seuche = custom_good_amount_range(list(1, 5)),
			/obj/item/reagent_containers/food/snacks/cube/panzer = custom_good_amount_range(list(1, 5)),
			/obj/item/reagent_containers/food/snacks/cube/grestrahlte = custom_good_amount_range(list(1, 5))
		),
		"Roach Toxins" = list(
			/obj/item/reagent_containers/glass/bottle/trade/blattedin = good_data("blattedin bottle", list(-1, 2)),
			/obj/item/reagent_containers/glass/bottle/trade/diplopterum = good_data("diplopterum bottle", list(-1, 2)),
			/obj/item/reagent_containers/glass/bottle/trade/seligitillin = good_data("seligitillin bottle", list(-1, 2)),
			/obj/item/reagent_containers/glass/bottle/trade/starkellin = good_data("starkellin bottle", list(-1, 2)),
			/obj/item/reagent_containers/glass/bottle/trade/gewaltine = good_data("gewaltine bottle", list(-1, 2))
		),
		"Spider Toxins" = list(
			/obj/item/reagent_containers/glass/bottle/trade/pararein = good_data("pararein bottle", list(-1, 2)),
			/obj/item/reagent_containers/glass/bottle/trade/aranecolmin = good_data("aranacolmin bottle", list(-1, 2))
		),
		"Carp Toxins" = list(
			/obj/item/reagent_containers/glass/bottle/trade/carpotoxin = good_data("carpotoxin bottle", list(-1, 2))
		)
	)
	secret_inventory = list(
		"High-End Roach Product" = list(
			/obj/item/reagent_containers/food/snacks/cube/kraftwerk = custom_good_amount_range(list(1, 5)),
			/obj/item/reagent_containers/glass/bottle/trade/fuhrerole = good_data("fuhrerole bottle", list(1, 1)),
			/obj/item/reagent_containers/glass/bottle/trade/kaiseraurum = good_data("kaiseraurum bottle", list(1, 1))
		),
		"Just Spiders" = list(
			/mob/living/carbon/superior_animal/giant_spider = custom_good_amount_range(list(2, 3)),
			/mob/living/carbon/superior_animal/giant_spider/nurse = custom_good_amount_range(list(-2, 3)),
			/mob/living/carbon/superior_animal/giant_spider/hunter = custom_good_amount_range(list(1, 2))
		)
	)
	//Types of items bought by the station
	offer_types = list(
		/obj/item/mine = offer_data("landmine", 1200, 10),
		/obj/item/beartrap = offer_data("mechanical trap", 600, 20),
		/obj/item/device/assembly/mousetrap = offer_data("mousetrap", 200, 20)
	)