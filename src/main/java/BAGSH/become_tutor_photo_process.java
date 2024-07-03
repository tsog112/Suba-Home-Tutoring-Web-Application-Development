package BAGSH;

import java.io.File;
import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class become_tutor_photo_process implements CommandHandler {

	@Override
	public String porcess(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String saveDirectory = "C:/upload"; // You can change this to your desired directory
        int maxPostSize = 10 * 1024 * 1024; // 10MB
        String encoding = "UTF-8";

        // Ensure the directory exists
        File uploadDir = new File(saveDirectory);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        try {
            MultipartRequest multi = new MultipartRequest(request, saveDirectory, maxPostSize, encoding, new DefaultFileRenamePolicy());

            File file = multi.getFile("photo");
            if (file != null) {
                String photoPath = file.getAbsolutePath();
                request.getSession().setAttribute("photoPath", photoPath);
            }
        } catch (IOException e) {
            e.printStackTrace();
            request.setAttribute("error", "File upload failed: " + e.getMessage());
            return "become_tutor_photo"; // Return to the photo upload page with error
        }

        return "become_tutor_description"; // Redirect to the next step in the tutor registration process
    }
}
