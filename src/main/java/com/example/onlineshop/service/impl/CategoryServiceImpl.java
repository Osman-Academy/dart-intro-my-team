package com.example.onlineshop.service.impl;

import com.example.onlineshop.entity.CategoryEntity;
import com.example.onlineshop.enumirations.ExceptionMessageCode;
import com.example.onlineshop.repository.CategoryRepository;
import com.example.onlineshop.service.CategoryService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CategoryServiceImpl implements CategoryService {

    private final CategoryRepository categoryRepository;

    @Override
    public CategoryEntity findByName(String name) {
        Assert.hasText(name, "Category name must not be empty");
        return categoryRepository.findByName(name)
                .orElseThrow(() -> new RuntimeException(ExceptionMessageCode.CATEGORY_NOT_FOUND_NAME.getMessageCode()));
    }

    @Override
    public CategoryEntity save(CategoryEntity categoryEntity) {
        Assert.notNull(categoryEntity, "Category must not be null");
        Assert.hasText(categoryEntity.getName(), "Category name must not be empty");

        if (categoryRepository.existsByName(categoryEntity.getName())) {
            throw new IllegalArgumentException("Category with name '" + categoryEntity.getName() + "' already exists.");
        }
        return categoryRepository.save(categoryEntity);
    }

    @Override
    public CategoryEntity getById(Long id) {
        Assert.notNull(id, "ID must not be null");
        return categoryRepository.findById(id)
                .orElseThrow(() -> new RuntimeException(ExceptionMessageCode.CATEGORY_NOT_FOUND_ID.getMessageCode()));
    }

    @Override
    public CategoryEntity update(CategoryEntity categoryEntity) {
        Assert.notNull(categoryEntity, "Category must not be null");
        Assert.notNull(categoryEntity.getId(), "Category ID for update must not be null");

        CategoryEntity existingCategory = getById(categoryEntity.getId());

        // Check if the name is being changed and if the new name is already taken
        if (!existingCategory.getName().equals(categoryEntity.getName()) && categoryRepository.existsByName(categoryEntity.getName())) {
            throw new IllegalArgumentException("Category with name '" + categoryEntity.getName() + "' already exists.");
        }

        existingCategory.setName(categoryEntity.getName());
        return categoryRepository.save(existingCategory);
    }

    @Override
    public void deleteById(Long id) {
        Assert.notNull(id, "ID must not be null");
        if (!categoryRepository.existsById(id)) {
            throw new RuntimeException(ExceptionMessageCode.CATEGORY_NOT_FOUND_ID.getMessageCode());
        }
        // Basic check: In a real application, you'd check if products are linked to this category.
        // For simplicity, we'll just delete it.
        categoryRepository.deleteById(id);
    }

    @Override
    public void delete(CategoryEntity entity) {
        Assert.notNull(entity, "Entity must not be null");
        categoryRepository.delete(entity);
    }

    @Override
    public List<CategoryEntity> getAll() {
        return categoryRepository.findAll();
    }
}
