package BAGSH;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class become_tutor_availability_process implements CommandHandler {

	@Override
	public String porcess(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String[] days = {"monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"};
        Map<String, List<String>> availability = new HashMap<>();

        for (String day : days) {
            String[] fromTimes = request.getParameterValues(day + "_from[]");
            String[] toTimes = request.getParameterValues(day + "_to[]");

            List<String> times = new ArrayList<>();
            if (fromTimes != null && toTimes != null) {
                for (int i = 0; i < fromTimes.length; i++) {
                    times.add(fromTimes[i] + "-" + toTimes[i]);
                }
            }
            if (!times.isEmpty()) {
                availability.put(day, times);
            }
        }

        request.getSession().setAttribute("availability", availability);

        return "become_tutor_pricing"; // Redirect to the next step in the tutor registration process
    }
}