package com.example.onlineshop.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import java.util.List;

@Data
@Schema(description = "DTO for user information response")
public class UserResponseDto {

    @Schema(description = "Unique user identifier", example = "1")
    private Long id;

    @Schema(description = "Username (login)", example = "john_doe")
    private String username;

    @Schema(description = "User email address", example = "john.doe@example.com")
    private String email;

    @Schema(description = "List of roles assigned to the user")
    private List<RoleDto> roles;
}
