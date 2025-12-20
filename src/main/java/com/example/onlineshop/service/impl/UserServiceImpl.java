package com.example.onlineshop.service.impl;

import com.example.onlineshop.entity.RoleEntity;
import com.example.onlineshop.entity.UserEntity;
import com.example.onlineshop.enumirations.ExceptionMessageCode;
import com.example.onlineshop.repository.UserRepository;
import com.example.onlineshop.service.RoleService;
import com.example.onlineshop.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import java.util.List;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;
    private final RoleService roleService;

    @Override
    public UserEntity findByUsername(String username) {
        Assert.hasText(username, "Username must not be empty");
        return userRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException(ExceptionMessageCode.USER_NOT_FOUND_USERNAME.getMessageCode()));
    }

    @Override
    public UserEntity findByEmail(String email) {
        Assert.hasText(email, "Email must not be empty");
        return userRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException(ExceptionMessageCode.USER_NOT_FOUND_EMAIL.getMessageCode()));
    }

    @Override
    public boolean existsByUsername(String username) {
        Assert.hasText(username, "Username must not be empty");
        return userRepository.existsByUsername(username);
    }

    @Override
    public boolean existsByEmail(String email) {
        Assert.hasText(email, "Email must not be empty");
        return userRepository.existsByEmail(email);
    }

    @Override
    public UserEntity save(UserEntity userEntity) {
        Assert.notNull(userEntity, "User must not be null");
        Assert.hasText(userEntity.getUsername(), "Username must not be empty");
        Assert.hasText(userEntity.getEmail(), "Email must not be empty");
        Assert.hasText(userEntity.getPassword(), "Password must not be empty");

        if (userRepository.existsByUsername(userEntity.getUsername())) {
            throw new IllegalArgumentException("User with username '" + userEntity.getUsername() + "' already exists.");
        }
        if (userRepository.existsByEmail(userEntity.getEmail())) {
            throw new IllegalArgumentException("User with email '" + userEntity.getEmail() + "' already exists.");
        }



        // Assign default role
        RoleEntity userRole = roleService.findByName("ROLE_USER");
        userEntity.setRoleEntityList(List.of(userRole));

        return userRepository.save(userEntity);
    }

    @Override
    public UserEntity getById(Long id) {
        Assert.notNull(id, "ID must not be null");
        return userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException(ExceptionMessageCode.USER_NOT_FOUND_ID.getMessageCode()));
    }

    @Override
    public UserEntity update(UserEntity userEntity) {
        Assert.notNull(userEntity, "User must not be null");
        Assert.notNull(userEntity.getId(), "User ID for update must not be null");

        UserEntity existingUser = getById(userEntity.getId());

        if (userEntity.getEmail() != null && !existingUser.getEmail().equals(userEntity.getEmail())) {
            if (userRepository.existsByEmail(userEntity.getEmail())) {
                throw new IllegalArgumentException("User with email '" + userEntity.getEmail() + "' already exists.");
            }
            existingUser.setEmail(userEntity.getEmail());
        }

        if (userEntity.getUsername() != null && !existingUser.getUsername().equals(userEntity.getUsername())) {
            if (userRepository.existsByUsername(userEntity.getUsername())) {
                throw new IllegalArgumentException("User with username '" + userEntity.getUsername() + "' already exists.");
            }
            existingUser.setUsername(userEntity.getUsername());
        }

        if (userEntity.getPassword() != null && !userEntity.getPassword().isEmpty()) {
            existingUser.setPassword(userEntity.getPassword());
        }

        return userRepository.save(existingUser);
    }

    @Override
    public void deleteById(Long id) {
        Assert.notNull(id, "ID must not be null");
        if (!userRepository.existsById(id)) {
            throw new RuntimeException(ExceptionMessageCode.USER_NOT_FOUND_ID.getMessageCode());
        }
        // In a real app, you would check for active orders or other dependencies.
        userRepository.deleteById(id);
    }

    @Override
    public void delete(UserEntity entity) {
        Assert.notNull(entity, "Entity must not be null");
        userRepository.delete(entity);
    }

    @Override
    public List<UserEntity> getAll() {
        return userRepository.findAll();
    }
}
