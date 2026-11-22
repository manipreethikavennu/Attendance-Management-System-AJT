<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Protect page: redirect to login if user is not authenticated
    if (session.getAttribute("loggedUser") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>College Attendance Management System</title>
    <!-- Futuristic Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@500;700;900&family=Rajdhani:wght@500;600;700&display=swap" rel="stylesheet">
    
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Rajdhani', sans-serif;
            background: #0B0813;
            background-image: 
                radial-gradient(at 20% 20%, rgba(147, 51, 234, 0.25) 0px, transparent 50%),
                radial-gradient(at 80% 80%, rgba(79, 70, 229, 0.25) 0px, transparent 50%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #E2E8F0;
            padding: 20px;
        }

        .container {
            width: 100%;
            max-width: 460px;
            background: rgba(22, 16, 38, 0.75);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            padding: 32px 30px 40px 30px;
            border-radius: 20px;
            border: 1px solid rgba(168, 85, 247, 0.3);
            box-shadow: 0 0 35px rgba(147, 51, 234, 0.2),
                        inset 0 0 15px rgba(168, 85, 247, 0.1);
            position: relative;
        }

        /* Top decorative glowing bar */
        .container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 20%;
            right: 20%;
            height: 3px;
            background: linear-gradient(90deg, transparent, #A855F7, #EC4899, transparent);
            box-shadow: 0 0 12px #A855F7;
        }

        /* Top User Bar */
        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 18px;
            padding-bottom: 10px;
            border-bottom: 1px solid rgba(168, 85, 247, 0.25);
            font-size: 0.95rem;
        }

        .user-badge {
            color: #C084FC;
            font-weight: 600;
        }

        .logout-link {
            color: #F87171;
            text-decoration: none;
            font-weight: 700;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 1px;
        }

        .logout-link:hover {
            text-decoration: underline;
        }

        h2 {
            font-family: 'Orbitron', sans-serif;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 2px;
            text-align: center;
            background: linear-gradient(135deg, #F3E8FF 0%, #C084FC 50%, #A855F7 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 24px;
            font-size: 1.6rem;
            text-shadow: 0 0 20px rgba(168, 85, 247, 0.4);
        }

        label {
            font-size: 1.05rem;
            font-weight: 600;
            letter-spacing: 1px;
            display: block;
            margin-top: 18px;
            color: #D8B4FE;
            text-transform: uppercase;
        }

        input, select {
            width: 100%;
            padding: 12px 16px;
            margin-top: 8px;
            background: rgba(12, 9, 22, 0.8);
            border: 1px solid rgba(168, 85, 247, 0.3);
            border-radius: 10px;
            color: #F3E8FF;
            font-family: 'Rajdhani', sans-serif;
            font-size: 1.1rem;
            font-weight: 600;
            outline: none;
            transition: all 0.3s ease;
        }

        input:focus, select:focus {
            border-color: #C084FC;
            box-shadow: 0 0 15px rgba(192, 132, 252, 0.4);
            background: rgba(18, 12, 34, 0.9);
        }

        select option {
            background-color: #161026;
            color: #F3E8FF;
        }

        input[type="date"]::-webkit-calendar-picker-indicator {
            filter: invert(0.8) sepia(1) saturate(5) hue-rotate(220deg);
            cursor: pointer;
        }

        button {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #7E22CE 0%, #9333EA 50%, #C084FC 100%);
            color: #FFFFFF;
            font-family: 'Orbitron', sans-serif;
            font-weight: 700;
            font-size: 1rem;
            letter-spacing: 2px;
            text-transform: uppercase;
            border: none;
            border-radius: 10px;
            margin-top: 30px;
            cursor: pointer;
            box-shadow: 0 0 20px rgba(147, 51, 234, 0.5);
            transition: all 0.3s ease;
        }

        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 0 30px rgba(168, 85, 247, 0.8);
            background: linear-gradient(135deg, #9333EA 0%, #A855F7 50%, #E879F9 100%);
        }

        button:active {
            transform: translateY(1px);
        }

        .alert-success {
            color: #4ADE80;
            background: rgba(34, 197, 94, 0.15);
            border: 1px solid rgba(74, 222, 128, 0.4);
            padding: 12px;
            border-radius: 10px;
            margin-bottom: 20px;
            text-align: center;
            font-weight: 600;
            letter-spacing: 0.5px;
            box-shadow: 0 0 15px rgba(34, 197, 94, 0.2);
        }

        .alert-error {
            color: #F87171;
            background: rgba(239, 68, 68, 0.15);
            border: 1px solid rgba(248, 113, 113, 0.4);
            padding: 12px;
            border-radius: 10px;
            margin-bottom: 20px;
            text-align: center;
            font-weight: 600;
            letter-spacing: 0.5px;
            box-shadow: 0 0 15px rgba(239, 68, 68, 0.2);
        }

        .nav-footer {
            margin-top: 20px;
            text-align: center;
        }

        .nav-footer a {
            color: #C084FC;
            text-decoration: none;
            font-weight: 600;
            font-size: 1rem;
            letter-spacing: 0.5px;
        }

        .nav-footer a:hover {
            color: #F3E8FF;
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="top-bar">
        <span class="user-badge">User: <%= session.getAttribute("loggedUser") %></span>
        <a href="logout" class="logout-link">Logout</a>
    </div>

    <h2>Mark Attendance</h2>

    <!-- Display Feedback Messages -->
    <% if (request.getAttribute("message") != null) { %>
        <div class="alert-success"><%= request.getAttribute("message") %></div>
    <% } %>

    <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="alert-error"><%= request.getAttribute("errorMessage") %></div>
    <% } %>

    <form action="markattendance" method="POST">
        <label for="studentId">Student ID</label>
        <input type="number" id="studentId" name="studentId" placeholder="e.g. 1" required />

        <label for="courseId">Course ID</label>
        <input type="number" id="courseId" name="courseId" placeholder="e.g. 101" required />

        <label for="status">Attendance Status</label>
        <select id="status" name="status">
            <option value="Present">Present</option>
            <option value="Absent">Absent</option>
        </select>

        <label for="date">Date</label>
        <input type="date" id="date" name="date" required />

        <button type="submit">Submit Record</button>
    </form>

    <div class="nav-footer">
        <a href="viewattendance">View All Attendance Records &rarr;</a>
    </div>
</div>

</body>
</html>