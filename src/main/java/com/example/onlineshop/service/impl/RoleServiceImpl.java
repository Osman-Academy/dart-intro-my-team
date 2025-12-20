package com.example.onlineshop.service.impl;

import com.example.onlineshop.entity.RoleEntity;
import com.example.onlineshop.entity.UserEntity;
import com.example.onlineshop.enumirations.ExceptionMessageCode;
import com.example.onlineshop.repository.RoleRepository;
import com.example.onlineshop.service.RoleService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import java.util.List;

@Service
@RequiredArgsConstructor
public class RoleServiceImpl implements RoleService {

    private final RoleRepository roleRepository;

    @Override
    public RoleEntity findByName(String name) {
        Assert.hasText(name, "Role name must not be empty");
        return roleRepository.findByName(name)
                .orElseThrow(() -> new RuntimeException(ExceptionMessageCode.ROLE_NOT_FOUND_NAME.getMessageCode()));
    }

    @Override
    public List<RoleEntity> findAllByUserEntities(List<UserEntity> userEntities) {
        return List.of();
    }

    @Override
    public boolean existsByName(String name) {
        Assert.hasText(name, "Role name must not be empty");
        return roleRepository.existsByName(name);
    }

    @Override
    public RoleEntity save(RoleEntity roleEntity) {
        Assert.notNull(roleEntity, "Role must not be null");
        Assert.hasText(roleEntity.getName(), "Role name must not be empty");

        if (roleRepository.existsByName(roleEntity.getName())) {
            throw new IllegalArgumentException("Role with name '" + roleEntity.getName() + "' already exists.");
        }
        return roleRepository.save(roleEntity);
    }

    @Override
    public RoleEntity getById(Long id) {
        Assert.notNull(id, "ID must not be null");
        return roleRepository.findById(id)
                .orElseThrow(() -> new RuntimeException(ExceptionMessageCode.ROLE_NOT_FOUND_BY_ID.getMessageCode()));
    }

    @Override
    public RoleEntity update(RoleEntity roleEntity) {
        Assert.notNull(roleEntity, "Role must not be null");
        Assert.notNull(roleEntity.getId(), "Role ID for update must not be null");

        RoleEntity existingRole = getById(roleEntity.getId());

        if (!existingRole.getName().equals(roleEntity.getName()) && roleRepository.existsByName(roleEntity.getName())) {
            throw new IllegalArgumentException("Role with name '" + roleEntity.getName() + "' already exists.");
        }

        existingRole.setName(roleEntity.getName());
        return roleRepository.save(existingRole);
    }

    @Override
    public void deleteById(Long id) {
        Assert.notNull(id, "ID must not be null");
        if (!roleRepository.existsById(id)) {
            throw new RuntimeException(ExceptionMessageCode.ROLE_NOT_FOUND_BY_ID.getMessageCode());
        }
        // In a real app, you would check if any users are assigned this role.
        roleRepository.deleteById(id);
    }

    @Override
    public void delete(RoleEntity entity) {
        Assert.notNull(entity, "Entity must not be null");
        roleRepository.delete(entity);
    }

    @Override
    public List<RoleEntity> getAll() {
        return roleRepository.findAll();
    }
}
