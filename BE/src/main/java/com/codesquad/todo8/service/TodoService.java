package com.codesquad.todo8.service;

import static java.time.LocalDateTime.now;

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

    Activity added = createActivity(card, "added");
    saveActivity(added);

    Category savedCategory = categoryRepository.findById(card.getCategoryId())
        .orElseThrow(() -> new CardNotFoundException(card.getId()));
    Card createdCard = savedCategory.getCards().get(0);
    return createdCard;
  }

  @Transactional
  public Card updateCard(Card newCard, Long cardId) {
    Card updatedCard = cardRepository.findById(cardId)
        .orElseThrow(() -> new CardNotFoundException(cardId));
    updatedCard.update(newCard);
    cardRepository.save(updatedCard);

    Activity updated = createActivity(updatedCard, "updated");
    saveActivity(updated);

    return updatedCard;
  }

  @Transactional
  public Card moveCard(Long cardId, Long targetCategoryId, int index) {
    Card movedCard = cardRepository.findById(cardId)
        .orElseThrow(() -> new CardNotFoundException(cardId));

    cardRepository.deleteById(movedCard.getId());

    Category targetCategory = categoryRepository.findById(targetCategoryId)
        .orElseThrow(() -> new CategoryNotFoundException(targetCategoryId));

    targetCategory.addCard(movedCard, index);
    categoryRepository.save(targetCategory);

    Activity moved = createActivity(movedCard, targetCategoryId, "moved");
    saveActivity(moved);
    return cardRepository.findById(cardId).orElseThrow(() -> new CardNotFoundException(cardId));
  }

  @Transactional
  public Card deleteCard(Long cardId) {
    Card deletedCard = cardRepository.findById(cardId)
        .orElseThrow(() -> new CardNotFoundException(cardId));
    cardRepository.delete(deletedCard);

    Activity deleted = createActivity(deletedCard, "deleted");
    saveActivity(deleted);
    return deletedCard;
  }

  @Transactional
  public Category createCategory(Category newCategory) {
    return categoryRepository.save(newCategory);
  }

  @Transactional
  public Category updateCategoryTitle(Long categoryId, String title) {
    Category category = categoryRepository.findById(categoryId)
        .orElseThrow(() -> new CategoryNotFoundException(categoryId));
    category.updateTitle(title);
    return categoryRepository.save(category);
  }

  @Transactional
  public void deleteCategory(Long categoryId) {
    categoryRepository.deleteById(categoryId);
  }

  private void saveActivity(Activity activity) {
    activityRepository.save(activity);
  }

  private Activity createActivity(Card card, String action) {
    return new Activity.Builder()
        .author(card.getAuthor())
        .action(action)
        .targetName(card.getTitle())
        .arrival(card.getCategoryId())
        .createdTime(now())
        .build();
  }

  private Activity createActivity(Card card, Long targetCategoryId, String action) {
    return new Activity.Builder()
        .author(card.getAuthor())
        .action(action)
        .targetName(card.getTitle())
        .departure(card.getCategoryId())
        .arrival(targetCategoryId)
        .createdTime(now())
        .build();
  }

}
