# BeerApp(WIP)


![Демонстрация работы приложения](https://github.com/mikkerman/BeerApp/blob/master/BeerApp/Resource/Assets.xcassets/demo.gif)


## Описание

BeerApp - это приложение для платформы iOS, предназначенное для любителей пива. Оно позволяет пользователям сканировать штрихкод бутылки пива и получать подробную информацию о нем. Приложение содержит два основных экрана: экран камеры и экран с информацией о пиве.

## Функциональность

- **Экран камеры**: Приложение открывает камеру сразу после запуска, и пользователь может видеть изображение с камеры. Существует рамка, указывающая на место для расположения штрихкода. На экране также есть текстовый элемент, указывающий пользователю держать штрихкод внутри рамки для сканирования. 

- **Экран информации о пиве**: После сканирования штрихкода пива, отображается экран с информацией о пиве. Этот экран показывает фотографию бутылки пива и детальные сведения о пиве, такие как его название, производитель, страна происхождения, содержание алкоголя, описание вкуса и т.д. Кнопка "Назад" позволяет вернуться на экран камеры для продолжения сканирования.

## Используемые технологии
         
- Язык программирования Swift
- UIKit для создания интерфейса
- Библиотека AVFoundation для сканирования штрихкода
- SwiftLint для поддержания качества кода
- SwiftyBeaver для логирования

## Архитектура

- Проект использует архитектуру MVP (Model-View-Presenter) для разделения логики и отображения.

## Примечание 
По причине отсутствия бекенда использован моковый api.

