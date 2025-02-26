/datum/trade_station/McRonalds
	name_pool = list(
		"McTB 'Dionis'" = "'McRonalds' Trade Beacon 'Dionis'. You hope they still have Happy Meals with a toy."
	)
	uid = "mcronalds"
	spawn_always = TRUE
	markup = UNCOMMON_GOODS
	base_income = 1600
	wealth = 0
	secret_inv_threshold = 2000
	recommendation_threshold = 4000
	stations_recommended = list("trapper")
	recommendations_needed = 1
	offer_limit = 30
	assortiment = list(
		"Burgers" = list(
			/obj/item/reagent_containers/food/snacks/bigbiteburger = custom_good_name("Big RBurger"),
			/obj/item/reagent_containers/food/snacks/jellyburger/cherry = custom_good_name("JellyCherry RBurger"),
			/obj/item/reagent_containers/food/snacks/tofuburger = custom_good_name("Tofu RBurger")
		),
		"Pizza" = list(
			/obj/item/pizzabox/meat = good_data("Supreme Meatlover: Pizza Alliance", list(1, 3)),
			/obj/item/pizzabox/mushroom = good_data("Mushrooms' Impact 3rd", list(1, 3)),
			/obj/item/pizzabox/vegetable = good_data("Pizza Fantasy 7: Vegeterian Deluxe Edition", list(1, 3)),
			/obj/item/pizzabox/margherita = good_data("PizzeR: autoTomato", list(1, 3))
		),
		"Cakes" = list(
			/obj/item/reagent_containers/food/snacks/sliceable/plaincake = good_data("Vanilla", list(1, 3)),
			/obj/item/reagent_containers/food/snacks/sliceable/chocolatecake = good_data("Chocola", list(1, 3)),
			/obj/item/reagent_containers/food/snacks/sliceable/carrotcake = custom_good_amount_range(list(1, 3)),
			/obj/item/reagent_containers/food/snacks/sliceable/cheesecake = custom_good_amount_range(list(1, 3)),
			/obj/item/reagent_containers/food/snacks/sliceable/orangecake = custom_good_amount_range(list(1, 3)),
			/obj/item/reagent_containers/food/snacks/sliceable/limecake = custom_good_amount_range(list(1, 3)),
			/obj/item/reagent_containers/food/snacks/sliceable/lemoncake = custom_good_amount_range(list(1, 3))
		),
		"Misc" = list(
			/obj/item/reagent_containers/food/snacks/fishandchips = custom_good_name("Fishps")
		)
	)
	secret_inventory = list(
		"Secret Menu" = list(
			/obj/item/storage/box/monkeycubes = good_data("Monkey Cubes", list(1, 5))
			// Needs funny and useful things
		)
	)
	offer_types = list(
		/obj/item/reagent_containers/food/snacks/meat = offer_data("meat", 100, 10),
		/obj/item/reagent_containers/food/snacks/meat/corgi = offer_data("corgi meat", 1000, 2),
		/obj/item/reagent_containers/food/snacks/meat/roachmeat = offer_data("roach meat", 300, 0),
		/obj/item/reagent_containers/food/snacks/meat/roachmeat/seuche = offer_data("seuche roach meat", 400, 0),
		/obj/item/reagent_containers/food/snacks/meat/roachmeat/kraftwerk = offer_data("kraftwerk roach meat", 600, 0),
		/obj/item/reagent_containers/food/snacks/meat/roachmeat/jager = offer_data("seuche roach meat", 350, 0)
	)