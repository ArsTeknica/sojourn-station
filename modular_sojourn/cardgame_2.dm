
//This is fancy! We want to have THIS be used to draw and deal everything
/obj/item/cardholder
	w_class = ITEM_SIZE_SMALL
	name = "randomizer card box"
	desc = "A small box that self shuffles every time a card is added or drawn, making it always random. This only fits and works with CardCarpCo Cards. Alt Click to draw a card."
	icon = 'modular_sojourn/cardgame_sprites.dmi'
	icon_state = "card_holder"
	var/obj/item/card_carp/card_target = null //What card were going to get
	var/endless = FALSE //Are we going to give endless cards?
	var/card_eater = FALSE

/obj/item/cardholder/AltClick(mob/user)
	draw_card()
	return

/obj/item/cardholder/proc/draw_card(mob/user)
	var/turf/T = get_turf(src)
	if(endless)
		new card_target(T)
		return
	if(!contents)
		to_chat(user, SPAN_NOTICE("The [src] has no cards."))
		return
	else
		card_target = pick(contents)
		card_target.loc = T
		card_target = /obj/item/card_carp //so we have vars

/obj/item/cardholder/attackby(obj/item/C, mob/user as mob)
	..()
	if(istype(C, /obj/item/card_carp))
		var/obj/item/card_carp/card = C
		if(card_eater) //Putting squirls back in their box
			user.visible_message(SPAN_NOTICE("[user] puts \the [card] into \the [src]."), SPAN_NOTICE("You put \the [card] into \the [src]."))
			qdel(card)
			return
		if(card.cant_box && endless) //Putting squirls back in their box
			user.visible_message(SPAN_NOTICE("[user] puts \the [card] into \the [src]."), SPAN_NOTICE("You put \the [card] into \the [src]."))
			qdel(card)
			return
		if(card.cant_box || endless)
			to_chat(user, SPAN_NOTICE("The [src] rejects \the [card]."))
			return
		else
			user.remove_from_mob(card)
			src.contents += card
			user.visible_message(SPAN_NOTICE("[user] puts \the [card] into \the [src]."), SPAN_NOTICE("You put \the [card] into \the [src]."))
		return


/obj/item/cardholder/squirl
	name = "squirrel card box"
	desc = "A box of cards that only have squirrel CarpCarpCo Cards. The standard side deck for most players."
	card_target =  /obj/item/card_carp/squirl
	icon_state = "folly_deck"
	endless = TRUE

/obj/item/cardholder/ratbox
	name = "rat card box"
	desc = "A box of cards that only have rat CarpCarpCo Cards. An unusual choice for a side deck, replacing squirrels by giving H1/P1 rats that cannot give blood."
	card_target =  /obj/item/card_carp/rat
	icon_state = "folly_deck"
	endless = TRUE

/obj/item/cardholder/shell
	name = "shell card box"
	desc = "A box of cards that only have shell CarpCarpCo Cards."
	card_target =  /obj/item/card_carp/shell
	icon_state = "folly_deck"
	endless = TRUE

/obj/item/cardholder/endless
	name = "celestial card box"
	desc = "A box of cards that has a seemingly endless amount of CarpCarpCo Cards."
	card_target =  /obj/random/card_carp/pelt_and_normal_cards
	icon_state = "folly_deck"
	endless = TRUE
	card_eater = TRUE


