package com.example.onlineshop.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "users")
public class UserEntity extends BaseEntity {

    @Column(nullable = false, unique = true, length = 50)
    private String username;

    @Column(nullable = false)
    private String password;

    @Column(nullable = false, unique = true, length = 100)
    private String email;

    @ManyToMany(fetch = FetchType.EAGER, mappedBy = "userEntities")
    private List<RoleEntity> roleEntityList;

    @OneToMany(mappedBy = "userEntity", fetch = FetchType.LAZY)
    private List<OrdersEntity> ordersEntityList;
}
