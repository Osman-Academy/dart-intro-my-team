package com.example.onlineshop.service;

import com.example.onlineshop.entity.UserEntity;

public interface UserService extends BaseService<UserEntity> {

    UserEntity findByUsername(String username);
    UserEntity findByEmail(String email);
    boolean existsByUsername(String username);
    boolean existsByEmail(String email);
}
