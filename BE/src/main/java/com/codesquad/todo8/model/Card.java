package com.codesquad.todo8.model;

import org.springframework.data.annotation.Id;

public class Card {

    @Id
    private long id;

    private String title;
    private String content;

    public Card(String title, String content) {
        this.title = title;
        this.content = content;
    }

    public long getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getContent() {
        return content;
    }

    @Override
    public String toString() {
        return "Card{" +
                "title='" + title + '\'' +
                ", content='" + content + '\'' +
                '}';
    }
}

