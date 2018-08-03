package codeu.controller;

import java.io.IOException;
import java.time.Instant;
import java.util.UUID;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.mindrot.jbcrypt.BCrypt;

import codeu.model.data.User;
import codeu.model.store.basic.UserStore;

public class RegisterServlet extends HttpServlet {

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
  //String verficationPicAddress;

  /**
   * Set up state for handling registration-related requests. This method is only called when
   * running in a server, not when running in a test.
   */
  @Override
  public void init() throws ServletException {
    super.init();
    setUserStore(UserStore.getInstance());
    // call the helper function to initalize the map with the pictures
    initializePicMap();

  }

  /** This is a helper function to initialize the map with the verification pictures. */
  public void initializePicMap() throws ServletException {
    String verificationPic0 = "czchjiav";
    String verificationPicLetters0 = "/images/registrationPics/czchjiav.gif";
    String verificationPic1 = "dpbaiajz";
    String verificationPicLetters1 = "/images/registrationPics/dpbaiajz.gif";
    String verificationPic2 = "lucytpft";
    String verificationPicLetters2 = "/images/registrationPics/lucytpft.gif";
    String verificationPic3 = "nrtgdkwn";
    String verificationPicLetters3 = "/images/registrationPics/nrtgdkwn.gif";
    String verificationPic4 = "nvhoxdm";
    String verificationPicLetters4 = "/images/registrationPics/nvhoxdm.gif";
    String verificationPic5 = "phxxjdrk";
    String verificationPicLetters5 = "/images/registrationPics/phxxjdrk.gif";
    String verificationPic6 = "udbbgxls";
    String verificationPicLetters6 = "/images/registrationPics/udbbgxls.gif";
    String verificationPic7 = "wvvjcfua";
    String verificationPicLetters7 = "/images/registrationPics/wvvjcfua.gif";
    String verificationPic8 = "yhykemwr";
    String verificationPicLetters8 = "/images/registrationPics/yhykemwr.gif";
    String verificationPic9 = "zagxtwdx";
    String verificationPicLetters9 = "/images/registrationPics/zagxtwdx.gif";
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

  @Override
  public void doGet(HttpServletRequest request, HttpServletResponse response)
      throws IOException, ServletException {
    randomVerificationPic = (int)(Math.random()*10);
    String verificationPicLetters = verificationPictures.get(randomVerificationPic);
    request.setAttribute("verificationPicLetters", verificationPicLetters);
    request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
  }

  @Override
  public void doPost(HttpServletRequest request, HttpServletResponse response)
      throws IOException, ServletException {

    String username = request.getParameter("username");

    if (!username.matches("[\\w*\\s*]*")) {
      request.setAttribute("error", "Please enter only letters, numbers, and spaces.");
      request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
      return;
    }

    if (userStore.isUserRegistered(username)) {
      request.setAttribute("error", "That username is already taken.");
      request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
      return;
    }

    String password = request.getParameter("password");
    String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
    String profilePicLink = request.getParameter("fb");
    request.setAttribute("fb", profilePicLink);
    String about = request.getParameter("bio");
    request.setAttribute("bio", about);
    String status = request.getParameter("status");
    request.setAttribute("status", status);
    String verification = request.getParameter("verification");
    String verificationPicLetters = verificationPictures.get(randomVerificationPic);
    request.setAttribute("verificationPicLetters", verificationPicLetters);

    if (!verification.matches(correctVerificationList.get(randomVerificationPic))) {
      request.setAttribute("error", "Error! Verification failed, try again, please!");
      request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
    return;
  }

    // UUID id, String name, String passwordHash, Instant creation, String profilePicLink, String about, String status
    User user = new User(UUID.randomUUID(), username, hashedPassword, Instant.now(), profilePicLink, about, status);
    System.out.println(profilePicLink);
    System.out.println(about);
    System.out.println(status);
    // User user = new User(UUID.randomUUID(), username, hashedPassword, Instant.now());
    userStore.addUser(user);

    response.sendRedirect("/login");
  }
}
