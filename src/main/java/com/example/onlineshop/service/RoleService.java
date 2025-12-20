package com.example.onlineshop.service;

import com.example.onlineshop.entity.RoleEntity;
import com.example.onlineshop.entity.UserEntity;

import java.util.List;

public interface RoleService extends BaseService<RoleEntity> {
    RoleEntity findByName(String name);
    List<RoleEntity> findAllByUserEntities(List<UserEntity> userEntities);
    boolean existsByName(String name);
}