/obj/item/card_carp
	name = "Rules Card"
	desc = "To start the game: Place down a scale or tally system, make sure its balance is at 0.<BR>\n\
	Both players may only have 1 non-fodder deck.<BR>\n\
	The field of play is a (recommended) 4 x 5 grid, players may only play cards on their side of the field unless otherwise noted.<BR>\n\
	At the beginning of the game, both players draw 3 cards + 1 fodder card.<BR>\n\
	After drawing their initial cards, players may place any terrian or blocker cards anywhere on the field.<BR>\n\
	At the beginning of each turn, a player may draw 1 fodder card or 1 card from their deck box.<BR>\n\
	Playing Cards:<BR>\n\
	Some cards have an associated blood cost. This cost is paid by sacrificing a total amount of cards on the summoners field to equal the amount required. Unless otherwise stated, one card is one bloods.<BR>\n\
	Some cards have an associated bones cost. Bones are paid by using a players discard pile. Cards are discarded when they are sacrified or die. Cards used to pay for bone costs are placed back \
	into deck box they were drawn from. Unless otherwise stated, one card is one bone.<BR>\n\
	Blood costs may NOT be paid using cards not on the field or in the discard pile.<BR>\n\
	Bone costs may ONLY be paid using cards in the discard pile.<BR>\n\
	Attacking:<BR>\n\
	When a player ends their turn, all cards from left to right act. Left to right is determined by the attacking players position.<BR>\n\
	Any card in the back row capable of moving to the first row does so, moving first and then attacking. Cards in the back row cannot attack.<BR>\n\
	Cards deal damage to cards opposite on the board to them. Damage delt in excess to a cards health carries over to the card behind it but NOT the player unless otherwise stated.<BR>\n\
	Cards in the back row cannot attack or move cards in the front row of their side of the field unless otherwise stated, even if that card is a blocker, obstacle, or pelt.<BR>\n\
	When a card dies, it is placed inside the discard pile of the owner of the card unless otherwise stated.<BR>\n\
	Cards:<BR>\n\
	All cards have health, power, and play requirements noted on the card. Some cards have special effects or rules that are also noted on the card or on the rules card.<BR>\n\
	All cards follow the format of Health/Power. A wolf card with 2 health and 3 power is represented as H2/P3 on the card.<BR>\n\
	Cards must be played first in the back row and only move onto the front row at the end of the owner's turn. Only cards moving into or already present in the front row may attack.<BR>\n\
	If a card has no opposing card opposite to it, the card deals damage the other player.<BR>\n\
	When a player takes damage, the scale or tally system gets moved towards the person equal to the total amount of damage taken, when a player has 5 or more damage, they lose.<BR>\n\
	Card Effects:<BR>\n\
	Flying - Cards with flying ignore blockers, obstacles, and pelts unless that card is capable of blocking flyers. Having flying does not give a card the ability to block other flyers.<BR>\n\
	Destructive - All cards with destructive kill all cards of the same type when dying. I.E. a crab with virulent kills all other crabs. Type is determined by matching words in the name.<BR>\n\
	Deathtouch - On attack, any card it is facing is considered killed. Damage and death touch do not carry over to any cards or player behind it.<BR>\n\
	Eternal - This card does not die when used as a sacrifice for blood.<BR>\n\
	Stinky - This card reduces any opposing cards power by 1.<BR>\n\
	Defender - This card can block cards with flying.<BR>\n\
	Prong Strike - This card attacks twice, dealing damage and attacking on the left and right side of the card. Prong Strike prevents attacking the card directly opposing this card. If a prong \
	strike creatures attack would go off the grid it deals no damage and is negated.<BR>\n\
	Tri Strike - As prong strike, but also attacks the opposing card.<BR>\n\
	Guard - If an unoccupied space would be attacked by an opposing card, this card moves to that space and blocks that attack. This effect may happen mutiple times until all attacks are resolved or \
	the guarding card is dead.<BR>\n\
	Fortune - As long as this card remains on the field, all players draw two cards. Players may choose to draw once from each deck or twice from a single deck. Fortune cards do not stack with other \
	fortune cards.<BR>\n\
	Generous - When this card is played, the owner may draw a card of their choice from either deck.<BR>\n\
	Undying - When this card dies, instead of being placed in the owner's discard pile, it is returned to the owner's hand.<BR>\n\
	Chime - When this card dies, the owner of this card draws one card from a deck of their choice.<BR>\n\
	Pelt - Pelt cards may be placed on any position on either players board when played. Pelt cards do not move but otherwise follow the same rules as other cards. Pelt cards cannot be sacrificed \
	for blood and are added to the discard pile upon death.<BR>\n\
	Terrain - Terrain  cards may be placed on any position on either players board before the game begins. Terrain cards do not move and cannot be sacrified for blood, nor do they give bones. When a terrain card is \
	destroyed unless otherwise noted it is not placed in the player's discard pile and is instead removed from the game. Each player can only play a maximum of 2 terrain cards during pre-match set up.<BR>\n\
	Kinship - This card gains power equal to the amount of cards sharing the same type currently on the field under that player's control. Each card can only add 1 power, no matter how many matching \
	types they have, unless otherwise stated. Kinship cards do not count themselves for the purposes of gaining power."
	icon = 'modular_sojourn/cardgame_sprites.dmi'
	icon_state = "cardblank"
	var/cant_box = FALSE
	w_class = ITEM_SIZE_TINY
	var/current_health = 0

