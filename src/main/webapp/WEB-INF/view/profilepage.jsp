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
  <title>Profile Page</title>
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
  </nav>
  <div id="container">
    <div
      style="width:75%; margin-left:auto; margin-right:auto; margin-top: 50px;">
      <% if(request.getSession().getAttribute("user") == null){ %>
        Please <a href="/login">login</a> to see your profile page!
      <% } else{ %>
        <h1><%= request.getSession().getAttribute("user") %>'s Profile Page</h1>
        <p>
          <h4>About <%= request.getSession().getAttribute("user") %></h4>
            <% if (request.getSession().getAttribute("message") == null) { %>
              Write a bio below!
            <% } else{ %>
              <%= request.getSession().getAttribute("message") %>
            <% } %>
          <br>
          <h4>Edit Your About Me (only you can see this)</h4>
          <!--<form action="/profilepage" method="POST">
          </form>-->
          <form action="/profilepage">
            <textarea name="message" rows="7" cols="100"></textarea>
            <% if (request.getSession().getAttribute("message") != null) { %>
              <input type="submit">
            <% } else{ %>
              <input type="submit">
            <% } %>
          </form><br>
          <h4><%= request.getSession().getAttribute("user") %>'s Sent Messages</h4>
          Here will be the sent messages
        </p>
      <% } %>
    </div>
  </div>
</body>
</html>
