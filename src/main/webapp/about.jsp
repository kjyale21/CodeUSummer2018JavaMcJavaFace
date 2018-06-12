<%--
  Copyright 2017 Google Inc.

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
--%>
<!DOCTYPE html>
<html>
<head>
  <title>CodeU Chat App</title>
  <link rel="stylesheet" href="/css/main.css">
</head>
<body>

  <nav>
    <a id="navTitle" href="/">CodeU Chat App</a>
    <a href="/conversations">Conversations</a>
    <% if(request.getSession().getAttribute("user") != null){ %>
      <a>Hello <%= request.getSession().getAttribute("user") %>!</a>
    <% } else{ %>
      <a href="/login">Login</a>
    <% } %>
    <a href="/about.jsp">About</a>
    <a href="/activityfeed">Activity</a>
    <% if(request.getSession().getAttribute("user") != null){ %>
       <a href="/admin">Admin</a>
    <% } else{ %>
      <h1></h1>
      <% } %>
    <% if(request.getSession().getAttribute("user") != null){ %>
       <a href="/profilepage">Profile</a>
    <% } else{ %>
      <h1></h1>
      <% } %>
    <% if(request.getSession().getAttribute("user") != null){ %>
       <a href="/logout">Logout</a>
    <% } else{ %>
      <h1></h1>
      <% } %>
  </nav>

  <div id="container">
    <div
      style="width:75%; margin-left:auto; margin-right:auto; margin-top: 50px;">

      <h1>About the CodeU Chat App</h1>
      <p>
        This is an example chat application designed to be a starting point
        for your CodeU project team work. Here's some stuff to think about:
      </p>

      <ul>
        <li><strong>Algorithms and data structures:</strong> We've made the app
            and the code as simple as possible. You will have to extend the
            existing data structures to support your enhancements to the app,
            and also make changes for performance and scalability as your app
            increases in complexity.</li>
        <li><strong>Look and feel:</strong> The focus of CodeU is on the Java
          side of things, but if you're particularly interested you might use
          HTML, CSS, and JavaScript to make the chat app prettier.</li>
        <li><strong>Customization:</strong> Think about a group you care about.
          What needs do they have? How could you help? Think about technical
          requirements, privacy concerns, and accessibility and
          internationalization.</li>
      </ul>

      <p>
        This is your code now. Get familiar with it and get comfortable
        working with your team to plan and make changes. Start by updating the
        homepage and this about page to tell your users more about your team.
        This page should also be used to describe the features and improvements
        you've added.
      </p>

      <h1>About the Team</h1>
      <p>We are Team 27! In other words javaMcJavaFace. Here's a little info about each one of us:
      </p>
      <ul>
        <li><strong>Deniz Kecik:</strong> I am a 2nd year Computer Science student at University of Pennsylvania.
        I'm from Istanbul, Turkey, one of the best cities in the world. I love traveling and trying out new food,
        restaurants, meeting new people, anything new in general. Additionally, I am very outdoorsy and love playing
        Tennis, Basketball and Soccer. My favorite shows are The Office and Game of Thrones. Fun fact about me: my
        name in Turkish means the sea, and in honor of my name, I also love windsurfing and sailing. So basically,
        I'm always looking forward to the summer!
        </li>
        <li><strong>Felipe Campos:</strong> I'm a sophomore studying Electrical Engineering & Computer Science
        with a concentration in either Economics or Physics at the University of California, Berkeley. I was born in LA
        but grew up mainly in Brazil (where my family is originally from) and San Francisco, before moving to Madison,
        Wisconsin and now recently Richmond, Virginia. I enjoy running, hanging out in nature, playing basketball
        and tennis, listening to podcasts, and stargazing. Some other stuff: my favorite shows are Archer and the
        Eric Andre Show, my favorite artists are Anderson .Paak, Brockhampton, Childish Gambino, and Isaiah Rashad.
        Additionally, I love anything to do with space and astrophysics and I also think fractals (mandelbrot,
        julia sets, iterated function systems) are just the coolest things.
        </li>
        <li><strong>Kahlil Greene:</strong> My name is Kahlil (pronounced Kuh-leel) Greene. I was born and raised right
        outside of Washington DC, in a place called Montgomery County, Maryland. Fun fact: the rappers Wale and Logic
        were both raised there too. At Yale, I am double-majoring in Computer Science and Economics. For fun, I like
        to draw, dance, watch movies, and rap. I am involved in student government, nonprofit work, and finance groups
        on campus.
        </li>
        <li><strong>Yvonne Sanders:</strong> I am a 2nd year Computer Information Systems and Graphic Design double
        major at Hampton University in Hampton Virginia. I am from Raleigh, NC. I am on flagline in the band at my
        school and I am in a hip hop dance troupe called majestic. As you can tell I love to dance and performance
        I am a musical theatre buff and I love fashion.
        </li>
      </ul>

      <h1>Our Progress</h1>
      <p>Here's a quick summary of our progress so far:
      </p>
      <ul>
        <li><strong>Week 1 - Prototyping:</strong> This week we had our first team meeting
        and assigned roles for developing basic prototypes for several features of the web chat app.
        Felipe is working on the Activity Feed, Kahlil is working on the Admin Page, Yvonne is working on
        Style Text, and Deniz is working on the Profile Pages.</li>
      </ul>
    </div>
  </div>
</body>
</html>
