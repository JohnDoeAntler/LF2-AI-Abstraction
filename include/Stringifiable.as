interface IStringifiable {

	string toString();

}

mixin class Stringifiable {

	string toString () {
		return "";
	}

}