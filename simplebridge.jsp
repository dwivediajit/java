<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Bridge-100m</title>

</head>
<body>
      
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
                }else if(cookie.getName().equals("elephant_time")){
                    total_time_elephant += Integer.parseInt(cookie.getValue());
                }else if(cookie.getName().equals("deer_time")){
                    total_time_deer += Integer.parseInt(cookie.getValue());
                }else if(cookie.getName().equals("turtle_time")){
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

            %><p>Bridge of 100m</p><%
            
         //random number
         Random rm =new Random();
         String[] names = {"elephant", "deer", "turtle"};
         int[] numbers = {5, 3, 30};
         int r = rm.nextInt(names.length);
         String animal=names[r];
         int time=numbers[r];
         if (animal.equals("elephant")) {
                total_time_elephant += time;
                Cookie elephantTimeCookie = new Cookie("elephant_time", String.valueOf(total_time_elephant));
                elephantTimeCookie.setMaxAge(10); // Cookie expires in 1 hour (3600 seconds)
                response.addCookie(elephantTimeCookie);
            } else if (animal.equals("deer")) {
                total_time_deer += time;
                Cookie heranTimeCookie = new Cookie("deer_time", String.valueOf(total_time_deer));
                heranTimeCookie.setMaxAge(10); // Cookie expires in 1 hour (3600 seconds)
                response.addCookie(heranTimeCookie);
            } else if (animal.equals("turtle")) {
                total_time_turtle += time;
                Cookie turtleTimeCookie = new Cookie("turtle_time", String.valueOf(total_time_turtle));
                turtleTimeCookie.setMaxAge(10); // Cookie expires in 1 hour (3600 seconds)
                response.addCookie(turtleTimeCookie);
            }
         %>
         <p>Animal <%= animal %>  time take--<%= time %>min</p>
         <% if (count==5){
         %><p>Total time taken by each animal:</p>
        <ul>
            <li>Elephant: <%= total_time_elephant %> minutes</li>
            <li>deer: <%= total_time_deer %> minutes</li>
            <li>Turtle: <%= total_time_turtle %> minutes</li>
        </ul><%
         }
        }    
    %>
    <form method="post">
        <input type="submit" name="click" value="Click Me"  <%= count == 5 ? "disabled" : "" %>>
    </form>

    <p>Button Click Count: <%= count %></p>
</body>
</html>
