package com.example.onlineshop.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
@Schema(description = "DTO for user role data transfer")
public class RoleDto {

    @Schema(description = "Unique role identifier", example = "1")
    private Long id;

    @Schema(description = "Role name", example = "ROLE_USER")
    private String name;
}
