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
<%@ page import="java.util.Set" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="codeu.model.data.Conversation" %>
<%@ page import="codeu.model.data.Message" %>
<%@ page import="codeu.model.data.User" %>
<%@ page import="codeu.model.store.basic.UserStore" %>
<%@ page import="codeu.model.store.basic.MessageStore" %>
<%
UserStore userStore = UserStore.getInstance();
Conversation conversation = (Conversation) request.getAttribute("conversation");
List<Message> messages = (List<Message>) request.getAttribute("messages");
Set<User> userSet = new HashSet<User>();
for (int i = 0; i < messages.size(); i++) {
  userSet.add(userStore.getUser(messages.get(i).getAuthorId()));
}
// for (User user : userSet) {
//   System.out.println(user.getName());
// }
%>

<!DOCTYPE html>
<html>
<head>
  <title><%= conversation.getTitle() %></title>
  <link rel="stylesheet" href="/css/main.css" type="text/css">

  <style>
    #chat {
      background-color: white;
      height: 500px;
      overflow-y: scroll
    }
  </style>

  <script>
    // scroll the chat div to the bottom
    function scrollChat() {
      var chatDiv = document.getElementById('chat');
      chatDiv.scrollTop = chatDiv.scrollHeight;
    };
  </script>
</head>
<body onload="scrollChat()">

  <nav style="background-color:#67AAF9; font-family: sans-serif; font-variant:small-caps;">
    <a id="navTitle" href="/">CodeU Chat App</a>
    <a href="/conversations">Conversations</a>
      <% if (request.getSession().getAttribute("user") != null) { %>
    <a>Hello <%= request.getSession().getAttribute("user") %>!</a>
    <% } else { %>
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

    <h1 style="font-family: Verdana, sans-serif; font-variant: small-caps"><%= conversation.getTitle() %>
      <a href="" style="float: right; font-variant: small-caps">&#8635;</a></h1>
      <h5 style="font-family: Verdana, sans-serif; font-variant: small-caps;">Participants:</h5>
    <ul style="font-family: Verdana, sans-serif; font-size: 3;">
    <% for (User user : userSet) {
      String username = user.getName();
      String profilePicLink = user.getProfilePicLink();
      String status = user.getStatus();
      if (profilePicLink != null && status != null) { %>
        <li><img src=<%= profilePicLink %> style="border-radius: 50%; width:50px"alt="profile pic"><br><strong>Username: </strong><%= username%><br><strong>Status: </strong><%= status %></li>
       <% } else { %>
        <li><strong>Username: </strong><%= username %></li>
        <% } %>
    <% } %>
    </ul>
    <hr/>

    <div id="chat">
      <ul style="font-family: Verdana, sans-serif;">
    <%
      for (Message message : messages) {
        String author = UserStore.getInstance()
          .getUser(message.getAuthorId()).getName();
    %>
      <li><strong><%= author %>:</strong> <%= message.getContent() %></li>
    <%
      }
    %>
      </ul>
    </div>

    <hr/>

    <% if (request.getSession().getAttribute("user") != null) { %>
    <form action="/chat/<%= conversation.getTitle() %>" method="POST">
        <input type="text" name="message">
        <br/>
        <button type="submit">Send</button>
    </form>
    <% } else { %>
      <p><a href="/login">Login</a> to send a message.</p>
    <% } %>

    <hr/>

  </div>

</body>
</html>
