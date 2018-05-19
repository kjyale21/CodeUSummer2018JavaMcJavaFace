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

package codeu.model.store.basic;

import codeu.model.data.Conversation;
import codeu.model.store.persistence.PersistentStorageAgent;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

/**
 * Store class that uses in-memory data structures to hold values and automatically loads from and
 * saves to PersistentStorageAgent. It's a singleton so all servlet classes can access the same
 * instance.
 */
public class ConversationStore {

  /** Singleton instance of ConversationStore. */
  private static ConversationStore instance;

  /**
   * Returns the singleton instance of ConversationStore that should be shared between all servlet
   * classes. Do not call this function from a test; use getTestInstance() instead.
   */
  public static ConversationStore getInstance() {
    if (instance == null) {
      instance = new ConversationStore(PersistentStorageAgent.getInstance());
    }
    return instance;
  }

  /**
   * Instance getter function used for testing. Supply a mock for PersistentStorageAgent.
   *
   * @param persistentStorageAgent a mock used for testing
   */
  public static ConversationStore getTestInstance(PersistentStorageAgent persistentStorageAgent) {
    return new ConversationStore(persistentStorageAgent);
  }

  
  /**
   * The PersistentStorageAgent responsible for loading Conversations from and saving Conversations
   * to Datastore.
   */
  private PersistentStorageAgent persistentStorageAgent;

  /** The in-memory mapping of UUIDs to Conversations. */
  private HashMap<UUID, Conversation> conversations;

  /** An in-memory mapping of conversation titles to IDs. */
  private HashMap<String, UUID> ids;

  /** This class is a singleton, so its constructor is private. Call getInstance() instead. */
  private ConversationStore(PersistentStorageAgent persistentStorageAgent) {
    this.persistentStorageAgent = persistentStorageAgent;
    conversations = new HashMap<>();
    ids = new HashMap<>();
  }

  /** Access the current set of conversations known to the application. */
  public List<Conversation> getAllConversations() {
    List<Conversation> all = new ArrayList<>(conversations.values());
    return all;
  }

  /** Add a new conversation to the current set of conversations known to the application. */
  public void addConversation(Conversation conversation) {
    conversations.put(conversation.getId(), conversation);
    ids.put(conversation.getTitle(), conversation.getId());
    persistentStorageAgent.writeThrough(conversation);
  }

  /** Check whether a Conversation title is already known to the application. */
  public boolean isTitleTaken(String title) {
    return ids.containsKey(title);
  }

  /** Find and return the Conversation with the given title. */
  public Conversation getConversationWithTitle(String title) {
    UUID id = ids.get(title);
    return getConversationWithID(id);
  }
  
  /** amount of conversations*/
  public int getAmountConversations() {
	  List<Conversation> all = new ArrayList<>(conversations.values());
	  return all.size();
  }


  /** Find and return the Conversation with the given id. */
  private Conversation getConversationWithID(UUID id) {
    return conversations.get(id);
  }

  /** Sets the Conversations stored by this ConversationStore. */
  public void setConversations(List<Conversation> conversations) {
    for (Conversation conversation : conversations) {
      this.conversations.put(conversation.getId(), conversation);
      this.ids.put(conversation.getTitle(), conversation.getId());
    }
  }
}
