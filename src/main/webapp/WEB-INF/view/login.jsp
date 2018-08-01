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
  <title>Login</title>
  <link rel="stylesheet" href="/css/main.css">
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
  </nav>

  <div id="container">
    <h1 style="font-variant: small-caps; text-align: center;">Login</h1>

    <% if(request.getAttribute("error") != null){ %>
        <h2 style="color:red; font-family: Verdana, sans-serif; text-align: center;""><%= request.getAttribute("error") %></h2>
    <% } %>

    <form action="/login" method="POST" style="font-family: Verdana, sans-serif; text-align: center;">
      <label for="username">Username: </label>
      <br/>
      <input style="width: 300px;" type="text" name="username" id="username">
      <br/>
      <label for="password">Password: </label>
      <br/>
      <input style="width: 300px;" type="password" name="password" id="password">
      <br/><br/>
      <button type="submit">Login</button>
    </form>

    <p style="font-family: Verdana, sans-serif; text-align: center;">New users can register <a href="/register">here</a>.</p>
  </div>
</body>
</html>
