package com.example.onlineshop.mapper;

import com.example.onlineshop.dto.RoleDto;
import com.example.onlineshop.entity.RoleEntity;
import org.springframework.stereotype.Component;

/**
 * Маппер для преобразования между сущностью RoleEntity и DTO RoleDto.
 * Отвечает за конвертацию данных о ролях из одного формата в другой.
 *
 * Для начинающего программиста:
 * Этот маппер очень похож на CategoryMapper, так как RoleEntity - это тоже
 * относительно простая сущность без сложных вложенных связей, которые нужно
 * разрешать через другие сервисы.
 */
@Component // Аннотация Spring: помечает класс как компонент.
public class RoleMapper {

    /**
     * Преобразует сущность RoleEntity в DTO RoleDto.
     *
     * @param entity Сущность RoleEntity, которую нужно преобразовать.
     * @return Соответствующий RoleDto, или null, если входная сущность была null.
     */
    public RoleDto toDto(RoleEntity entity) {
        // Проверяем, если входная сущность null, возвращаем null.
        if (entity == null) {
            return null;
        }
        // Создаем новый объект RoleDto.
        RoleDto dto = new RoleDto();
        // Копируем ID из сущности в DTO.
        dto.setId(entity.getId());
        // Копируем имя роли из сущности в DTO.
        dto.setName(entity.getName());
        // Возвращаем заполненный DTO.
        return dto;
    }

    /**
     * Преобразует DTO RoleDto в сущность RoleEntity.
     *
     * @param dto DTO RoleDto, которое нужно преобразовать.
     * @return Соответствующая сущность RoleEntity, или null, если входной DTO был null.
     */
    public RoleEntity toEntity(RoleDto dto) {
        // Проверяем, если входной DTO null, возвращаем null.
        if (dto == null) {
            return null;
        }
        // Создаем новый объект RoleEntity.
        RoleEntity entity = new RoleEntity();
        // Копируем ID из DTO в сущность.
        // TODO [Начинающий]: При создании новой роли ID обычно не передается.
        //  Если ID в DTO не null, это может означать попытку создать роль с заданным ID,
        //  что не всегда желательно. Рассмотрите логику, когда ID должен быть null при создании.
        entity.setId(dto.getId());
        // Копируем имя роли из DTO в сущность.
        entity.setName(dto.getName());
        // Возвращаем заполненную сущность.
        return entity;
    }

    // TODO [Начинающий]: Добавьте метод 'updateEntityFromDto(RoleDto dto, RoleEntity entity)'.
    //  Этот метод будет принимать существующую сущность и обновлять её поля данными из DTO.
    //  Это полезно для операций PUT, чтобы не создавать новую сущность, а обновлять существующую.
}
