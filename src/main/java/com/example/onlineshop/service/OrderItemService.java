package com.example.onlineshop.service;

import com.example.onlineshop.entity.OrderItemEntity;
import com.example.onlineshop.entity.OrdersEntity;
import com.example.onlineshop.entity.ProductEntity;

import java.util.List;


public interface OrderItemService extends BaseService<OrderItemEntity> {

    List<OrderItemEntity> findAllByOrder(OrdersEntity order);


    List<OrderItemEntity> findAllByProduct(ProductEntity product);

}
