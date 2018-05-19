package codeu.controller;

import codeu.model.data.Conversation;
import codeu.model.data.Message;
import codeu.model.data.User;
import codeu.model.store.basic.ConversationStore;
import codeu.model.store.basic.MessageStore;
import codeu.model.store.basic.UserStore;
import java.io.IOException;
import java.time.Instant;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.jsoup.Jsoup;
import org.jsoup.safety.Whitelist;

/** Servlet class responsible for the Activity Feed. */
public class ActivityFeedServlet extends HttpServlet {
    
    /** Store class that gives access to Conversations. */
    private ConversationStore conversationStore;

    /** Store class that gives access to Messages. */
    private MessageStore messageStore;

    /** Store class that gives access to Users. */
    private UserStore userStore;

    /** Set up state for handling requests. */
    @Override
    public void init() throws ServletException {
        super.init();
        setConversationStore(ConversationStore.getInstance());
        setMessageStore(MessageStore.getInstance());
        setUserStore(UserStore.getInstance());
    }

    /**
     * Sets the ConversationStore used by this servlet. This function provides a common setup method
     * for use by the test framework or the servlet's init() function.
     */
    void setConversationStore(ConversationStore conversationStore) {
        this.conversationStore = conversationStore;
    }

    /**
     * Sets the MessageStore used by this servlet. This function provides a common setup method for
     * use by the test framework or the servlet's init() function.
     */
    void setMessageStore(MessageStore messageStore) {
        this.messageStore = messageStore;
    }

    /**
     * Sets the UserStore used by this servlet. This function provides a common setup method for use
     * by the test framework or the servlet's init() function.
     */
    void setUserStore(UserStore userStore) {
        this.userStore = userStore;
    }

    /**
     * This function fires when a user navigates to the Activity page. It grabs every active conversation
     * finds the corresponding ID, and maps those conversations to their respective messages.
     * It then forwards to activityfeed.jsp for rendering.
     */
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        List<User> users = userStore.getAllUsers();
        List<Conversation> conversations = conversationStore.getAllConversations();
        HashMap<Conversation, List<Message>> mapping = new HashMap<>();
        for (Conversation conversation : conversations) {
            List<Message> messages = messageStore.getMessagesInConversation(conversation.getId());
            mapping.put(conversation, messages);
        }

        request.setAttribute("users", users);
        request.setAttribute("conversations", conversations);
        request.setAttribute("mapping", mapping);
        request.getRequestDispatcher("/WEB-INF/view/activityfeed.jsp").forward(request, response);
    }
}
