package com.codesquad.todo8.service;

import com.codesquad.todo8.error.CardNotFoundException;
import com.codesquad.todo8.error.CategoryNotFoundException;
import com.codesquad.todo8.model.Activity;
import com.codesquad.todo8.model.Card;
import com.codesquad.todo8.model.Category;
import com.codesquad.todo8.repository.ActivityRepository;
import com.codesquad.todo8.repository.CardRepository;
import com.codesquad.todo8.repository.CategoryRepository;
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

    Activity activity = Activity.add(
        card.getAuthor(),
        "added",
        card.getTitle()
    );
    saveActivity(activity);
    return card;
  }

  @Transactional
  public Card updateCard(Card newCard, Long cardId) {
    Card card = cardRepository.findById(cardId)
        .orElseThrow(() -> new CardNotFoundException(cardId));
    card.update(newCard);
    cardRepository.save(card);

    Activity activity = Activity.update(
        card.getAuthor(),
        "updated",
        card.getTitle(),
        null,
        null
    );
    saveActivity(activity);

    return card;
  }

  @Transactional
  public Card moveCard(Long cardId, Long categoryId, int cardIndex) {
    Card card = cardRepository.findById(cardId)
        .orElseThrow(() -> new CardNotFoundException(cardId));
    deleteCard(card.getId());

    Category category = categoryRepository.findById(categoryId)
        .orElseThrow(() -> new CategoryNotFoundException(categoryId));

    category.addCard(card, cardIndex);
    categoryRepository.save(category);

    Activity activity = Activity.move(
        card.getAuthor(),
        "moved",
        card.getTitle(),
        card.getCategoryId(),
        categoryId
    );
    saveActivity(activity);

    return cardRepository.findById(cardId).orElseThrow(() -> new CardNotFoundException(cardId));
  }

  @Transactional
  public Card deleteCard(Long cardId) {
    Card deletedCard = cardRepository.findById(cardId)
        .orElseThrow(() -> new CardNotFoundException(cardId));
    cardRepository.delete(deletedCard);

    Activity activity = Activity.remove(
        deletedCard.getAuthor(),
        "deleted",
        deletedCard.getTitle()
    );
    saveActivity(activity);

    return deletedCard;
  }

  @Transactional
  public Category updateCategoryTitle(Long categoryId, String title) {
    Category category = categoryRepository.findById(categoryId)
        .orElseThrow(() -> new CategoryNotFoundException(categoryId));
    category.updateTitle(title);
    return categoryRepository.save(category);
  }

  @Transactional
  public void saveActivity(Activity activity) {
    activityRepository.save(activity);
  }
}
