package codeu.model.data;

import codeu.model.store.basic.UserStore;

import java.time.Instant;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.format.FormatStyle;
import java.util.HashMap;
import java.util.Locale;
import java.util.UUID;

public class Activity {

    public enum Type {
        USER_CREATED,
        MESSAGE_SENT,
        CONVERSATION_CREATED
    } // TODO: add more (deletions specifically)

    private static final HashMap<String, Activity.Type> typeMapping;
    static {
        HashMap<String, Activity.Type> temp = new HashMap<>();
        temp.put("User Created", Type.USER_CREATED);
        temp.put("Message Sent", Type.MESSAGE_SENT);
        temp.put("Conversation Created", Type.CONVERSATION_CREATED);
        typeMapping = temp;
    }

    private UUID id;
    private Instant creation;
    private String title;
    private String type;
    private String description;
    private String user;

    /**
     * Constructs a new Activity.
     *
     * @param id the ID of this Activity
     * @param title the title of this Activity
     * @param type the type of this Activity
     * @param description the description of this Activity
     * @param creation the time of this Activity
     */
    public Activity(UUID id, String title, Activity.Type type, String description, Instant creation) {
        this.id = id;
        this.title = title;

        boolean found = false;
        for (Object t : typeMapping.keySet()) {
            if (typeMapping.get(t).equals(type)) {
                this.type = (String) t;
                found = true;
            }
        }
        if (!found) {
            // throw exception
        }
        this.description = description;
        this.creation = creation;
    }

    /**
     * Constructs a new Activity.
     *
     * @param id the ID of this Activity
     * @param title the title of this Activity
     * @param type the type of this Activity
     * @param description the description of this Activity
     * @param creation the time of this Activity
     */
    public Activity(UUID id, String title, String type, String description, Instant creation) {
        this.id = id;
        this.title = title;
        if (typeMapping.containsKey(type)) {
            this.type = type;
        } else {
            // throw exception
        }
        this.description = description;
        this.creation = creation;
    }

    /** Returns the ID of this Activity. */
    public UUID getId() {
        return id;
    }

    /** Returns the title of this Activity.
     * If Type == USER_CREATED, returns the username.
     * If Type == MESSAGE_SENT | CONVERSATION_CREATED,
     * returns the conversation title. */
    public String getTitle() {
        return title;
    }

    /** Returns the username associated with this activity. */
    public User getUser(UserStore userStore) {
        return userStore.getUser(id);
    }

    /** Returns the type of this Activity as a string. */
    public String getTypeString() {
        return type;
    }

    /** Returns the type of this Activity. */
    public Activity.Type getType() {
        return typeMapping.get(type);
    }

    /** Returns the description of this Activity. */
    public String getDescription() {
        return description;
    }

    /** Returns the creation time of this Activity. */
    public Instant getCreationTime() {
        return creation;
    }

    /** Returns the formatted creation time of this Activity. */
    public String getCreationTimeFormatted() {
        DateTimeFormatter formatter = DateTimeFormatter.ofLocalizedDateTime(FormatStyle.SHORT)
                .withLocale(Locale.US).withZone(ZoneId.systemDefault());
        return formatter.format(creation);

    }
}
