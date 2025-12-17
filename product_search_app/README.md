# Product Search App (Flutter) — готово к сдаче

Проект демонстрирует все требования:

- ✅ **Автогенерация модели Freezed** (entity, dto, bloc state)
- ✅ **Запросы на сервер** через **Dio** (FakeStore API)
- ✅ **Clean Architecture** (presentation / domain / data)
- ✅ **Поиск товаров** по названию/описанию (локальная фильтрация после загрузки)

## Быстрый запуск в VS Code

1) Распакуй ZIP и открой папку в **Visual Studio Code**  
2) В терминале:

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

> Если у тебя нет эмулятора, можно запускать на телефоне (USB debugging) или в Chrome:
```bash
flutter run -d chrome
```

## Как проверить требования (на защите)

- **Freezed**: открой `lib/features/products/domain/entities/product.dart` и `lib/features/products/presentation/bloc/products_state.dart` — файлы `.freezed.dart` и `.g.dart` генерируются командой build_runner.
- **Server requests**: `ProductRemoteDataSource` делает GET на `https://fakestoreapi.com/products`
- **Clean architecture**:
  - Domain: entity, repository interface, usecases
  - Data: dto, datasource, repository implementation
  - Presentation: bloc + UI
- **Search**: ввод в поле поиска мгновенно фильтрует список товаров.

## Структура

```
lib/
  core/
    di/
    error/
    network/
    utils/
  features/
    products/
      data/
      domain/
      presentation/
```
