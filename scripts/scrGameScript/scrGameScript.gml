/// @param textID

function scrGameScript(_text_id) {
	switch(_text_id) {
		case "Sign1":
			scrText("Oh! There's a sign here!", "ScyllaHappy" );
				scrTextColor(14, 18, c_purple, c_purple, c_purple, c_purple);
				scrTextFloat(14, 18);
			scrText("Oh! There's a sign here!", "ScyllaHappy");
				scrTextColor(14, 18, c_purple, c_purple, c_purple, c_purple);
				scrTextShake(14, 18);
			scrText("Oh! There's a sign here!", "ScyllaHappy");
				scrTextColor(14, 18, c_purple, c_purple, c_purple, c_purple);
				scrTextFloat(1, 24);
			scrText("Oh! There's a sign here...?", "ScyllaHappy");
				scrTextColor(14, 18, c_purple, c_purple, c_purple, c_purple);
			scrText("Why am I talking like that...?", "ScyllaDefault");
			scrText("...I'm started to get concerned...", "ScyllaScared");
			scrOption("There is no need to feel concered here.", "NoConcern");
			scrOption("Be very concered...", "Concern");
			break;
		case "NoConcern":
			scrText("There is no need to feel concerned.", "ScyllaDefault");
			scrText("Everything is okay!", "ScyllaHappy");
			scrText("Everything is okay.", "ScyllaSad");
			break;
		case "Concern":
			scrText("Of course I'm worried.", "ScyllaScared");
			scrText("Any fish girl would be in this situation, right?", "ScyllaScared");
			break;
			
		case "Sign2":
			scrText("...Another lonely sign...", "ScyllaDefault");
			scrTextShake(0, 25);
			scrText("Daddy told me all about signs. There are a ton of them in Mallard Nature Park back in the city.", "ScyllaDefault");
			scrText("A sign is an object, quality, event, or entity whose presence or occurrence indicates the probable presence or occurrence of something else.", "ScyllaSassy");
			scrText("A natural sign bears a causal relation to its object—for instance, thunder is a sign of storm, or medical symptoms a sign of disease.", "ScyllaSassy");
			scrText("A conventional sign signifies by agreement, as a full stop signifies the end of a sentence.", "ScyllaSassy");
			scrText("Similarly, the words and expressions of a language, as well as bodily gestures can be regarded as signs, expressing particular meanings.", "ScyllaSassy");
			scrText("...", "ScyllaDefault");
			scrText("Now that I look closer...the signs here don't have anything written on them?", "ScyllaDefault");
			scrText("Wouldn't they just be post at this point...?", "ScyllaDefault");
			scrText("...I miss home...", "ScyllaSad");
			break;
			
		case "Sign3":
			scrText("...");
			scrText("Just a lonely sign.");
			break;
			
		case "Catective1":
			scrText("...", "CatectiveDefault", -1);
			scrText("A child?", "CatectiveDefault", -1);
			scrTextFloat(0, 8);
			scrText("I'm not a child! I'm a whole six years old!", "ScyllaSassy");
			scrText("...", "CatectiveDefault", -1);
			scrText("Definitely a child...", "CatectiveSad", -1);
			scrTextShake(0, 21);
			break;
			
		case "Catective2":
			scrText("How will you find your way through this, Child?", "CatectiveDefault", -1);
			scrText("My name isn't CHILD, it's SCYLLA!", "ScyllaSassy"); // Change to Scylla mad at some point.
			scrTextShake(14, 19);
			scrTextFloat(26, 34);
			scrText("...regardless...", "CatectiveSad", -1);
			scrTextShake(0, 14);
			scrText("You are hopelessly stuck here with no way to advance.", "CatectiveDefault", -1);
			scrText("That's true...", "ScyllaSad");
			scrText("...", "ScyllaDefault");
			scrText("Just wait until Rozw finishes programming semi-solid moving platforms and walls! I'll be over there in no time flat! Right?", "ScyllaHappy"); //Rozw is Polish for Dev, thought that was cool or some shit.
			scrTextFloat(0, 126);
			scrText("...right...?", "ScyllaSad");
			scrTextShake(0, 12);
			scrText("You don't know that which you ask, fishy one...", "CatectiveDefault",-1);
			scrTextShake(30, 33);
			break;
		case "Catective3":
			scrText("...", "CatectiveDefault", -1);
			scrText("You made it here, but that doesn't mean I'm going to congratulate you for the hard work Rozw did to get you here.", "CatectiveDefault", -1);
			scrTextShake(66, 69);
			scrTextShake(88, 91);
			scrTextFloat(78, 87);
			break;
		case "Catective4":
			scrText("...", "CatectiveDefault", -1);
			scrText("That platform is far too high for you to reach, fishy one.", "CatectiveDefault", -1);
			scrText("What will you do?", "CatectiveDefault", -1);
			scrTextShake(0, 18);
			scrText("It is impossible.", "CatectiveDefault", -1);
			break;
		case "Sign4":
		scrText("DO NOT TRUST THE CAT.");
		scrText("THE CHEST HOLD THE KEYS.");
		break;
	}
}