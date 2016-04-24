package helperClasses;

public class TestClass {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		AuthenticationHelper ah = new AuthenticationHelper();
		System.out.println(ah.generateSession("admin"));
		System.out.println(ah.generateSession("admin"));
		System.out.println(ah.generateSession("admin"));
		System.out.println(ah.generateSession("admin"));
		System.out.println(ah.generateSession("admin"));
	}

}
