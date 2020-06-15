interface IStringifiable {

	string toString();

}

mixin class Stringifiable : Stringifiable {

	string toString () {
		return "";
	}

}