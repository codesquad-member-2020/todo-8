package com.codesquad.todo8.service;

import com.codesquad.todo8.model.Category;
import com.codesquad.todo8.repository.CardRepository;
import com.codesquad.todo8.repository.CategoryRepository;
import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class TodoService {

  private final CategoryRepository categoryRepository;
  private final CardRepository cardRepository;

  public TodoService(CategoryRepository categoryRepository,
      CardRepository cardRepository) {
    this.categoryRepository = categoryRepository;
    this.cardRepository = cardRepository;
  }

  @Transactional(readOnly = true)
  public List<Category> findAllContents(Long id) {
    return categoryRepository.findAllByUserId(id);
  }
}
