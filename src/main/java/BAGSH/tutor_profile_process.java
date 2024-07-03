package BAGSH;



import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.json.JSONObject;

public class tutor_profile_process implements CommandHandler {

	@Override
	public String porcess(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String tutorId = request.getParameter("tutorId");
        TutorProfile tutorProfile = new TutorProfile(tutorId);

        JSONObject tutorDetails = tutorProfile.getTutorDetails();

        if (tutorDetails != null && !tutorDetails.isEmpty()) {
            String profilePicBase64 = tutorDetails.optString("profilePicture", "");
            if (!profilePicBase64.isEmpty()) {
                String profilePicDataUrl = "data:image/png;base64," + profilePicBase64;
                request.setAttribute("profilePicture", profilePicDataUrl);
            } else {
                request.setAttribute("profilePicture", "path/to/default_profile_picture.png");
            }
            request.setAttribute("fullName", tutorDetails.optString("fullName", "N/A"));
            request.setAttribute("catchyTitle", tutorDetails.optString("catchyTitle", "N/A"));
            request.setAttribute("subjects", "Subjects the tutor teaches");
            request.setAttribute("experienceYears", tutorDetails.optInt("experienceYears", 0));
            request.setAttribute("lessonsTaught", tutorDetails.optInt("lessonsTaught", 0));
            request.setAttribute("averageRating", tutorDetails.optDouble("averageRating", 0));
            request.setAttribute("reviewCount", tutorDetails.optInt("reviewCount", 0));
            request.setAttribute("hourlyRate", tutorDetails.optDouble("hourlyRate", 0));
            request.setAttribute("introduction", tutorDetails.optString("introduction", "N/A"));
            request.setAttribute("schedules", tutorDetails.getJSONArray("schedules"));
            request.setAttribute("reviews", tutorDetails.getJSONArray("reviews"));
            request.setAttribute("education", tutorDetails.getJSONArray("education"));
            request.setAttribute("ratingSummary", tutorDetails.getJSONObject("ratingSummary"));
        } else {
            System.out.println("Tutor details not found for ID: " + tutorId);
        }

        return "tutor_profile";
    }
}