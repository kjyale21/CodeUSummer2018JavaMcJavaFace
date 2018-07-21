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
<%@ page import="java.util.Collections" %>
<%@ page import="java.util.Comparator" %>
<%@ page import="codeu.model.data.Conversation" %>
<%@ page import="codeu.model.data.Message" %>
<%@ page import="codeu.model.data.User" %>
<%@ page import="codeu.model.store.basic.UserStore" %>
<%@ page import="codeu.model.data.Activity" %>

<!DOCTYPE html>
<html>
<head>
  <title>Activity Feed</title>
  <link rel="stylesheet" href="/css/main.css">

  <style>
      #chat {
        background-color: white;
        height: 500px;
        overflow-y: scroll
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
      <% } %>
    <% if(request.getSession().getAttribute("user") != null){ %>
       <a href="/logout">Logout</a>
    <% } else{ %>
      <h1></h1>
      <% } %>
  </nav>

  <div id="container">

      <h1 style="font-variant: small-caps;">Activity Feed</h1>
      <h3 style="font-family: Verdana, sans-serif;">Here's some highlights from what's happening on the site:</h3>

      <hr/>
      <%
      List<Activity> activities =
        (List<Activity>) request.getAttribute("activities");
      UserStore userStore = (UserStore) request.getAttribute("userStore");
      if(activities == null || activities.isEmpty()){

      %>
        <p style="font-family: Verdana, sans-serif;">There are no active conversations at the moment.</p>
      <%
      } else {
      %>
          <div id="chat" style="font-family: Verdana, sans-serif;">
          <ul class="chat">
          <%
            Collections.sort(activities, new Comparator<Activity>() {
                public int compare(Activity one, Activity other) {
                    return other.getCreationTime().compareTo(one.getCreationTime());
                }
            });
            for(Activity activity : activities){
                if(activity.getType() == Activity.Type.USER_CREATED) {
          %>
            <li><strong><%= activity.getCreationTimeFormatted() %>:</strong>
              <%= activity.getUser(userStore).getName() %> joined!</li>
          <%
                } else if(activity.getType() == Activity.Type.MESSAGE_SENT) {
          %>
            <li><strong><%= activity.getCreationTimeFormatted() %>:</strong>
              <%= activity.getUser(userStore).getName() %> sent a message in
              <a href="/chat/<%= activity.getTitle() %>"><%= activity.getTitle() %></a>:
              "<%= activity.getDescription() %>"</li>
          <%
                } else if(activity.getType() == Activity.Type.CONVERSATION_CREATED) {
          %>
            <li><strong><%= activity.getCreationTimeFormatted() %>:</strong>
              <%= activity.getUser(userStore).getName() %> created a conversation:
              <a href="/chat/<%= activity.getTitle() %>"><%= activity.getTitle() %></a></li>
          <%
                }
             }
          %>
          </ul>
          </div>
      <%
        }
      %>
      <hr/>
    </div>
  </div>
</body>
</html>