/obj/item/card_carp/index
	name = "Index-Effects: CardCarp"
	desc = "Card Effects:<BR>\n\
	Flying - Cards with flying ignore blockers, obstacles, and pelts unless that card is capable of blocking flyers. Having flying does not give a card the ability to block other flyers.<BR>\n\
	Destructive - All cards with destructive kill all cards of the same type when dying. I.E. a crab with virulent kills all other crabs. Type is determined by matching words in the name.<BR>\n\
	Deathtouch - On attack, any card it is facing is considered killed. Damage and death touch do not carry over to any cards or player behind it.<BR>\n\
	Eternal - This card does not die when used as a sacrifice for blood.<BR>\n\
	Stinky - This card reduces any opposing cards power by 1.<BR>\n\
	Defender - This card can block cards with flying.<BR>\n\
	Prong Strike - This card attacks twice, dealing damage and attacking on the left and right side of the card. Prong Strike prevents attacking the card directly opposing this card. If a prong \
	strike creatures attack would go off the grid it deals no damage and is negated.<BR>\n\
	Tri Strike - As prong strike, but also attacks the opposing card.<BR>\n\
	Guard - If an unoccupied space would be attacked by an opposing card, this card moves to that space and blocks that attack. This effect may happen mutiple times until all attacks are resolved or \
	the guarding card is dead.<BR>\n\
	Fortune - As long as this card remains on the field, all players draw two cards. Players may choose to draw once from each deck or twice from a single deck. Fortune cards do not stack with other \
	fortune cards.<BR>\n\
	Generous - When this card is played, the owner may draw a card of their choice from either deck.<BR>\n\
	Undying - When this card dies, instead of being placed in the owner's discard pile, it is returned to the owner's hand.<BR>\n\
	Chime - When this card dies, the owner of this card draws one card from a deck of their choice.<BR>\n\
	Pelt - Pelt cards may be placed on any position on either players board when played. Pelt cards do not move but otherwise follow the same rules as other cards. Pelt cards cannot be sacrificed \
	for blood and are added to the discard pile upon death.<BR>\n\
	Terrain - Terrain  cards may be placed on any position on either players board before the game begins. Terrain cards do not move and cannot be sacrified for blood, nor do they give bones. When a terrain card is \
	destroyed unless otherwise noted it is not placed in the player's discard pile and is instead removed from the game. Each player can only play a maximum of 2 terrain cards during pre-match set up.<BR>\n\
	Kinship - This card gains power equal to the amount of cards sharing the same type currently on the field under that player's control. Each card can only add 1 power, no matter how many matching \
	types they have, unless otherwise stated. Kinship cards do not count themselves for the purposes of gaining power."

/obj/item/card_carp/examine(mob/user)
	..()
	to_chat(user, "<span class='info'>The cards current health is : [current_health]</span>")
	to_chat(user, "<span class='info'>To remove health, AltClick the card, to reset the cards health CtrlShiftClick.</span>")

/obj/item/card_carp/AltClick(mob/user)
	current_health -= 1
	user.visible_message(SPAN_NOTICE("[user] removes a health point form [src] making it [current_health]."), SPAN_NOTICE("You remove a health point form \the [src]."))
	return

/obj/item/card_carp/CtrlShiftClick(mob/user)
	current_health = initial(current_health)
	user.visible_message(SPAN_NOTICE("[user] resets \the [src] health pool."), SPAN_NOTICE("You put a health points to max on \the [src]."))
	return

/obj/item/card_carp/squirl
	name = "Squirrel"
	desc = "A squirrel, the rodent lynchpin to most decks. H1/P0."
	icon_state = "card_squirl"
	cant_box = TRUE
	current_health = 1

