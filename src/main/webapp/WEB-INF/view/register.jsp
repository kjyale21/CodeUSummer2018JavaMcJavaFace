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
  <title>Register</title>
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
    .profile_picture label {
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
    <% if(request.getSession().getAttribute("user") != null) { %>
      <a>Hello <%= request.getSession().getAttribute("user") %>!</a>
    <% } else { %>
      <a href="/login">Login</a>
    <% } %>
    <a href="/about.jsp">About</a>
    <a href="/activityfeed">Activity</a>
  </nav>

  <div id="container">
    <h1 style="font-variant: small-caps; text-align: center;">Register</h1>

    <% if(request.getAttribute("error") != null){ %>
        <center><h2 style="color:red"><%= request.getAttribute("error") %></h2></center>
    <% } %>

    <form action="/register" method="POST" style="font-family: Verdana, sans-serif; text-align: center;">
      <label for="username">Username: </label>
      <br/>
      <input style="width: 300px;" type="text" name="username" id="username">
      <br/>
      <label for="password">Password: </label>
      <br/>
      <input style="width: 300px;" type="password" name="password" id="password">
      <br/><br/>
      <p>To select a profile image, please click on one of the images below:</p>
      <div class="profile_picture">
          <label>
            <input type="radio" name="fb" value="https://avatars0.githubusercontent.com/u/5882787?s=460&v=4" />
            <img src="/images/githubavatar1.png" alt="githubavatar1">
          </label>
          <label>
            <input type="radio" name="fb" value="https://avatars0.githubusercontent.com/u/3112455?s=460&v=4" />
            <img src="/images/githubavatar2.png" alt="githubavatar2">
          </label>
          <label>
            <input type="radio" name="fb" value="https://avatars1.githubusercontent.com/u/6338799?s=460&v=4" />
            <img src="/images/githubavatar3.png" alt="githubavatar3">
          </label>
          <label>
            <input type="radio" name="fb" value="https://avatars1.githubusercontent.com/u/6096171?s=88&v=4" />
            <img src="/images/githubavatar4.png" alt="githubavatar4">
          </label>
          <label>
            <input type="radio" name="fb" value="https://avatars3.githubusercontent.com/u/21346180?s=460&v=4" />
            <img src="/images/githubavatar5.png" alt="githubavatar5">
          </label>
          <label>
            <input type="radio" name="fb" value="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRcGaofOpzAuWowWCucje7gKQ1P4Z40dlZGKNuadOqPif-9UhAlLA" />
            <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRcGaofOpzAuWowWCucje7gKQ1P4Z40dlZGKNuadOqPif-9UhAlLA" alt="githubavatar6">
          </label>
        </div>
        <br>
        <div class="bio">
          <label for="bio">Write a bio below, be as creative as you want! </label>
            <br/>
           <input style="width: 300px;" type="text" name="bio" id="bio">
        </div>
        <br>
        <div>
          <label for="status">Write a status below: </label>
            <br/>
          <input style="width: 300px;" type="text" name="status" id="status">
        </div>
        <br>
        <div>
          <%String verificationLetters = (String) request.getAttribute("verificationPicLetters");
          %>
          <img src= <%=verificationLetters%> alt="verification picture with letters" width="200" height="150">
          <br>
          <label for="verification">Enter the letters in the image above:</label>
          <br>
          <input type="text" name="verification" id="verification">
        </div>
        <br>
      <button type="submit">Submit</button>
    </form>
  </div>
</body>
</html>
