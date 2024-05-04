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
			scrText("I'm not a child! I'm a whole six years old!", "ScyllaSassy");
			scrText("...", "CatectiveDefault", -1);
			scrText("Definitely a child...", "CatectiveSad", -1);
			break;
	}
}