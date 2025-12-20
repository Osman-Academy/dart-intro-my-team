package com.example.onlineshop.service;

import com.example.onlineshop.entity.OrdersEntity;
import com.example.onlineshop.entity.UserEntity;

import java.time.LocalDateTime;
import java.util.List;

/**
 * Интерфейс сервиса для работы с сущностями OrdersEntity.
 * Расширяет базовый интерфейс BaseService, добавляя специфичные для заказов операции.
 *
 * Для начинающего программиста:
 * Этот интерфейс определяет, какие действия можно выполнять с заказами.
 * Он наследует все стандартные CRUD-операции от BaseService и добавляет
 * методы для поиска заказов по пользователю, статусу и дате.
 */
public interface OrderService extends BaseService<OrdersEntity> {
    // extends BaseService<OrdersEntity>: Указывает, что этот интерфейс наследует
    // все методы из BaseService, и что он работает конкретно с OrdersEntity.

    /**
     * Находит все заказы, сделанные определенным пользователем.
     *
     * @param user Сущность UserEntity, по которой нужно найти заказы.
     * @return Список OrdersEntity, сделанных указанным пользователем.
     */
    // TODO [Начинающий]: Рассмотрите изменение параметра на Long userId для удобства.
    //  List<OrdersEntity> findAllByUserId(Long userId);
    List<OrdersEntity> findAllByUser(UserEntity user);

    /**
     * Находит все заказы с указанным статусом.
     *
     * @param status Строковое представление статуса заказа для поиска.
     * @return Список OrdersEntity с указанным статусом.
     */
    // TODO [Начинающий]: Рассмотрите изменение параметра на Enum Status для типобезопасности.
    //  List<OrdersEntity> findAllByStatus(Status status);
    List<OrdersEntity> findAllByStatus(String status);

    /**
     * Находит все заказы, созданные в заданном временном диапазоне.
     *
     * @param startDate Начальная дата и время диапазона.
     * @param endDate Конечная дата и время диапазона.
     * @return Список OrdersEntity, созданных в указанном диапазоне.
     */
    List<OrdersEntity> findAllByOrderDateBetween(LocalDateTime startDate, LocalDateTime endDate);

    // TODO [Начинающий]: Добавьте метод для создания нового заказа, который будет принимать
    //  OrderDto и выполнять всю бизнес-логику (проверка товаров, расчет суммы, установка статуса).
    //  OrdersEntity createOrder(OrderDto orderDto);

    // TODO [Начинающий]: Добавьте метод для обновления существующего заказа, который будет принимать
    //  ID заказа и OrderDto, и выполнять бизнес-логику обновления (изменение статуса, позиций).
    //  OrdersEntity updateOrder(Long orderId, OrderDto orderDto);
}
