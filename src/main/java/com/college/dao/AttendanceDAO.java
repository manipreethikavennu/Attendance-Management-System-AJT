package com.college.dao;

import com.college.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class AttendanceDAO {

    // Check if the student ID exists in the users table
    public boolean isValidStudent(int studentId) {
        boolean exists = false;
        String sql = "SELECT id FROM users WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                exists = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return exists;
    }

    // Check if the course ID exists in the courses table
    public boolean isValidCourse(int courseId) {
        boolean exists = false;
        String sql = "SELECT id FROM courses WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, courseId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                exists = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return exists;
    }

    // CREATE: Insert attendance record into MySQL
    public boolean saveAttendance(int studentId, int courseId, String status, String date) {
        String sql = "INSERT INTO attendance (student_id, course_id, status, attendance_date) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, studentId);
            ps.setInt(2, courseId);
            ps.setString(3, status);
            ps.setString(4, date);
            
            int rowsInserted = ps.executeUpdate();
            return rowsInserted > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // READ: Fetch all attendance records with Student Name and Course Name
    public List<String[]> getAllAttendanceRecords() {
        List<String[]> records = new ArrayList<>();
        String sql = "SELECT a.id, u.name AS student_name, c.course_name, a.status, a.attendance_date " +
                     "FROM attendance a " +
                     "JOIN users u ON a.student_id = u.id " +
                     "JOIN courses c ON a.course_id = c.id " +
                     "ORDER BY a.attendance_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                String[] row = new String[5];
                row[0] = String.valueOf(rs.getInt("id"));
                row[1] = rs.getString("student_name");
                row[2] = rs.getString("course_name");
                row[3] = rs.getString("status");
                row[4] = rs.getString("attendance_date");
                records.add(row);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return records;
    }

    // UPDATE: Modify attendance status for a record ID
    public boolean updateAttendanceStatus(int recordId, String newStatus) {
        String sql = "UPDATE attendance SET status = ? WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, newStatus);
            ps.setInt(2, recordId);
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // DELETE: Remove an attendance record by ID
    public boolean deleteAttendanceRecord(int recordId) {
        String sql = "DELETE FROM attendance WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, recordId);
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
