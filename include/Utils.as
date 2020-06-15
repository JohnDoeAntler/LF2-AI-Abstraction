#include "Stringifiable.as";

string println (string str) {
	print (str + "\n");
	return str;
}

string println () { return println(""); }
string println (int str) { return println("" + str); }
string println (float str) { return println("" + str); }
string println (double str) { return println("" + str); }
string println (bool str) { return println(str ? "true" : "false"); }
string println (IStringifiable@ str) { return println(str.toString()); }

void print (IStringifiable@ str) { print(str.toString()); }