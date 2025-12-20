package com.example.onlineshop.mapper;

import com.example.onlineshop.dto.OrderItemDto;
import com.example.onlineshop.entity.OrderItemEntity;
import com.example.onlineshop.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

/**
 * Маппер для преобразования между сущностью OrderItemEntity и DTO OrderItemDto.
 * Отвечает за конвертацию данных о позициях заказа.
 *
 * Для начинающего программиста:
 * Этот маппер обрабатывает одну позицию в заказе. Он должен уметь
 * преобразовывать ID продукта из DTO в полноценный объект ProductEntity
 * при создании сущности, и наоборот.
 */
@Component // Аннотация Spring: помечает класс как компонент.
@RequiredArgsConstructor // Аннотация Lombok для автоматического создания конструктора
// с полем productService, что позволяет Spring внедрить ProductService.
public class OrderItemMapper {

    private final ProductService productService; // Внедрение сервиса для работы с продуктами.
    // Нужен для того, чтобы по productId из DTO найти соответствующую ProductEntity.

    /**
     * Преобразует сущность OrderItemEntity в DTO OrderItemDto.
     *
     * @param entity Сущность OrderItemEntity, которую нужно преобразовать.
     * @return Соответствующий OrderItemDto, или null, если входная сущность была null.
     */
    public OrderItemDto toDto(OrderItemEntity entity) {
        // Проверяем, если входная сущность null, возвращаем null.
        if (entity == null) {
            return null;
        }
        // Создаем новый объект OrderItemDto.
        OrderItemDto dto = new OrderItemDto();
        // Копируем ID из сущности в DTO.
        dto.setId(entity.getId());
        // Копируем количество продукта.
        dto.setQuantity(entity.getQuantity());
        // Копируем цену на момент покупки.
        dto.setPriceAtPurchase(entity.getPriceAtPurchase());
        // Если у позиции заказа есть связанный продукт, копируем его ID в DTO.
        if (entity.getProductEntity() != null) {
            dto.setProductId(entity.getProductEntity().getId());
        }
        // Возвращаем заполненный DTO.
        return dto;
    }

    /**
     * Преобразует DTO OrderItemDto в сущность OrderItemEntity.
     *
     * @param dto DTO OrderItemDto, которое нужно преобразовать.
     * @return Соответствующая сущность OrderItemEntity, или null, если входной DTO был null.
     */
    public OrderItemEntity toEntity(OrderItemDto dto) {
        // Проверяем, если входной DTO null, возвращаем null.
        if (dto == null) {
            return null;
        }
        // Создаем новый объект OrderItemEntity.
        OrderItemEntity entity = new OrderItemEntity();
        // Копируем ID из DTO в сущность.
        // TODO [Начинающий]: При создании новой позиции заказа ID обычно не передается.
        //  Если ID в DTO не null, это может означать попытку создать позицию с заданным ID,
        //  что не всегда желательно. Рассмотрите логику, когда ID должен быть null при создании.
        // entity.setId(dto.getId()); // Закомментировано, так как ID обычно генерируется БД.
        // Копируем количество продукта.
        entity.setQuantity(dto.getQuantity());
        // Копируем цену на момент покупки.
        entity.setPriceAtPurchase(dto.getPriceAtPurchase());
        // Если в DTO указан ID продукта, находим соответствующую ProductEntity с помощью ProductService.
        // Если продукт не найден, productService.getById() выбросит исключение.
        if (dto.getProductId() != null) {
            entity.setProductEntity(productService.getById(dto.getProductId()));
        }
        // Возвращаем заполненную сущность.
        return entity;
    }

    // TODO [Начинающий]: Добавьте метод 'updateEntityFromDto(OrderItemDto dto, OrderItemEntity entity)'.
    //  Этот метод будет принимать существующую сущность и обновлять её поля данными из DTO.
    //  Это полезно для операций PUT, чтобы не создавать новую сущность, а обновлять существующую.
}
