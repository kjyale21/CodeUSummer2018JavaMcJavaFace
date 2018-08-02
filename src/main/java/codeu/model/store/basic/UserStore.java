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

import codeu.model.data.User;
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
public class UserStore {

  /** Singleton instance of UserStore. */
  private static UserStore instance;

  /**
   * Returns the singleton instance of UserStore that should be shared between all servlet classes.
   * Do not call this function from a test; use getTestInstance() instead.
   */
  public static UserStore getInstance() {
    if (instance == null) {
      instance = new UserStore(PersistentStorageAgent.getInstance());
    }
    return instance;
  }

  /**
   * Instance getter function used for testing. Supply a mock for PersistentStorageAgent.
   *
   * @param persistentStorageAgent a mock used for testing
   */
  public static UserStore getTestInstance(PersistentStorageAgent persistentStorageAgent) {
    return new UserStore(persistentStorageAgent);
  }

  /**
   * The PersistentStorageAgent responsible for loading Users from and saving Users to Datastore.
   */
  private PersistentStorageAgent persistentStorageAgent;

  /** The in-memory mapping of UUIDs to Users. */
  private HashMap<UUID, User> users;

  /** An in-memory mapping of usernames to UUIDs. */
  private HashMap<String, UUID> ids;

  /** This class is a singleton, so its constructor is private. Call getInstance() instead. */
  private UserStore(PersistentStorageAgent persistentStorageAgent) {
    this.persistentStorageAgent = persistentStorageAgent;
    users = new HashMap<>();
    ids = new HashMap<>();
  }

  /** Access the current set of users known to the application. */
  public List<User> getAllUsers() {
    List<User> all = new ArrayList<>(users.values());
    return all;
  }

  /**
   * Access the User object with the given name.
   *
   * @return null if username does not match any existing User.
   */
  public User getUser(String username) {
    UUID id = ids.get(username);
    return getUser(id);
  }

  /**
   * Access the User object with the given UUID.
   *
   * @return null if the UUID does not match any existing User.
   */
  public User getUser(UUID id) {
    return users.get(id);
  }

  /**
   * Add a new user to the current set of users known to the application. This should only be called
   * to add a new user, not to update an existing user.
   */
  public void addUser(User user) {
    ids.put(user.getName(), user.getId());
    users.put(user.getId(), user);
    System.out.println("User store user status" + user.getStatus());
    persistentStorageAgent.writeThrough(user);
  }

  /**
   * Update an existing User.
   */
  public void updateUser(User user) {
    User prevUser = getUser(user.getId());

    ids.remove(prevUser.getName());
    ids.put(user.getName(), user.getId());

    users.remove(prevUser.getId());
    users.put(user.getId(), user);

    persistentStorageAgent.writeThrough(user);
    System.out.println("userstore print" + user.getAbout());
  }

  /** Return true if the given username is known to the application. */
  public boolean isUserRegistered(String username) {
    return ids.containsKey(username);
  }

  /**
   * Sets the Users stored by this UserStore. This should only be called once, when the data
   * is loaded from Datastore.
   */
  public void setUsers(List<User> users) {
    for (User user : users) {
      this.ids.put(user.getName(), user.getId());
      this.users.put(user.getId(), user);
    }
  }


}