/obj/item/card_carp/rat
	name = "Rat"
	desc = "A rat, a fastidiously clean creature. H1/P1. Cannot provide blood."
	icon_state = "card_rat"
	cant_box = TRUE
	current_health = 1

/obj/item/card_carp/shell
	name = "Shell"
	desc = "A robotic shell, serves little purpose. H1/P0."
	icon_state = "card_squirls"
	cant_box = TRUE
	current_health = 1

/obj/item/card_carp/moon
	name = "Moon"
	desc = "The moon, scenic and dangerous and only used by blatent cheaters. H40/P1. Defender. Takes up all rows on the owner's side. Deals 1 damage to all cards on the opposing side. Cannot hit opposing player as long as 1 card is capable of blocking."
	icon_state = "card_moon"
	current_health = 40

/obj/item/card_carp/goat
	name = "Goat"
	desc = "A black goat, perfect for serving your stronger creatures. H2/P0. Gives three blood."
	icon_state = "card_goat"
	current_health = 2

/obj/item/card_carp/crab
	name = "Crab"
	desc = "A crab, the best sea to land raider. H1/P2, Requires 1 blood. Destructive."
	icon_state = "card_crab"
	current_health = 1

/obj/item/card_carp/adder
	name = "Adder"
	desc = "A snake, as venomous as they come. H1/P0, Requires 1 blood. On attack, removes any card it is facing."
	icon_state = "card_adder"
	current_health = 1

/obj/item/card_carp/cat
	name = "Cat"
	desc = "A feline, a favorite among certain opossums. H1/P0. Eternal."
	icon_state = "card_cat"
	current_health = 1

/obj/item/card_carp/stote
	name = "Stote"
	desc = "A stote, one of the lesser known mustelids. H3/P1. Requires 1 blood."
	icon_state = "card_stote"
	current_health = 3

/obj/item/card_carp/stinkbug
	name = "Stink Bug"
	desc = "A stink bug, a surprisingly durable creature. H2/P1, Requires 2 bones. Stinky."
	icon_state = "card_stinkbug"
	current_health = 2

/obj/item/card_carp/stunted_wolf
	name = "Stunted Wolf"
	desc = "A sad looking wolf, longing for something. H2/P2. Requires 1 bone."
	icon_state = "card_stuntedwolf"
	current_health = 2

/obj/item/card_carp/croaker_lord
	name = "Bullfrog"
	desc = "A bullfrog, an amphibian with a bulging leathery throat. H3/P1. Requires 1 blood. Defender"
	icon_state = "card_frog"
	current_health = 3

/obj/item/card_carp/wolf
	name = "Wolf"
	desc = "A wolf, a well known and dangerous hunter. H2/P3. Requires 2 blood."
	icon_state = "card_wolf"
	current_health = 2

/obj/item/card_carp/manti
	name = "Mantis"
	desc = "A mantis, an insect born for bloodshed. H1/P1 Requires 1 blood. Prong Strike."
	icon_state = "card_mantis"
	current_health = 1

/obj/item/card_carp/manti_lord
	name = "Mantis God"
	desc = "The gods of the mantis, the deadliest of the insects. H1/P1. Requires 2 blood and 2 bones. Tri Strike. Defender." //Cant play this at turn one you cheater >:T
	icon_state = "card_mantislord"
	current_health = 1

/obj/item/card_carp/mole
	name = "Mole"
	desc = "A mole, the under rated tunneler. H5/P0. Requires 1 blood. Gaurd."
	icon_state = "card_mole"
	current_health = 5

/obj/item/card_carp/mole_man
	name = "Mole Man"
	desc = "A mole and a man combined into something more. H6/P0. Requires 2 blood. Gaurd. Defender."
	icon_state = "card_moleman"
	current_health = 6

/obj/item/card_carp/coyote
	name = "Coyote"
	desc = "A coyote, a tricky canine. H1/P2. Requires 4 bones."
	icon_state = "card_coyote"
	current_health = 1

/obj/item/card_carp/elk
	name = "Elk"
	desc = "An elk, a mighty forest stag. H4/P2. Requires 2 blood. Defender."
	icon_state = "card_elk_spawn"
	current_health = 4

