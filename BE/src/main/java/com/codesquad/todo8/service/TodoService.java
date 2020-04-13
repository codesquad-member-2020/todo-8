package com.codesquad.todo8.service;

import com.codesquad.todo8.error.CardNotFoundException;
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
    return card;
  }

  @Transactional
  public Card updateCard(Card newCard, Long cardId) throws Exception {
    Card card = cardRepository.findById(cardId).orElseThrow(Exception::new);
    card.update(newCard);
    cardRepository.save(card);
    return card;
  }

  @Transactional
  public void moveCard(Long cardId, Long categoryId, int cardIndex) throws Exception {
    Category category = categoryRepository.findById(categoryId).orElseThrow(Exception::new);
    Card card = cardRepository.findById(cardId).orElseThrow(Exception::new);
    cardRepository.delete(card);
    cardRepository.save(card);

    category.addCard(card, cardIndex);
    categoryRepository.save(category);
  }

  @Transactional
  public Card deleteCard(Long cardId) {
    Card deletedCard = cardRepository.findById(cardId)
        .orElseThrow(() -> new CardNotFoundException(cardId));
    cardRepository.delete(deletedCard);
    return deletedCard;
  }

  public void addActivity(Activity newActivity) {
    activityRepository.save(newActivity);
  }
}
