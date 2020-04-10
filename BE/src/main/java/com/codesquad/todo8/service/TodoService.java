package com.codesquad.todo8.service;

import com.codesquad.todo8.model.Activity;
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
    public List<Category> findAllContents(Long id) {
        return categoryRepository.findAllByUserId(id);
    }

    public List<Activity> findAllActivity(String author) {
        return activityRepository.findAllByUserId(author);
    }

    public void addActivity(Activity newActivity) {
        activityRepository.save(newActivity);
    }
}