/obj/item/card_carp/magpie
	name = "Magpie"
	desc = "A magpie, one of the often forgotten members of the corvid family. H1/P1. Requires 2 blood. Flying. Fortune."
	icon_state = "card_magpie"
	current_health = 1

/obj/item/card_carp/river_otter
	name = "River Otter"
	desc = "A river otter, soft and kind. H1/P1. Requires 1 blood. Gaurd."
	icon_state = "card_riverotter"
	current_health = 1

/obj/item/card_carp/grizzly
	name = "Grizzly"
	desc = "A grizzly bear, the most dangerous of all predators. H6/P4. Requires 3 blood."
	icon_state = "card_bear"
	current_health = 6

/obj/item/card_carp/great_white
	name = "Great White Carp"
	desc = "A great white carp, adept in water and space. H4/P5. Requires 3 blood. Gaurd."
	icon_state = "card_carp"
	current_health = 4

/obj/item/card_carp/kingfisher
	name = "Kingfisher"
	desc = "A kingfisher, one of the fastest of birds. H2/P2, Requires 1 blood. Gaurd."
	icon_state = "card_kingfisher"
	current_health = 2

/obj/item/card_carp/sparrow
	name = "Sparrow"
	desc = "A sparrow, the quick of wit and wing. H1/P2. Requires 1 blood. Flying."
	icon_state = "card_sparrow"
	current_health = 1

/obj/item/card_carp/turkey_vulture
	name = "Turkey Vulture"
	desc = "A turkey vulture, the care taker of the dead. H3/P3, Requires 8 bones. Flying."
	icon_state = "card_turnkyvaulter"
	current_health = 3

/obj/item/card_carp/warren
	name = "Warren"
	desc = "A warren, home to all manner of rabbits and rodents. H3/P0. Requires 1 blood. Undying."
	icon_state = "card_warren"
	current_health = 3

/obj/item/card_carp/rabbit
	name = "Rabbit"
	desc = "A rabbit, a greatly undervalued card. H1/P0."
	icon_state = "card_rabbit"
	current_health = 1

/obj/item/card_carp/bat
	name = "Bat"
	desc = "A bat, blind but not deaf. H1/P2. Requires 1 bone. Flying"
	icon_state = "card_bat"
	current_health = 1

/obj/item/card_carp/daus
	name = "Daus"
	desc = "A daus, an ill tempered and dangerous creature as ornery as they come. H2/P2. Requires 2 blood. Chime."
	icon_state = "card_daus"
	current_health = 2

/obj/item/card_carp/geck
	name = "Geck"
	desc = "A geck, a favorite of many. H1/P1."
	icon_state = "card_aplha"
	current_health = 1

/obj/item/card_carp/larva
	name = "Moth Larva"
	desc = "A moth larva, brimming with potential. H3/P0. Requires 1 bone. Gives 2 blood. Kinship"
	icon_state = "card_larva"
	current_health = 3

/obj/item/card_carp/pupa
	name = "Moth Pupa"
	desc = "A moth pupa, almost all it can be. H3/P1. Requires 3 bones. Gives 3 blood. Kinship"
	icon_state = "card_pupa"
	current_health = 3

/obj/item/card_carp/mothman
	name = "Moth Man"
	desc = "A moth man, the last of his mysterious people. H7/P4. Kinship."
	icon_state = "card_mothman"
	current_health = 1

/obj/item/card_carp/beaver
	name = "Beaver"
	desc = "A beaver, the most industrious of rodents. H1/P3. Requires 2 blood."
	icon_state = "card_bever"
	current_health = 1

/obj/item/card_carp/wyrm
	name = "Ring Wyrm"
	desc = "A ring wyrm, a circular creature. H1/P0. Requires 1 blood. On death, all cards attacking it die."
	icon_state = "card_ring"
	current_health = 1

/obj/item/card_carp/cockroach
	name = "Roachling"
	desc = "A roachling, a common thing across many ships and world. H1/P1. Requires 2 bones. Undying."
	icon_state = "card_roach"
	current_health = 1

/obj/item/card_carp/ratking
	name = "Rat King"
	desc = "A rat king, bound by things often considered ill of omen. H1/P2. Requires 2 blood. Worth 4 bones."
	icon_state = "card_ratking"
	current_health = 1

