import spark.servlet.SparkApplication;

import static spark.Spark.get;

public class HelloWorld implements SparkApplication {
	public static void main(String[] args) {
		new HelloWorld().init();
	}

	@Override
	public void init() {
<<<<<<< HEAD
		get("/hello", (req, res) -> "Hello World !!!";
=======
		get("/hello", (req, res) -> "Hello World !!!");
>>>>>>> 4f3560a35395734327275f847e29ba3b20cf5f00
	}
}
