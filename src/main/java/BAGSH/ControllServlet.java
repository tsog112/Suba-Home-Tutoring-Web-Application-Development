package BAGSH;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ControllServlet
 */
@WebServlet(urlPatterns = "*.do", 
initParams = {@WebInitParam(name = "config", value = "/WEB-INF/commandHandler.properties")}
)
@MultipartConfig
public class ControllServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private Map<String, CommandHandler> commandHandlerMap = new HashMap<>();

    public void init(ServletConfig config) throws ServletException {
        String configFile = config.getInitParameter("config");
        Properties prop = new Properties();
        String configFilePath = config.getServletContext().getRealPath(configFile);

        try (FileInputStream fis = new FileInputStream(configFilePath)) {
            prop.load(fis);
        } catch (IOException e) {
            throw new ServletException(e);
        }

        Iterator<Object> keyIter = prop.keySet().iterator();
        while (keyIter.hasNext()) {
            String command = (String) keyIter.next();
            String handlerClassName = prop.getProperty(command);

            try {
                Class<?> handlerClass = Class.forName(handlerClassName);
                CommandHandler handlerInstance = (CommandHandler) handlerClass.newInstance();
                commandHandlerMap.put(command, handlerInstance);
            } catch (ClassNotFoundException | InstantiationException | IllegalAccessException e) {
                throw new ServletException(e);
            }
        }
    }

    public ControllServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            process(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An internal error occurred. Please try again later.");
            request.getRequestDispatcher("error.jsp").forward(request, response); // Ensure you have an error.jsp to handle error messages
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            process(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An internal error occurred. Please try again later.");
            request.getRequestDispatcher("error.jsp").forward(request, response); // Ensure you have an error.jsp to handle error messages
        }
    }

    private void process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String command = request.getRequestURI();
        if (command == null) {
            throw new ServletException("Invalid command.");
        }

        command = command.substring(request.getContextPath().length() + 1);

        CommandHandler handler = commandHandlerMap.get(command);
        if (handler == null) {
            throw new ServletException("No handler found for command: " + command);
        }

        String viewPage = handler.porcess(request, response);
        if (viewPage != null) {
            RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage + ".jsp");
            dispatcher.forward(request, response);
        }
    }
}