/obj/item/card_carp/packrat
	name = "Pack Rat"
	desc = "A pack rat, a humble creature here to offer aid. H2/P2. Requires 2 blood. Generous."
	icon_state = "card_packrat"
	current_health = 2

/obj/item/card_carp/plaguerat
	name = "Plague Rat"
	desc = "A rat with the plague, still welcomed by its kin. H1/P1. Requires 3 bones. Kinship."
	icon_state = "card_plaguerat"
	current_health = 1

/obj/item/card_carp/kangaroorat
	name = "Kangaroo Rat"
	desc = "The kangaroo rat, as graceful as it is clumsy. H1/P2. Requires 3 bones. Flying."
	icon_state = "card_kangaroorat"
	current_health = 1

/obj/item/card_carp/chipmunk
	name = "Chipmunk"
	desc = "A chipmunk, smaller and more careful than its larger cousins. H1/P1. Requires 1 blood. When played, both players draw a fodder card."
	icon_state = "card_chipmunk"
	current_health = 1

/obj/item/card_carp/fieldmice
	name = "Field Mice"
	desc = "Field mice, the smaller cousins to the rats and just as tenacious. H2/P2. Requires 2 blood OR 2 bones. Upon death, return to the owner's deck."
	icon_state = "card_fieldmice"
	current_health = 2

/obj/item/card_carp/opossum
	name = "Opossum"
	desc = "An opossum, an ugly but friendly creature. H1/P1. Requires 2 bones."
	icon_state = "card_opossum"
	current_health = 1

/obj/item/card_carp/ant
	name = "Ant"
	desc = "An ant, an industrious bug. H1/P1. Requires 1 blood. Kinship."
	icon_state = "card_workerant"
	current_health = 1

/obj/item/card_carp/antqueen
	name = "Queen Ant"
	desc = "A queen ant, royalty among her kind. H1/P1. Requires 1 bone."
	icon_state = "card_queen"
	current_health = 1

/obj/item/card_carp/rpelt
	name = "Rabbit Pelt"
	desc = "A small pelt of a rabbit. H3/P0. Requires 2 bones. Pelt. Defender."
	icon_state = "card_rabbit_pelt"
	current_health = 3

/obj/item/card_carp/dpelt
	name = "Deer Pelt"
	desc = "A medium pelt of a deer. H5/P0. Requires 4 bones. Pelt. Defender."
	icon_state = "card_wolf_pelt"
	current_health = 5

/obj/item/card_carp/gpelt
	name = "Gilded Pelt"
	desc = "A gilded pelt, layered in fine gold. H10/P0. Requires 6 bones. Pelt. Defender."
	icon_state = "card_pelt"
	current_health = 10

/obj/item/card_carp/tree
	name = "Tree"
	desc = "A tree, there to hide behind and obstruct. H10/P0. Terrain. Defender."
	icon_state = "card_13"
	current_health = 10

/obj/item/card_carp/rock
	name = "Rock"
	desc = "A rock, the pioneers favorite. H7/P0. Terrain."
	icon_state = "card_child"
	current_health = 7

/obj/random/card_carp/pelt_and_normal_cards
	name = "pelt and normal random card carp"

/obj/random/card_carp/item_to_spawn()
	return pickweight(list(
				/obj/random/card_carp = 20,
				/obj/random/card_carp/pelt = 1,
				))

/obj/random/card_carp
	name = "random card carp"
	icon_state = "techloot-grey"

