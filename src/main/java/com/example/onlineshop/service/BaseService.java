package com.example.onlineshop.service;

import com.example.onlineshop.entity.BaseEntity;

import java.util.List;

public interface BaseService <T extends BaseEntity> {

    T save(T t);
    T getById(Long id);
    T update(T t);
    void deleteById(Long id);
    void delete(T entity);
    List<T> getAll();

}
