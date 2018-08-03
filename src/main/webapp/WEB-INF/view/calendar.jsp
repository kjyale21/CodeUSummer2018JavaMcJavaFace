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
  <title>Calendar Page</title>
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
      <% } %>
    <% if(request.getSession().getAttribute("user") != null){ %>
       <a href="/calendar">Calendar</a>
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

      <h1 style="font-variant: small-caps;">Plan ahead to chat with friends.</h1>
      <p style="font-family: Verdana, sans-serif;">
        Use this gcal to plan out events!
      </p>
      
<iframe src="https://calendar.google.com/calendar/b/1/embed?title=CodeU%20JavaMcJavaFace%20Scheduler&amp;height=600&amp;wkst=1&amp;bgcolor=%2333ccff&amp;src=en.usa%23holiday%40group.v.calendar.google.com&amp;color=%23125A12&amp;ctz=America%2FLos_Angeles" style="border:solid 1px #777" width="1000" height="600" frameborder="20" scrolling="no"></iframe>  
  
  
</body>
</html>
