package com.example.onlineshop.mapper;

import com.example.onlineshop.dto.CategoryDto;
import com.example.onlineshop.entity.CategoryEntity;
import org.springframework.stereotype.Component;

/**
 * Маппер для преобразования между сущностью CategoryEntity и DTO CategoryDto.
 * Отвечает за конвертацию данных из одного формата в другой.
 *
 * Для начинающего программиста:
 * Маппер - это "переводчик". Когда вы получаете данные от клиента (в виде DTO)
 * и хотите сохранить их в базу данных (в виде Entity), маппер "переводит" DTO в Entity.
 * И наоборот, когда вы достаете данные из базы данных (Entity) и хотите отправить
 * их клиенту (в виде DTO), маппер "переводит" Entity в DTO.
 * Это помогает разделить слои приложения и избежать прямого использования Entity
 * в контроллерах или при передаче данных по сети.
 */
@Component // Аннотация Spring: помечает класс как компонент, который может быть
// автоматически обнаружен и внедрен Spring'ом в другие классы.
public class CategoryMapper {

    /**
     * Преобразует сущность CategoryEntity в DTO CategoryDto.
     *
     * @param entity Сущность CategoryEntity, которую нужно преобразовать.
     * @return Соответствующий CategoryDto, или null, если входная сущность была null.
     */
    public CategoryDto toDto(CategoryEntity entity) {
        // Проверяем, если входная сущность null, возвращаем null, чтобы избежать NullPointerException.
        if (entity == null) {
            return null;
        }
        // Создаем новый объект CategoryDto.
        CategoryDto dto = new CategoryDto();
        // Копируем ID из сущности в DTO.
        dto.setId(entity.getId());
        // Копируем имя из сущности в DTO.
        dto.setName(entity.getName());
        // Возвращаем заполненный DTO.
        return dto;
    }

    /**
     * Преобразует DTO CategoryDto в сущность CategoryEntity.
     *
     * @param dto DTO CategoryDto, которое нужно преобразовать.
     * @return Соответствующая сущность CategoryEntity, или null, если входной DTO был null.
     */
    public CategoryEntity toEntity(CategoryDto dto) {
        // Проверяем, если входной DTO null, возвращаем null.
        if (dto == null) {
            return null;
        }
        // Создаем новый объект CategoryEntity.
        CategoryEntity entity = new CategoryEntity();
        // Копируем ID из DTO в сущность.
        // TODO [Начинающий]: При создании новой категории ID обычно не передается.
        //  Если ID в DTO не null, это может означать попытку создать категорию с заданным ID,
        //  что не всегда желательно. Рассмотрите логику, когда ID должен быть null при создании.
        entity.setId(dto.getId());
        // Копируем имя из DTO в сущность.
        entity.setName(dto.getName());
        // Возвращаем заполненную сущность.
        return entity;
    }

    // TODO [Начинающий]: Добавьте метод 'updateEntityFromDto(CategoryDto dto, CategoryEntity entity)'.
    //  Этот метод будет принимать существующую сущность и обновлять её поля данными из DTO.
    //  Это полезно для операций PUT, чтобы не создавать новую сущность, а обновлять существующую.
}
