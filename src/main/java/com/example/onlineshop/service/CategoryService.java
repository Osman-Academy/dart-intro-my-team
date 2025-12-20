package com.example.onlineshop.service;

import com.example.onlineshop.entity.CategoryEntity;

public interface CategoryService extends BaseService<CategoryEntity> {
    CategoryEntity findByName(String name);

}
