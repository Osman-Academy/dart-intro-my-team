package com.example.onlineshop.service.impl;

import com.example.onlineshop.entity.OrderItemEntity;
import com.example.onlineshop.entity.ProductEntity;
import com.example.onlineshop.enumirations.ExceptionMessageCode;
import com.example.onlineshop.enumirations.Status;
import com.example.onlineshop.repository.ProductRepository;
import com.example.onlineshop.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import java.math.BigDecimal;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ProductServiceImpl implements ProductService {

    private final ProductRepository productRepository;

    @Override
    public ProductEntity getByName(String name) {
        Assert.hasText(name, "Product name must not be empty");
        return productRepository.findByName(name)
                .orElseThrow(() -> new RuntimeException(ExceptionMessageCode.PRODUCT_NOT_FOUND_NAME.getMessageCode()));
    }

    @Override
    public List<ProductEntity> findAllByDescriptionContains(String description) {
        Assert.hasText(description, "Description must not be empty");
        return productRepository.findAllByDescriptionContainingIgnoreCase(description);
    }

    @Override
    public List<ProductEntity> findAllByPrice(BigDecimal price) {
        return List.of();
    }

    @Override
    public List<ProductEntity> findAllByStatus(String status) {
        return List.of();
    }

    @Override
    public List<ProductEntity> findAllByOrderItemEntityList(List<OrderItemEntity> orderItemEntityList) {
        return List.of();
    }

    @Override
    public List<ProductEntity> findByImageUrl(String imageUrl) {
        return List.of();
    }

    @Override
    public ProductEntity save(ProductEntity productEntity) {
        Assert.notNull(productEntity, "Product must not be null");
        Assert.hasText(productEntity.getName(), "Product name must not be empty");

        if (productRepository.existsByName(productEntity.getName())) {
            throw new IllegalArgumentException("Product with name '" + productEntity.getName() + "' already exists.");
        }
        if (productEntity.getStatus() == null) {
            productEntity.setStatus(Status.AVAILABLE);
        }
        return productRepository.save(productEntity);
    }

    @Override
    public ProductEntity getById(Long id) {
        Assert.notNull(id, "ID must not be null");
        return productRepository.findById(id)
                .orElseThrow(() -> new RuntimeException(ExceptionMessageCode.PRODUCT_NOT_FOUND_ID.getMessageCode()));
    }

    @Override
    public ProductEntity update(ProductEntity productEntity) {
        Assert.notNull(productEntity, "Product must not be null");
        Assert.notNull(productEntity.getId(), "Product ID for update must not be null");

        ProductEntity existingProduct = getById(productEntity.getId());

        if (!existingProduct.getName().equals(productEntity.getName()) && productRepository.existsByName(productEntity.getName())) {
            throw new IllegalArgumentException("Product with name '" + productEntity.getName() + "' already exists.");
        }

        existingProduct.setName(productEntity.getName());
        existingProduct.setDescription(productEntity.getDescription());
        existingProduct.setPrice(productEntity.getPrice());
        existingProduct.setStatus(productEntity.getStatus());
        existingProduct.setImageUrl(productEntity.getImageUrl());
        existingProduct.setCategory(productEntity.getCategory());

        return productRepository.save(existingProduct);
    }

    @Override
    public void deleteById(Long id) {
        Assert.notNull(id, "ID must not be null");
        if (!productRepository.existsById(id)) {
            throw new RuntimeException(ExceptionMessageCode.PRODUCT_NOT_FOUND_ID.getMessageCode());
        }
        // In a real app, you would check if the product is in any active orders.
        // For simplicity, we just delete it.
        productRepository.deleteById(id);
    }

    @Override
    public void delete(ProductEntity entity) {
        Assert.notNull(entity, "Entity must not be null");
        productRepository.delete(entity);
    }

    @Override
    public List<ProductEntity> getAll() {
        return productRepository.findAll();
    }
}
