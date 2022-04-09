# Lost Files Downloader — скрипт для скачивания файлов с удаленного сервера с сохранением файловой структуры
Скрипт lostfilesdownloader.sh написан на bash и предназначен для скачивания списка файлов любого формата с удаленного сервера на локальный сервер с сохранением структуры файлов.

## Требования к списку файлов
1. Список файлов для скачивания должен быть в отдельном txt файле.
2. В txt файле не должно быть ничего, кроме адресов файлов на удаленном сервере.
3. Каждый адрес файла на новой строке, без протокола и доменного имени. Первый символ обязательно "/".

Пример:
```
/path1/file1.jpg
/path2/file2.jpg
```

## Установка и запуск
1. Перед началом работы перейти в директорию, в которую будут скачиваться файлы с удаленного сервера.
2. В этой же директории разместить txt файл со списком файлов.
3. Скачать скрипт на сервер.
`git clone https://github.com/vasiliykvasov/lostfilesdownloader.git`
4. Сделать скрипт исполняемым.
`chmod u+x lostfilesdownloader/lostfilesdownloader.sh`
5. Запустить скрипт.
`lostfilesdownloader/lostfilesdownloader.sh`

После запуска скрипта нужно ввести:
- протокол и адрес удаленного сервера (https://example.com);
- имя txt файла со списком файлов (example.txt).
    
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

Все уведомления отображаются в терминале и дублируются в файл логов lostfilesdownloader.log в рабочей директории.
