# Lost File Downloader
Скрипт lostfiledownloader.sh написан на bash и предназначен для скачивания списка файлов любого формата с удаленного сервера на локальный сервер с сохранением структуры файлов.

## Требования к списку файлов
1. Список файлов для скачивания должен быть в отдельном txt файле.
2. В файле не должно быть ничего, кроме адресов файлов на удаленном сервере.
3. Каждый адрес файла на новой строке, без протокола и доменного имени. Первый символ обязательно "/".

Пример:
```
/path1/file1.jpg
/path2/file2.jpg
```

## Установка и запуск
Скрипт нужно скачать на сервер.
`wget https://github.com/vasiliykvasov/lostfiledownloader/edit/main/lostfiledownloader.sh`
Перед запуском скрипта нужно перейти в директорию, в которую будут скачиваться файлы с удаленного сервера.
В этой же директории нужно разместить файл со списком файлов.
После запуска скрипта нужно ввести:
- протокол и адрес удаленного сервера (https://example.com);
- имя файла со списком файлов (example.txt).
    
## Как работает скрипт
- Скрипт проверяет, существует ли файл из списка на локальном сервере.
- Если файла не существует, скрипт проверяет, существует ли директория, в которую нужно скачать файл.
- Если директории не существует, скрипт создает директорию.
- После создания директории, скрипт снова проверяет, существует ли директория.
- Если директория существует, то скрипт проверяет, существует ли файл на удаленном сервере.
- Если файл существует на удаленном сервере, он скачивается в директорию.
- После скачивания, скрипт проверяет, существует ли теперь файл из списка на локальном сервере.

## Уведомления и логирования
Скрипт выводит уведомление о каждом действии.
При успешном создании файла выводится уведомление Success.
Если по какой-то причине создать директорию или файл не удалось, выводится уведомление Error.
Все уведомления отображаются как в терминале и дублируются в файл логов lostfiledownloader.log в рабочей директории.
