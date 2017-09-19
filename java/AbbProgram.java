package abb;

import abb.ABB;

public class AbbProgram {
	
	private static final String USAGE = "Usage: test command \n"
	+ "Commands must be of the form \"i 3 5 1 e 3 i 4\" "
	+ "with i representing insertions and e erasures. "
	+ "If unspecified, insertions are asummed by default.";
	
	public static void usage() {
		System.err.println(USAGE);
		System.exit(1);
	}
	
	public static void main(String[] args) {
		ABB<Integer> abb = new ABB<Integer>();
		boolean erase = false;
		
		for(String a : args) {
			switch (a) {
			case "i": // insert
				erase = false;
				break;
			case "e": // erase
				erase = true;
				break;
			default:
				try {
					Integer i = Integer.parseInt(a);
					if(erase)
						abb.eliminarClave(i);
					else
						abb.insertarClave(i);
				} catch (NumberFormatException e) {
					System.err.println("Unrecognized input");
					usage();
				}
				break;
			}
		}
		
		System.out.println(abb);
	}
}
