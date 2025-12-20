package com.example.onlineshop.service.impl;

import com.example.onlineshop.entity.OrderItemEntity;
import com.example.onlineshop.entity.OrdersEntity;
import com.example.onlineshop.entity.ProductEntity;
import com.example.onlineshop.enumirations.ExceptionMessageCode;
import com.example.onlineshop.repository.OrderItemRepository;
import com.example.onlineshop.service.OrderItemService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import java.util.List;

@Service
@RequiredArgsConstructor
public class OrderItemServiceImpl implements OrderItemService {

    private final OrderItemRepository orderItemRepository;

    @Override
    public List<OrderItemEntity> findAllByOrder(OrdersEntity order) {
        Assert.notNull(order, "Order must not be null");
        return orderItemRepository.findAllByOrdersEntity(order);
    }

    @Override
    public List<OrderItemEntity> findAllByProduct(ProductEntity product) {
        Assert.notNull(product, "Product must not be null");
        return orderItemRepository.findAllByProductEntity(product);
    }

    @Override
    public OrderItemEntity save(OrderItemEntity orderItemEntity) {
        Assert.notNull(orderItemEntity, "Order item must not be null");
        Assert.notNull(orderItemEntity.getProductEntity(), "Order item must have a product");
        Assert.notNull(orderItemEntity.getOrdersEntity(), "Order item must belong to an order");
        Assert.isTrue(orderItemEntity.getQuantity() > 0, "Quantity must be positive");

        return orderItemRepository.save(orderItemEntity);
    }

    @Override
    public OrderItemEntity getById(Long id) {
        Assert.notNull(id, "ID must not be null");
        return orderItemRepository.findById(id)
                .orElseThrow(() -> new RuntimeException(ExceptionMessageCode.ORDER_ITEM_NOT_FOUND_ID.getMessageCode()));
    }

    @Override
    public OrderItemEntity update(OrderItemEntity orderItemEntity) {
        Assert.notNull(orderItemEntity, "Order item must not be null");
        Assert.notNull(orderItemEntity.getId(), "Order item ID for update must not be null");

        OrderItemEntity existingItem = getById(orderItemEntity.getId());
        existingItem.setQuantity(orderItemEntity.getQuantity());
        // In a real app, you might re-calculate prices or check stock here.

        return orderItemRepository.save(existingItem);
    }

    @Override
    public void deleteById(Long id) {
        Assert.notNull(id, "ID must not be null");
        if (!orderItemRepository.existsById(id)) {
            throw new RuntimeException(ExceptionMessageCode.ORDER_ITEM_NOT_FOUND_ID.getMessageCode());
        }
        orderItemRepository.deleteById(id);
    }

    @Override
    public void delete(OrderItemEntity entity) {
        Assert.notNull(entity, "Entity must not be null");
        orderItemRepository.delete(entity);
    }

    @Override
    public List<OrderItemEntity> getAll() {
        return orderItemRepository.findAll();
    }
}
