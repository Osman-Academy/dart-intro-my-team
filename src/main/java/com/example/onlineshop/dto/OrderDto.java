package com.example.onlineshop.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Data
@Schema(description = "DTO for order data transfer")
public class OrderDto {

    @Schema(description = "Unique order identifier", example = "1")
    private Long id;

    @NotNull(message = "User ID cannot be null")
    @Schema(description = "Identifier of the user who placed the order", example = "1")
    private Long userId;

    @Schema(description = "Current order status (e.g., NEW, PROCESSING, SHIPPED, DELIVERED)", example = "NEW")
    private String status;

    @Schema(description = "Total order amount", example = "129.99")
    private BigDecimal totalAmount;

    @Schema(description = "Date and time of order creation", example = "2023-10-26T10:00:00")
    private LocalDateTime createdAt;

    @NotEmpty(message = "Order must have at least one item")
    @Valid
    @Schema(description = "List of items in the order")
    private List<OrderItemDto> items;
}