/obj/random/card_carp/item_to_spawn()
	return pickweight(list(
				/obj/item/card_carp/goat = 1,
				/obj/item/card_carp/crab = 4,
				/obj/item/card_carp/cat = 7,
				/obj/item/card_carp/stote = 11,
				/obj/item/card_carp/stinkbug = 10,
				/obj/item/card_carp/stunted_wolf = 12,
				/obj/item/card_carp/croaker_lord = 13,
				/obj/item/card_carp/wolf = 14,
				/obj/item/card_carp/adder = 5,
				/obj/item/card_carp/manti = 10,
				/obj/item/card_carp/manti_lord = 8,
				/obj/item/card_carp/mole = 10,
				/obj/item/card_carp/mole_man = 7,
				/obj/item/card_carp/coyote = 14,
				/obj/item/card_carp/elk = 12,
				/obj/item/card_carp/magpie = 16,
				/obj/item/card_carp/river_otter = 13,
				/obj/item/card_carp/grizzly = 14,
				/obj/item/card_carp/great_white = 2,
				/obj/item/card_carp/kingfisher = 4,
				/obj/item/card_carp/sparrow = 12,
				/obj/item/card_carp/turkey_vulture = 12,
				/obj/item/card_carp/warren = 12,
				/obj/item/card_carp/rabbit = 10,
				/obj/item/card_carp/bat = 14,
				/obj/item/card_carp/daus = 4,
				/obj/item/card_carp/geck = 9,
				/obj/item/card_carp/larva = 16,
				/obj/item/card_carp/pupa = 10,
				/obj/item/card_carp/mothman = 6,
				/obj/item/card_carp/beaver = 5,
				/obj/item/card_carp/wyrm = 2,
				/obj/item/card_carp/cockroach = 7,
				/obj/item/card_carp/ant = 6,
				/obj/item/card_carp/antqueen = 4,
				/obj/item/card_carp/tree = 4,
				/obj/item/card_carp/rock = 6,
				/obj/item/card_carp/ratking = 6,
				/obj/item/card_carp/packrat = 6,
				/obj/item/card_carp/plaguerat = 10,
				/obj/item/card_carp/kangaroorat = 5,
				/obj/item/card_carp/chipmunk = 12,
				/obj/item/card_carp/fieldmice = 4,
				/obj/item/card_carp/opossum = 7
				))

/obj/random/card_carp/pelt
	name = "random card carp pelt"
	icon_state = "techloot-grey"

/obj/random/card_carp/pelt/item_to_spawn()
	return pickweight(list(
				/obj/item/card_carp/rpelt = 20,
				/obj/item/card_carp/dpelt = 10,
				/obj/item/card_carp/gpelt = 1 //SO RARE
				))

/obj/item/pack_card_carp
	name = "CardCarpCo Pack"
	desc = "For those with disposible income. Contains 5 cards, and a pelt card."
	icon = 'modular_sojourn/cardgame_sprites.dmi'
	icon_state = "card_pack"
	w_class = ITEM_SIZE_TINY

/obj/item/pack_card_carp/attack_self(var/mob/user as mob)
	user.visible_message("[user] rips open \the [src]!")
	var/turf/T = get_turf(src)
	new /obj/random/card_carp(T)
	new /obj/random/card_carp(T)
	new /obj/random/card_carp(T)
	new /obj/random/card_carp(T)
	new /obj/random/card_carp(T)
	new /obj/random/card_carp/pelt(T)

	qdel(src)


/obj/item/scale
	name = "Scale"
	desc = "10 Point Scale, used when talling marks. AltClick to remove a tally, CtrlShiftClick to add a tally"
	icon_state = "scale"
	icon = 'modular_sojourn/cardgame_sprites.dmi'
	var/tally = 0 //Number
	w_class = ITEM_SIZE_SMALL

/obj/item/scale/New()
	..()
	update_icon()

/obj/item/scale/examine(mob/user)
	..()
	to_chat(user, "<span class='info'>The scale reads a tally of : [tally]</span>")

/obj/item/scale/update_icon()
	if(tally >= 5 || -5 >= tally)
		return
	icon_state = "scale_[tally]"

/obj/item/scale/AltClick(mob/user)
	if(-5 >= tally)
		to_chat(user, SPAN_NOTICE("You cant tip the scale any more this way."))
		return
	tally -= 1
	user.visible_message(SPAN_NOTICE("[user] removes a tally form [src] making it [tally]."), SPAN_NOTICE("You remove a tally form \the [src]."))
	update_icon()
	return

/obj/item/scale/CtrlShiftClick(mob/user)
	if(tally >= 5)
		to_chat(user, SPAN_NOTICE("You cant tip the scale any more this way."))
		return
	tally += 1
	user.visible_message(SPAN_NOTICE("[user] adds a tally to into \the [src]."), SPAN_NOTICE("You put a tally into \the [src]."))
	update_icon()
	return
