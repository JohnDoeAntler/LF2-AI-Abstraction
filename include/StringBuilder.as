#include "Utils.as";
#include "Stringifiable.as";

class StringBuilder: IStringifiable {

	private string str = "";
	private string sep = "";

	private bool isEmpty () {
		return str.length() == 0;
	}

	StringBuilder@ setSeparator (string sep) {
		this.sep = sep;
		return @this;
	}

	StringBuilder@ insert (int value) {
		if (isEmpty()) {
			str = value + str;
		} else {
			str = value + sep + str;
		}
		return @this;
	}

	StringBuilder@ insert (float value) {
		if (isEmpty()) {
			str = value + str;
		} else {
			str = value + sep + str;
		}
		return @this;
	}

	StringBuilder@ insert (double value) {
		if (isEmpty()) {
			str = value + str;
		} else {
			str = value + sep + str;
		}
		return @this;
	}

	StringBuilder@ insert (string value) {
		if (isEmpty()) {
			str = value + str;
		} else {
			str = value + sep + str;
		}
		return @this;
	}

	StringBuilder@ insert (bool value) {
		if (isEmpty()) {
			str = value + str;
		} else {
			str = value + sep + str;
		}
		return @this;
	}

	StringBuilder@ insert (IStringifiable@ value) {
		if (isEmpty()) {
			str = value.toString() + str;
		} else {
			str = value.toString() + sep + str;
		}
		return @this;
	}

	StringBuilder@ append (int value) {
		if (isEmpty()) {
			str += value;
		} else {
			str += sep + value;
		}
		return @this;
	}

	StringBuilder@ append (float value) {
		if (isEmpty()) {
			str += value;
		} else {
			str += sep + value;
		}
		return @this;
	}

	StringBuilder@ append (double value) {
		if (isEmpty()) {
			str += value;
		} else {
			str += sep + value;
		}
		return @this;
	}

	StringBuilder@ append (string value) {
		if (isEmpty()) {
			str += value;
		} else {
			str += sep + value;
		}
		return @this;
	}

	StringBuilder@ append (bool value) {
		if (isEmpty()) {
			str += value;
		} else {
			str += sep + value;
		}
		return @this;
	}

	StringBuilder@ append (IStringifiable@ value) {
		if (isEmpty()) {
			str += value.toString();
		} else {
			str += sep + value.toString();
		}
		return @this;
	}

	StringBuilder@ kv (string key, int value) {
		if (isEmpty()) {
			str += key + ": " + value;
		} else {
			str += sep + key + ": " + value;
		}
		return @this;
	}

	StringBuilder@ kv (string key, float value) {
		if (isEmpty()) {
			str += key + ": " + value;
		} else {
			str += sep + key + ": " + value;
		}
		return @this;
	}

	StringBuilder@ kv (string key, double value) {
		if (isEmpty()) {
			str += key + ": " + value;
		} else {
			str += sep + key + ": " + value;
		}
		return @this;
	}

	StringBuilder@ kv (string key, string value) {
		if (isEmpty()) {
			str += key + ": " + value;
		} else {
			str += sep + key + ": " + value;
		}
		return @this;
	}

	StringBuilder@ kv (string key, bool value) {
		if (isEmpty()) {
			str += key + ": " + value;
		} else {
			str += sep + key + ": " + value;
		}
		return @this;
	}

	StringBuilder@ kv (string key, IStringifiable@ value) {
		if (isEmpty()) {
			str += key + ": " + value.toString();
		} else {
			str += sep + key + ": " + value.toString();
		}
		return @this;
	}

	StringBuilder@ surround () {
		str = "[ " + str + " ]";
		return @this;
	}

	string build () {
		return this.str;
	}

	string toString () {
		return this.str;
	}

}