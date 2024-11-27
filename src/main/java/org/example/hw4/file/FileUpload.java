package org.example.hw4.file;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.HashMap;
import java.util.Map;

public class FileUpload {
    public static Map<String, String> uploadFile(HttpServletRequest request) throws Exception {
        String uploadPath = request.getServletContext().getRealPath("/uploads");
        File uploadDir = new File(uploadPath);

        if (!uploadDir.exists()) {
            boolean created = uploadDir.mkdirs();
            if (!created) {
                throw new RuntimeException("Failed to create uploads directory: " + uploadPath);
            }
        }

        // 파일 업로드 처리
        MultipartRequest multi = new MultipartRequest(
                request,
                uploadPath,
                10 * 1024 * 1024, // 10MB
                "UTF-8",
                new DefaultFileRenamePolicy()
        );

        // 텍스트 데이터 및 파일 정보 저장
        Map<String, String> formData = new HashMap<>();
        formData.put("title", multi.getParameter("title"));
        formData.put("writer", multi.getParameter("writer"));
        formData.put("content", multi.getParameter("content"));
        formData.put("score", multi.getParameter("score"));

        String fileName = multi.getFilesystemName("photo");
        if (fileName != null) {
            formData.put("filePath", "uploads/" + fileName); // 파일 경로
        } else {
            formData.put("filePath", null);
        }

        return formData; // 폼 데이터 및 파일 경로 반환
    }
}
