package org.sang.tcp.model;

import java.io.Serializable;

public class User implements Serializable {

    private String action;
    private Long id;
    private String name;

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return String.format("User{action=%s, id=%d, name=%s}", action, id, name);
    }
}
