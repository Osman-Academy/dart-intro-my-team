package com.example.onlineshop.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import java.math.BigDecimal;

@Data
@Schema(description = "DTO for order item data transfer")
public class OrderItemDto {

    @Schema(description = "Unique order item identifier", example = "1")
    private Long id;

    @NotNull(message = "Product ID cannot be null")
    @Schema(description = "Identifier of the product in the order item", example = "101")
    private Long productId;

    @NotNull(message = "Quantity cannot be null")
    @Min(value = 1, message = "Quantity must be at least 1")
    @Schema(description = "Quantity of the product in this order item", example = "2")
    private Integer quantity;

    @Schema(description = "Price of the product at the time of purchase", example = "29.99")
    private BigDecimal priceAtPurchase;
}
