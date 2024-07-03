package BAGSH;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface CommandHandler {
	public String porcess(HttpServletRequest request, HttpServletResponse response)
	throws Exception;
}
