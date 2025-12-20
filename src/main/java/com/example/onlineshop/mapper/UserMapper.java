package com.example.onlineshop.mapper;

import com.example.onlineshop.dto.UserRequestDto;
import com.example.onlineshop.dto.UserResponseDto;
import com.example.onlineshop.entity.UserEntity;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class UserMapper {

    private final RoleMapper roleMapper;

    public UserResponseDto toDto(UserEntity entity) {
        if (entity == null) {
            return null;
        }
        UserResponseDto dto = new UserResponseDto();
        dto.setId(entity.getId());
        dto.setUsername(entity.getUsername());
        dto.setEmail(entity.getEmail());
        if (entity.getRoleEntityList() != null) {
            dto.setRoles(entity.getRoleEntityList().stream()
                    .map(roleMapper::toDto)
                    .collect(Collectors.toList()));
        }
        return dto;
    }

    public UserEntity toEntity(UserRequestDto dto) {
        if (dto == null) {
            return null;
        }
        UserEntity entity = new UserEntity();
        entity.setUsername(dto.getUsername());
        entity.setPassword(dto.getPassword());
        entity.setEmail(dto.getEmail());
        return entity;
    }

    public void updateUserFromDto(UserRequestDto dto, UserEntity entity) {
        if (dto.getUsername() != null) {
            entity.setUsername(dto.getUsername());
        }
        if (dto.getEmail() != null) {
            entity.setEmail(dto.getEmail());
        }
        if (dto.getPassword() != null && !dto.getPassword().isEmpty()) {
            entity.setPassword(dto.getPassword());
        }
    }
}
