package com.example.onlineshop.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Data;
import java.math.BigDecimal;

@Data
@Schema(description = "DTO for product data transfer")
public class ProductDto {

    @Schema(description = "Unique product identifier", example = "101")
    private Long id;

    @NotBlank(message = "Product name cannot be blank")
    @Size(min = 3, max = 255, message = "Product name must be between 3 and 255 characters")
    @Schema(description = "Product name", example = "Smartphone XYZ")
    private String name;

    @Schema(description = "Detailed product description", example = "Powerful smartphone with 6.5-inch screen and triple camera.")
    private String description;

    @NotNull(message = "Price cannot be null")
    @DecimalMin(value = "0.0", inclusive = false, message = "Price must be greater than 0")
    @Schema(description = "Product price", example = "599.99")
    private BigDecimal price;

    @Schema(description = "Product status (e.g., AVAILABLE, OUT_OF_STOCK)", example = "AVAILABLE")
    private String status;

    @Schema(description = "Product image URL", example = "http://example.com/images/smartphone.jpg")
    private String imageUrl;

    @NotNull(message = "Category ID cannot be null")
    @Schema(description = "Identifier of the category the product belongs to", example = "1")
    private Long categoryId;
}
