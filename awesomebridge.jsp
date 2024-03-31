<%@page import="java.util.*"%>
<%@page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Bridge-100m</title>
    
        <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            padding-top: 50px; /* Add space from top */
            position: relative;
            overflow: hidden; /* Hide overflowing stars */
            margin: 0; /* Remove default margin */
            background-image: radial-gradient(circle at center,#2E1A47,#000001); /* Midnight purple */
        color: #fff;
        }

        .button {
            background-color: #4CAF50;
            border: none;
            color: white;
            padding: 15px 30px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 4px 2px;
            cursor: pointer;
            border-radius: 8px;
            transition: background-color 0.3s ease;
            position: relative;
            z-index: 2;
        }
        .button:hover {
            background-color: #45a049;
        }
        .animation {
            animation: slideIn 1s forwards;
        }
        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-100%);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        /* Styling for animal sections */
        .animal-section {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }
        .animal {
            margin: 0 20px;
            font-size: 20px;
            color: #888;
            animation: bounce 1s infinite alternate;
        }
        @keyframes bounce {
            0% { transform: translateY(0); }
            100% { transform: translateY(-10px); }
        }

        /* Starry background */
        #stars {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
        }
        .star {
            position: absolute;
            background-color: #fff;
            border-radius: 50%;
            animation: twinkle 1s infinite alternate, moveStar 20s linear infinite;
        }
        @keyframes twinkle {
            from {
                opacity: 0.8;
            }
            to {
                opacity: 1;
            }
        }
        /* Animation for moving stars */
        @keyframes moveStar {
            from {
                transform: translateY(-5vh);
            }
            to {
                transform: translateY(105vh);
            }
        }
    </style>

<body>
    <h1 class="animation">Bridge of 100m</h1>
    <div class="animation">
        <div class="animal-section">
            <div class="animal">🐘</div>
            <div class="animal">🦌</div>
            <div class="animal">🐢</div>
        </div>
    </div>
    
    <style>
        .Elephant {
            color: grey;
        }
        .Deer {
            color: orange;
        }
        .Turtle {
            color: green;
        }
    </style>
</head>

      
    <% 
        // Initialize the count variable
        int count = 0;
        int total_time_elephant = 0;
        int total_time_deer = 0;
        int total_time_turtle = 0;
        
        // Check if count exists in cookies
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("click_count")) {
                    count = Integer.parseInt(cookie.getValue());
                } else if(cookie.getName().equals("elephant_time")){
                    total_time_elephant += Integer.parseInt(cookie.getValue());
                } else if(cookie.getName().equals("deer_time")){
                    total_time_deer += Integer.parseInt(cookie.getValue());
                } else if(cookie.getName().equals("turtle_time")){
                    total_time_turtle += Integer.parseInt(cookie.getValue()); 
                }
            }
        }

        // Increment count if button is clicked
        if (request.getParameter("click") != null) {
            count++;
            Cookie clickCountCookie = new Cookie("click_count", String.valueOf(count));
            clickCountCookie.setMaxAge(10); // Cookie expires in 1 hour (3600 seconds)
            response.addCookie(clickCountCookie);

            // Randomly select an animal
            Random rm = new Random();
            String[] names = {"Elephant", "Deer", "Turtle"};
            int[] numbers = {5, 3, 30};
            int r = rm.nextInt(names.length);
            String animal = names[r];
            int time = numbers[r];
            if (animal.equals("Elephant")) {
                total_time_elephant += time;
                Cookie elephantTimeCookie = new Cookie("elephant_time", String.valueOf(total_time_elephant));
                elephantTimeCookie.setMaxAge(10); // Cookie expires in 1 hour (3600 seconds)
                response.addCookie(elephantTimeCookie);
            } else if (animal.equals("Deer")) {
                total_time_deer += time;
                Cookie deerTimeCookie = new Cookie("deer_time", String.valueOf(total_time_deer));
                deerTimeCookie.setMaxAge(10); // Cookie expires in 1 hour (3600 seconds)
                response.addCookie(deerTimeCookie);
            } else if (animal.equals("Turtle")) {
                total_time_turtle += time;
                Cookie turtleTimeCookie = new Cookie("turtle_time", String.valueOf(total_time_turtle));
                turtleTimeCookie.setMaxAge(10); // Cookie expires in 1 hour (3600 seconds)
                response.addCookie(turtleTimeCookie);
            }
        %>
        
        
        <!-- Display the selected animal with its time taken -->
        <p>Animal <span class="<%= animal %>"><%= animal %></span> takes <%= time %> minutes to cross</p>
        <% if (count == 5) { %>
        <p>Total time taken by each animal:</p>
        <ul>
            <li>Elephant: <%= total_time_elephant %> minutes</li>
            <li>Deer: <%= total_time_deer %> minutes</li>
            <li>Turtle: <%= total_time_turtle %> minutes</li>
        </ul>
        <% } %>
        <% } %>   
    <form method="post">
        <input type="submit" class="button" name="click" value="Click Me"  <%= count == 5 ? "disabled" : "" %>>
    </form>

    <p class="animation">Button Click Count: <%= count %></p>
     
    
    <!-- Starry background -->
    <div id="stars"></div>
    <script>
        // Add stars to the background
        const numStars = 80; // Number of stars
        const stars = document.getElementById('stars');
        for (let i = 0; i < numStars; i++) {
            const star = document.createElement('div');
            star.className = 'star';
            star.style.top = Math.random() * 100 + '%';
            star.style.left = Math.random() * 100 + '%';
            star.style.width = Math.random() * 5 + 'px'; // Adjust star size
            star.style.height = star.style.width;
            star.style.animationDelay = Math.random() * 5 + 's'; // Random delay for each star
            stars.appendChild(star);
        }
    </script>
    
    
</body>
</html>
