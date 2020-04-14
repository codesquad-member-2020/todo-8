package com.codesquad.todo8.service;

import com.codesquad.todo8.error.CardNotFoundException;
import com.codesquad.todo8.error.CategoryNotFoundException;
import com.codesquad.todo8.model.Activity;
import com.codesquad.todo8.model.Card;
import com.codesquad.todo8.model.Category;
import com.codesquad.todo8.repository.ActivityRepository;
import com.codesquad.todo8.repository.CardRepository;
import com.codesquad.todo8.repository.CategoryRepository;
import java.time.LocalDateTime;
import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class TodoService {

  private final CategoryRepository categoryRepository;
  private final ActivityRepository activityRepository;
  private final CardRepository cardRepository;

  public TodoService(CategoryRepository categoryRepository,
      ActivityRepository activityRepository, CardRepository cardRepository) {
    this.categoryRepository = categoryRepository;
    this.activityRepository = activityRepository;
    this.cardRepository = cardRepository;
  }

  @Transactional(readOnly = true)
  public List<Activity> findAllActivity(String author) {
    return activityRepository.findAllByAuthor(author);
  }

  @Transactional(readOnly = true)
  public List<Category> findAllContents(Long id) {
    return categoryRepository.findAllByUserId(id);
  }

  @Transactional
  public Card createCard(Card card) {
    Category category = categoryRepository.findById(card.getCategoryId())
        .orElseThrow(() -> new CardNotFoundException(card.getId()));
    category.addFirstCard(card);
    categoryRepository.save(category);

    Activity added = new Activity.Builder()
        .author(card.getAuthor())
        .action("added")
        .targetName(card.getTitle())
        .createdTime(getNow())
        .build();
    saveActivity(added);
    return card;
  }

  @Transactional
  public Card updateCard(Card newCard, Long cardId) {
    Card card = cardRepository.findById(cardId)
        .orElseThrow(() -> new CardNotFoundException(cardId));
    card.update(newCard);
    cardRepository.save(card);

    Activity updated = new Activity.Builder()
        .author(card.getAuthor())
        .action("updated")
        .targetName(card.getTitle())
        .createdTime(getNow())
        .build();
    saveActivity(updated);

    return card;
  }

  @Transactional
  public Card moveCard(Long cardId, Long targetCategoryId, int index) {
    Card card = cardRepository.findById(cardId)
        .orElseThrow(() -> new CardNotFoundException(cardId));
    deleteCard(card.getId());

    Category category = categoryRepository.findById(targetCategoryId)
        .orElseThrow(() -> new CategoryNotFoundException(targetCategoryId));

    category.addCard(card, index);
    categoryRepository.save(category);

    Activity moved = new Activity.Builder()
        .author(card.getAuthor())
        .action("moved")
        .targetName(card.getTitle())
        .departure(card.getCategoryId())
        .arrival(targetCategoryId)
        .createdTime(getNow())
        .build();
    saveActivity(moved);

    return cardRepository.findById(cardId).orElseThrow(() -> new CardNotFoundException(cardId));
  }

  @Transactional
  public Card deleteCard(Long cardId) {
    Card deletedCard = cardRepository.findById(cardId)
        .orElseThrow(() -> new CardNotFoundException(cardId));
    cardRepository.delete(deletedCard);

    Activity deleted = new Activity.Builder()
        .author(deletedCard.getAuthor())
        .action("deleted")
        .targetName(deletedCard.getTitle())
        .createdTime(getNow())
        .build();
    saveActivity(deleted);
    return deletedCard;
  }

  private void saveActivity(Activity activity) {
    activityRepository.save(activity);
  }

  private LocalDateTime getNow() {
    return LocalDateTime.now();
  }
}
