package com.example.onlineshop.service;

import com.example.onlineshop.entity.OrderItemEntity;
import com.example.onlineshop.entity.ProductEntity;

import java.math.BigDecimal;
import java.util.List;


public interface ProductService extends BaseService<ProductEntity>{

    ProductEntity getByName(String name);

    List<ProductEntity> findAllByDescriptionContains(String description);

    List<ProductEntity> findAllByPrice(BigDecimal price);

    List<ProductEntity> findAllByStatus(String status);

    List<ProductEntity> findAllByOrderItemEntityList(List<OrderItemEntity> orderItemEntityList);

    List<ProductEntity> findByImageUrl(String imageUrl);

}
