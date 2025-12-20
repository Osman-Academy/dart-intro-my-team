package com.example.onlineshop.mapper;

import com.example.onlineshop.dto.ProductDto;
import com.example.onlineshop.entity.CategoryEntity;
import com.example.onlineshop.entity.ProductEntity;
import com.example.onlineshop.enumirations.Status;
import com.example.onlineshop.service.CategoryService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

/**
 * Маппер для преобразования между сущностью ProductEntity и DTO ProductDto.
 * Отвечает за конвертацию данных о продукте из одного формата в другой.
 *
 * Для начинающего программиста:
 * Этот маппер более сложный, чем CategoryMapper, потому что ProductEntity
 * имеет связь с CategoryEntity. Маппер должен уметь правильно обрабатывать
 * эту связь, преобразуя ID категории в DTO в полноценный объект CategoryEntity
 * при создании сущности, и наоборот.
 */
@Component // Аннотация Spring: помечает класс как компонент.
@RequiredArgsConstructor // Аннотация Lombok для автоматического создания конструктора
// с полем categoryService, что позволяет Spring внедрить CategoryService.
public class ProductMapper {

    private final CategoryService categoryService; // Внедрение сервиса для работы с категориями.
    // Нужен для того, чтобы по categoryId из DTO найти соответствующую CategoryEntity.

    /**
     * Преобразует сущность ProductEntity в DTO ProductDto.
     *
     * @param entity Сущность ProductEntity, которую нужно преобразовать.
     * @return Соответствующий ProductDto, или null, если входная сущность была null.
     */
    public ProductDto toDto(ProductEntity entity) {
        // Проверяем, если входная сущность null, возвращаем null.
        if (entity == null) {
            return null;
        }
        // Создаем новый объект ProductDto.
        ProductDto dto = new ProductDto();
        // Копируем ID из сущности в DTO.
        dto.setId(entity.getId());
        // Копируем название продукта.
        dto.setName(entity.getName());
        // Копируем описание продукта.
        dto.setDescription(entity.getDescription());
        // Копируем цену продукта.
        dto.setPrice(entity.getPrice());
        // Копируем статус продукта. Здесь мы получаем строковое представление статуса из Enum.
        dto.setStatus(entity.getStatus().getName());
        // Копируем URL изображения.
        dto.setImageUrl(entity.getImageUrl());
        // Если у продукта есть категория, копируем её ID в DTO.
        if (entity.getCategory() != null) {
            dto.setCategoryId(entity.getCategory().getId());
        }
        // Возвращаем заполненный DTO.
        return dto;
    }

    /**
     * Преобразует DTO ProductDto в сущность ProductEntity.
     *
     * @param dto DTO ProductDto, которое нужно преобразовать.
     * @return Соответствующая сущность ProductEntity, или null, если входной DTO был null.
     */
    public ProductEntity toEntity(ProductDto dto) {
        // Проверяем, если входной DTO null, возвращаем null.
        if (dto == null) {
            return null;
        }
        // Создаем новый объект ProductEntity.
        ProductEntity entity = new ProductEntity();
        // Копируем ID из DTO в сущность.
        // TODO [Начинающий]: При создании нового продукта ID обычно не передается.
        //  Если ID в DTO не null, это может означать попытку создать продукт с заданным ID,
        //  что не всегда желательно. Рассмотрите логику, когда ID должен быть null при создании.
        entity.setId(dto.getId());
        // Копируем название продукта.
        entity.setName(dto.getName());
        // Копируем описание продукта.
        entity.setDescription(dto.getDescription());
        // Копируем цену продукта.
        entity.setPrice(dto.getPrice());
        // Копируем статус продукта.
        // Для начинающего программиста:
        // Здесь происходит преобразование строки статуса из DTO обратно в Enum Status.
        // Метод Status.valueOf(String name) ожидает точное имя константы Enum (например, "ACTIVE", "NEW").
        // Если в dto.getStatus() придет значение, которое не является именем константы Enum (например, "Активный" вместо "ACTIVE"),
        // то Status.valueOf() выбросит исключение IllegalArgumentException.
        // Текущая логика: если статус "ACTIVE", то устанавливается Status.ACTIVE, иначе пытается преобразовать строку в Enum.
        // Это может быть источником ошибок, если строковые значения в DTO не совпадают с именами констант Enum.
        // TODO [Начинающий]: Улучшите эту логику преобразования статуса.
        //  Возможно, стоит использовать метод Enum.fromName(String name) или Map для более гибкого преобразования.
        entity.setStatus(dto.getStatus().equals("ACTIVE") ? Status.ACTIVE : Status.valueOf(dto.getStatus()));
        // Копируем URL изображения.
        entity.setImageUrl(dto.getImageUrl());
        // Если в DTO указан ID категории, находим соответствующую CategoryEntity с помощью CategoryService.
        // Если категория не найдена, categoryService.getById() выбросит исключение.
        if (dto.getCategoryId() != null) {
            CategoryEntity category = categoryService.getById(dto.getCategoryId());
            entity.setCategory(category);
        }
        // Возвращаем заполненную сущность.
        return entity;
    }

    // TODO [Начинающий]: Добавьте метод 'updateEntityFromDto(ProductDto dto, ProductEntity entity)'.
    //  Этот метод будет принимать существующую сущность и обновлять её поля данными из DTO.
    //  Это полезно для операций PUT, чтобы не создавать новую сущность, а обновлять существующую.
    //  Убедитесь, что поля, которые не должны обновляться (например, createdAt), остаются неизменными.
}
