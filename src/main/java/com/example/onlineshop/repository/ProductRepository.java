package com.example.onlineshop.repository;

import com.example.onlineshop.entity.CategoryEntity;
import com.example.onlineshop.entity.ProductEntity;
import com.example.onlineshop.enumirations.Status;
import org.springframework.data.jpa.repository.JpaRepository;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

public interface ProductRepository extends JpaRepository<ProductEntity, Long> {

    Optional<ProductEntity> findByName(String name);

    boolean existsByName(String name);

    List<ProductEntity> findAllByDescriptionContainingIgnoreCase(String description);


}
