package com.college.servlet;

import com.college.dao.AttendanceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/markattendance")
public class AttendanceServlet extends HttpServlet {

    private final AttendanceDAO attendanceDAO = new AttendanceDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String studentIdStr = request.getParameter("studentId");
        String courseIdStr = request.getParameter("courseId");
        String status = request.getParameter("status");
        String date = request.getParameter("date");

        // Basic validation for missing inputs
        if (studentIdStr == null || courseIdStr == null || date == null || status == null 
                || studentIdStr.isBlank() || courseIdStr.isBlank() || date.isBlank()) {
            request.setAttribute("errorMessage", "All fields are required.");
            request.getRequestDispatcher("mark_attendance.jsp").forward(request, response);
            return;
        }

        try {
            int studentId = Integer.parseInt(studentIdStr);
            int courseId = Integer.parseInt(courseIdStr);

            // Validate against XAMPP MySQL database records
            if (!attendanceDAO.isValidStudent(studentId)) {
                request.setAttribute("errorMessage", "Student ID " + studentId + " does not exist.");
            } else if (!attendanceDAO.isValidCourse(courseId)) {
                request.setAttribute("errorMessage", "Course ID " + courseId + " does not exist.");
            } else {
                boolean saved = attendanceDAO.saveAttendance(studentId, courseId, status, date);
                if (saved) {
                    request.setAttribute("message", "Attendance marked successfully!");
                } else {
                    request.setAttribute("errorMessage", "Database error occurred while saving.");
                }
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Student ID and Course ID must be numbers.");
        } catch (Exception e) {
            request.setAttribute("errorMessage", "An unexpected error occurred: " + e.getMessage());
        }

        // Return back to the form page with response attributes
        request.getRequestDispatcher("mark_attendance.jsp").forward(request, response);
    }
}
