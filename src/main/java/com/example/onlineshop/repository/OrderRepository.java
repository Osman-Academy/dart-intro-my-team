package com.example.onlineshop.repository;

import com.example.onlineshop.entity.OrdersEntity;
import com.example.onlineshop.entity.UserEntity;
import com.example.onlineshop.enumirations.Status;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDateTime;
import java.util.List;

public interface OrderRepository extends JpaRepository<OrdersEntity, Long> {

    List<OrdersEntity> findAllByUserEntity(UserEntity userEntity);


    List<OrdersEntity> findAllByStatus(Status status);

    List<OrdersEntity> findAllByCreatedAtBetween(LocalDateTime start, LocalDateTime end);

}
