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
<%@ page import="java.util.List" %>
<%@ page import="codeu.model.data.Conversation" %>
<%@ page import="codeu.model.data.Message" %>
<%@ page import="codeu.model.data.User" %>

<!DOCTYPE html>
<html>
<head>
  <title>Profile Page</title>
  <link rel="stylesheet" href="/css/main.css">
  <style>
    label > input{ /* HIDE RADIO */
      visibility: hidden; /* Makes input not-clickable */
      position: absolute; /* Remove input from document flow */
    }
    label > input + img{ /* IMAGE STYLES */
      cursor:pointer;
      border:2px solid transparent;
    }
    label > input:checked + img { /* (RADIO CHECKED) IMAGE STYLES */
      border:2px solid #f00;
    }
    .profile label {
      display: inline-block;
      width: 12%;
      padding: 1%;
    }
    label > img {
      position: relative;
      width: 100%;
    }
  </style>
</head>
<body>
  <nav style="background-color:#67AAF9; font-family: sans-serif; font-variant:small-caps;">
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
      <% if(request.getSession().getAttribute("user") == null){ %>
        Please <a href="/login">login</a> to see your profile page!
      <% } else{ %>
        <img src="https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png" alt="placeholder for profile picture" style="border-radius: 100%; display: block;">
        <div class="profile">
          <label>
            <input type="radio" name="fb" value="https://avatars0.githubusercontent.com/u/5882787?s=460&v=4" />
            <img src="https://avatars0.githubusercontent.com/u/5882787?s=460&v=4" >
          </label>
          <label>
            <input type="radio" name="fb" value="https://avatars0.githubusercontent.com/u/3112455?s=460&v=4" />
            <img src="https://avatars0.githubusercontent.com/u/3112455?s=460&v=4">
          </label>
          <label>
            <input type="radio" name="fb" value="https://avatars1.githubusercontent.com/u/6338799?s=460&v=4" />
            <img src="https://avatars1.githubusercontent.com/u/6338799?s=460&v=4">
          </label>
          <label>
            <input type="radio" name="fb" value="https://avatars1.githubusercontent.com/u/6096171?s=88&v=4" />
            <img src="https://avatars1.githubusercontent.com/u/6096171?s=88&v=4">
          </label>
          <label>
            <input type="radio" name="fb" value="https://avatars3.githubusercontent.com/u/21346180?s=460&v=4" />
            <img src="https://avatars3.githubusercontent.com/u/21346180?s=460&v=4">
          </label>
          <label>
            <input type="radio" name="fb" value="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRcGaofOpzAuWowWCucje7gKQ1P4Z40dlZGKNuadOqPif-9UhAlLA" />
            <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRcGaofOpzAuWowWCucje7gKQ1P4Z40dlZGKNuadOqPif-9UhAlLA">
          </label>
        </div>
        <h1 style="font-variant: small-caps;"><%= request.getSession().getAttribute("user") %>'s Profile Page</h1>
        <p>
          <h4 style="font-variant: small-caps;" >Status</h4>
            <form action="" style="font-family: Verdana, sans-serif;">
              <input type="radio" name="status" value="available"> Available <br>
              <input type="radio" name="status" value="busy"> Busy <br>
              <input type="radio" name="status" value="away"> Away
            </form>
          <h4 style="font-variant: small-caps;">About <%= request.getSession().getAttribute("user") %></h4>
            <% if (request.getAttribute("message")  == null) { %>
              Write a bio below!
            <% } else{ %>
              <%= request.getAttribute("message")  %>
            <% } %>
          <hr/><br>
          <h4 style="font-variant: small-caps;">Edit Your About Me (only you can see this)</h4>
          <!--<form action="/profilepage" method="POST">
          </form>-->
          <form action="/profilepage">
            <textarea name="message" rows="7" cols="100"></textarea>

              <input type="submit">
          </form><hr/><br>
          <h4 style="font-variant: small-caps;"><%= request.getSession().getAttribute("user") %>'s Conversations</h4>
          <div>
            <% List<Conversation> conversations = (List<Conversation>) request.getAttribute("conversations");
            if (conversations == null || conversations.isEmpty()) { %>
              <p>There are no convos.</p>
            <% } else { %>
              <div>
                <ul id="conversations" class="chat" style="font-family: Verdana, sans-serif;">
                  <% for (Conversation conversation : conversations) { %>
                    <li><strong>Conversation:</strong> <a href="/chat/<%= conversation.getTitle() %>">
                      <%= conversation.getTitle() %></a></li>
                  <% } %>
                </ul>
              </div>
            <% } %>
            <hr/>
          </div>
        </p>
        <% } %>
          <!--<div>
            <% List<Message> messages = (List<Message>) request.getAttribute("messages");
            if (messages == null || messages.isEmpty()) { %>
              There are no sent messages.
            <% } else { %>
              <div>
                <ul>
                  <% for (Message message : messages) { %>
                    <li><strong><%= message.getCreationTime() %>:</strong> <%= message.getContent()%></li>
                  <% } %>
                </ul>
              </div>
            <% } %>
          </div>-->
    </div>
  </div>
</body>
</html>
