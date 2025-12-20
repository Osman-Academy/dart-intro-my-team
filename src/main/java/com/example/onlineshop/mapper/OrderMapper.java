package com.example.onlineshop.mapper;

import com.example.onlineshop.dto.OrderDto;
import com.example.onlineshop.entity.OrdersEntity;
import com.example.onlineshop.entity.UserEntity;
import com.example.onlineshop.enumirations.Status;
import com.example.onlineshop.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class OrderMapper {

    private final UserService userService;
    private final OrderItemMapper orderItemMapper;

    public OrderDto toDto(OrdersEntity entity) {
        if (entity == null) {
            return null;
        }
        OrderDto dto = new OrderDto();
        dto.setId(entity.getId());
        dto.setStatus(entity.getStatus().getName());
        dto.setTotalAmount(entity.getTotalAmount());
        dto.setCreatedAt(entity.getCreatedAt());

        if (entity.getUserEntity() != null) {
            dto.setUserId(entity.getUserEntity().getId());
        }
        if (entity.getOrderItemEntityList() != null) {
            dto.setItems(entity.getOrderItemEntityList().stream()
                    .map(orderItemMapper::toDto)
                    .collect(Collectors.toList()));
        }
        return dto;
    }

    public OrdersEntity toEntity(OrderDto dto) {
        if (dto == null) {
            return null;
        }
        OrdersEntity entity = new OrdersEntity();
        entity.setStatus(dto.getStatus().equals("NEW") ? Status.NEW : Status.valueOf(dto.getStatus()));
        entity.setTotalAmount(dto.getTotalAmount());

        if (dto.getUserId() != null) {
            UserEntity user = userService.getById(dto.getUserId());
            entity.setUserEntity(user);
        }
        if (dto.getItems() != null) {
            entity.setOrderItemEntityList(dto.getItems().stream()
                    .map(orderItemMapper::toEntity)
                    .collect(Collectors.toList()));
        }
        return entity;
    }
}
