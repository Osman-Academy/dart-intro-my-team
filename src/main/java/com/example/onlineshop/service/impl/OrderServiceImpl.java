package com.example.onlineshop.service.impl;

import com.example.onlineshop.entity.OrdersEntity;
import com.example.onlineshop.entity.UserEntity;
import com.example.onlineshop.enumirations.ExceptionMessageCode;
import com.example.onlineshop.enumirations.Status;
import com.example.onlineshop.repository.OrderRepository;
import com.example.onlineshop.service.OrderService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class OrderServiceImpl implements OrderService {

    private final OrderRepository orderRepository;

    @Override
    public List<OrdersEntity> findAllByUser(UserEntity user) {
        Assert.notNull(user, "User must not be null");
        return orderRepository.findAllByUserEntity(user);
    }

    @Override
    public List<OrdersEntity> findAllByStatus(String status) {
        Assert.hasText(status, "Status must not be empty");
        try {
            Status statusEnum = Status.valueOf(status.toUpperCase());
            return orderRepository.findAllByStatus(statusEnum);
        } catch (IllegalArgumentException e) {
            throw new IllegalArgumentException("Invalid status value: " + status);
        }
    }

    @Override
    public List<OrdersEntity> findAllByOrderDateBetween(LocalDateTime startDate, LocalDateTime endDate) {
        Assert.notNull(startDate, "Start date must not be null");
        Assert.notNull(endDate, "End date must not be null");
        return orderRepository.findAllByCreatedAtBetween(startDate, endDate);
    }

    @Override
    @Transactional
    public OrdersEntity save(OrdersEntity ordersEntity) {
        Assert.notNull(ordersEntity, "Order must not be null");
        Assert.notNull(ordersEntity.getUserEntity(), "Order must have a user");
        Assert.notEmpty(ordersEntity.getOrderItemEntityList(), "Order must have at least one item");

        // Set initial status and creation date
        ordersEntity.setStatus(Status.NEW);

        // Calculate total amount and set bidirectional links
        BigDecimal totalAmount = BigDecimal.ZERO;
        for (var item : ordersEntity.getOrderItemEntityList()) {
            Assert.notNull(item.getProductEntity(), "Order item must have a product");
            Assert.isTrue(item.getQuantity() > 0, "Order item quantity must be positive");

            // Set price at purchase from the product's current price
            item.setPriceAtPurchase(item.getProductEntity().getPrice());
            totalAmount = totalAmount.add(item.getPriceAtPurchase().multiply(BigDecimal.valueOf(item.getQuantity())));
            item.setOrdersEntity(ordersEntity); // Set bidirectional link
        }
        ordersEntity.setTotalAmount(totalAmount);

        return orderRepository.save(ordersEntity);
    }

    @Override
    public OrdersEntity getById(Long id) {
        Assert.notNull(id, "ID must not be null");
        return orderRepository.findById(id)
                .orElseThrow(() -> new RuntimeException(ExceptionMessageCode.ORDER_NOT_FOUND_ID.getMessageCode()));
    }

    @Override
    @Transactional
    public OrdersEntity update(OrdersEntity ordersEntity) {
        Assert.notNull(ordersEntity, "Order must not be null");
        Assert.notNull(ordersEntity.getId(), "Order ID for update must not be null");

        OrdersEntity existingOrder = getById(ordersEntity.getId());

        // Business logic for status update
        if (ordersEntity.getStatus() != null) {
            // Example: prevent changing status from a final state
            if (existingOrder.getStatus() == Status.DELIVERED || existingOrder.getStatus() == Status.CANCELLED) {
                throw new IllegalStateException("Cannot update an order that is already " + existingOrder.getStatus());
            }
            existingOrder.setStatus(ordersEntity.getStatus());
        }

        // In a real application, updating items would be a more complex process
        // For now, we just save the updated status.
        return orderRepository.save(existingOrder);
    }

    @Override
    public void deleteById(Long id) {
        Assert.notNull(id, "ID must not be null");
        if (!orderRepository.existsById(id)) {
            throw new RuntimeException(ExceptionMessageCode.ORDER_NOT_FOUND_ID.getMessageCode());
        }
        // In a real application, you might change status to CANCELLED instead of deleting
        orderRepository.deleteById(id);
    }

    @Override
    public void delete(OrdersEntity entity) {
        Assert.notNull(entity, "Entity must not be null");
        orderRepository.delete(entity);
    }

    @Override
    public List<OrdersEntity> getAll() {
        return orderRepository.findAll();
    }
}
