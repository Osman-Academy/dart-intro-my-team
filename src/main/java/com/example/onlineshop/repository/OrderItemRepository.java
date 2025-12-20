package com.example.onlineshop.repository;

import com.example.onlineshop.entity.OrderItemEntity;
import com.example.onlineshop.entity.OrdersEntity;
import com.example.onlineshop.entity.ProductEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface OrderItemRepository extends JpaRepository<OrderItemEntity, Long> {

    List<OrderItemEntity> findAllByOrdersEntity(OrdersEntity ordersEntity);

    List<OrderItemEntity> findAllByProductEntity(ProductEntity productEntity);

}
