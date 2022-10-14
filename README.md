# Список контактов GDContacts
Проложение для списка контактов

## Функциональные возможности
Приложение работает в двух режимах:
  1. Онлайн режим
  2. Оффлайн режим (отображение данных предыущей сессии)

### Онлайн режим
При наличии сети список будет бесконечно расширяться, кешируя изображения и сохраняя данные в БД
<br>
<img src="docs/images/contact_list.PNG" width="300"/> 
<img src="docs/images/detail_screen.PNG" width="300"/>
<br/>

### Оффлайн режим
В случае отсутствия подключения к сети при запуске, приложение восстановит данные из предыдущей сессии из БД
<br>
<img src="docs/images/contact_list_offline.PNG" width="300"/> 
<img src="docs/images/offline_alert.PNG" width="300"/>
<br/>

Нажатие на изображение открывает его на весь экран

## Внешние зависимости
Приложение использует внешние зависимости

### Установка pods
Команду `pod install` выполнять не нужно, так как поды проиндексированы.
Это сделано по той причине, что для устаревшей библиотеки (SimpleImageViewer) были внесены изменения вручную

### Установленные зависимости
В проект установлены pods:
- [Kingfisher](https://github.com/onevcat/Kingfisher) - Кеширование изображений
- [SimpleImageViewer](https://github.com/LcTwisk/SimpleImageViewer) - Предпросмотр изображений

### Выявленные проблемы зависимостей
#### SimpleImageViewer
1. Начиная с iOS 13.0 dragging жест для закрытия экрана предпросмотра скрывает status bar в приложении. По этой причине превью показывает изображение без возможности закрыть его жестом.

### Дополнительно
В приложении используются иконки [Font-Awesome](https://github.com/FortAwesome/Font-Awesome)