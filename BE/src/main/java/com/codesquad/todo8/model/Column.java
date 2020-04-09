package com.codesquad.todo8.model;

import org.springframework.data.annotation.Id;

import java.util.ArrayList;
import java.util.List;

public class Column {

    @Id
    private long id;

    private String title;

    private List<Card> cards = new ArrayList<>();

    public Column(String title) {
        this.title = title;
    }

    public long getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public List<Card> getCards() {
        return cards;
    }

    public void addCard(Card card) {
        this.cards.add(card);
    }

    @Override
    public String toString() {
        return "Column{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", cards=" + cards +
                '}';
    }
}
