package BAGSH;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class index implements CommandHandler
{

	@Override
	public String porcess(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "index";
	}

}
