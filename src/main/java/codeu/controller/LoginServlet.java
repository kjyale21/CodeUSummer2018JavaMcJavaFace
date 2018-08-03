// Copyright 2017 Google Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package codeu.controller;

import java.util.List;
import java.util.ArrayList;
import java.util.HashMap;
import codeu.model.data.User;
import codeu.model.store.basic.UserStore;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.mindrot.jbcrypt.BCrypt;

/** Servlet class responsible for the login page. */
public class LoginServlet extends HttpServlet {

  /** Store class that gives access to Users. */
  private UserStore userStore;
  HashMap<Integer, String> verificationPictures = new HashMap<Integer, String>();
  List<String> correctVerificationList = new ArrayList<String>();

  // initialize the verification pictures and the addresses for the pictures
  String verificationPic0,verificationPic1,verificationPic2,verificationPic3,verificationPic4,
  verificationPic5,verificationPic6,verificationPic7,verificationPic8,verificationPic9;
  String verificationPicLetters0,verificationPicLetters1,verificationPicLetters2,verificationPicLetters3,
  verificationPicLetters4,verificationPicLetters5,verificationPicLetters6,verificationPicLetters7,verificationPicLetters8,
  verificationPicLetters9;
  int randomVerificationPic;

  /**
   * Set up state for handling login-related requests. This method is only called when running in a
   * server, not when running in a test.
   */
  @Override
  public void init() throws ServletException {
    super.init();
    setUserStore(UserStore.getInstance());

    initializePicMap();
  }

  /** This is a helper function to initialize the map with the verification pictures. */
  public void initializePicMap() throws ServletException {
    String verificationPic0 = "because";
    String verificationPicLetters0 = "/images/verificationLetterPics/because.png";
    String verificationPic1 = "cadal";
    String verificationPicLetters1 = "/images/verificationLetterPics/cadal.png";
    String verificationPic2 = "chandise";
    String verificationPicLetters2 = "/images/verificationLetterPics/chandise.png";
    String verificationPic3 = "chosen";
    String verificationPicLetters3 = "/images/verificationLetterPics/chosen.png";
    String verificationPic4 = "contend";
    String verificationPicLetters4 = "/images/verificationLetterPics/contend.png";
    String verificationPic5 = "desphasi";
    String verificationPicLetters5 = "/images/verificationLetterPics/desphasi.png";
    String verificationPic6 = "flextime";
    String verificationPicLetters6 = "/images/verificationLetterPics/flextime.png";
    String verificationPic7 = "gionfor";
    String verificationPicLetters7 = "/images/verificationLetterPics/gionfor.png";
    String verificationPic8 = "glanese";
    String verificationPicLetters8 = "/images/verificationLetterPics/glanese.png";
    String verificationPic9 = "grandchildren";
    String verificationPicLetters9 = "/images/verificationLetterPics/grandchildren.png";
    verificationPictures.put(0, verificationPicLetters0);
    verificationPictures.put(1, verificationPicLetters1);
    verificationPictures.put(2, verificationPicLetters2);
    verificationPictures.put(3, verificationPicLetters3);
    verificationPictures.put(4, verificationPicLetters4);
    verificationPictures.put(5, verificationPicLetters5);
    verificationPictures.put(6, verificationPicLetters6);
    verificationPictures.put(7, verificationPicLetters7);
    verificationPictures.put(8, verificationPicLetters8);
    verificationPictures.put(9, verificationPicLetters9);
    correctVerificationList.add(verificationPic0);
    correctVerificationList.add(verificationPic1);
    correctVerificationList.add(verificationPic2);
    correctVerificationList.add(verificationPic3);
    correctVerificationList.add(verificationPic4);
    correctVerificationList.add(verificationPic5);
    correctVerificationList.add(verificationPic6);
    correctVerificationList.add(verificationPic7);
    correctVerificationList.add(verificationPic8);
    correctVerificationList.add(verificationPic9);
  }

  /**
   * Sets the UserStore used by this servlet. This function provides a common setup method for use
   * by the test framework or the servlet's init() function.
   */
  void setUserStore(UserStore userStore) {
    this.userStore = userStore;
  }

  /**
   * This function fires when a user requests the /login URL. It simply forwards the request to
   * login.jsp.
   */
  @Override
  public void doGet(HttpServletRequest request, HttpServletResponse response)
      throws IOException, ServletException {
    randomVerificationPic = (int)(Math.random()*10);
    String verificationPicLetters = verificationPictures.get(randomVerificationPic);
    request.setAttribute("verificationPicLetters", verificationPicLetters);
    request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
  }

  /**
   * This function fires when a user submits the login form. It gets the username and password from
   * the submitted form data, checks for validity and if correct adds the username to the session so
   * we know the user is logged in.
   */
  @Override
  public void doPost(HttpServletRequest request, HttpServletResponse response)
      throws IOException, ServletException {
    String username = request.getParameter("username");
    String password = request.getParameter("password");String verification = request.getParameter("verification");
    String verificationPicLetters = verificationPictures.get(randomVerificationPic);
    request.setAttribute("verificationPicLetters", verificationPicLetters);

    if (!verification.matches(correctVerificationList.get(randomVerificationPic))) {
      request.setAttribute("error", "Error! Verification failed, try again, please!");
      request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
      return;
    }

    if (!userStore.isUserRegistered(username)) {
      request.setAttribute("error", "That username was not found.");
      request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
      return;
    }

    User user = userStore.getUser(username);

    if (!BCrypt.checkpw(password, user.getPasswordHash())) {
      request.setAttribute("error", "Please enter a correct password.");
      request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
      return;
    }

    request.getSession().setAttribute("user", username);
    response.sendRedirect("/conversations");
  }
}
