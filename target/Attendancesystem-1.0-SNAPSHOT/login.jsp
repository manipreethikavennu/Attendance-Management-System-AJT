<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login | College Attendance System</title>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@600;700&family=Rajdhani:wght@500;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Rajdhani', sans-serif;
            background: #0B0813;
            background-image: radial-gradient(at 30% 20%, rgba(147, 51, 234, 0.25) 0px, transparent 50%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #E2E8F0;
            margin: 0;
        }
        .login-box {
            width: 100%;
            max-width: 400px;
            background: rgba(22, 16, 38, 0.85);
            padding: 36px 28px;
            border-radius: 18px;
            border: 1px solid rgba(168, 85, 247, 0.35);
            box-shadow: 0 0 30px rgba(147, 51, 234, 0.25);
        }
        h2 {
            font-family: 'Orbitron', sans-serif;
            text-align: center;
            color: #D8B4FE;
            margin-bottom: 24px;
            letter-spacing: 2px;
        }
        label {
            display: block;
            margin-top: 14px;
            color: #D8B4FE;
            font-weight: 600;
            text-transform: uppercase;
        }
        input {
            width: 100%;
            padding: 12px;
            margin-top: 6px;
            background: #0C0916;
            border: 1px solid rgba(168, 85, 247, 0.4);
            border-radius: 8px;
            color: #F3E8FF;
            font-size: 1rem;
            box-sizing: border-box;
        }
        button {
            width: 100%;
            padding: 13px;
            margin-top: 24px;
            background: linear-gradient(135deg, #7E22CE, #A855F7);
            color: #FFF;
            font-family: 'Orbitron', sans-serif;
            font-weight: 700;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            letter-spacing: 1.5px;
        }
        .error {
            color: #F87171;
            background: rgba(239, 68, 68, 0.15);
            border: 1px solid #EF4444;
            padding: 10px;
            border-radius: 8px;
            text-align: center;
            margin-bottom: 14px;
        }
    </style>
</head>
<body>
<div class="login-box">
    <h2>SYSTEM LOGIN</h2>
    <% if (request.getAttribute("error") != null) { %>
        <div class="error"><%= request.getAttribute("error") %></div>
    <% } %>
    <form action="login" method="POST">
        <label>Username</label>
        <input type="text" name="username" placeholder="Enter username" required />
        <label>Password</label>
        <input type="password" name="password" placeholder="Enter password" required />
        <button type="submit">ACCESS PORTAL</button>
    </form>
</div>
</body>
</html>