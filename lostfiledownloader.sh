#!/bin/bash

# Скрипт Lost File Downloader предназначен для скачивания списка файлов любого формата с удаленного сервера на локальный сервер с сохранением структуры файлов.
#
# Требования к списку файлов
# 1. Список файлов для скачивания должен быть в отдельном txt файле.
# 2. В файле не должно быть ничего, кроме адресов файлов на удаленном сервере.
# 3. Каждый адрес файла на новой строке, без протокола и доменного имени. Первый символ обязательно "/".
# Пример:
#    /path1/file1.jpg
#    /path2/file2.jpg
#
# Что нужно для запуска скрипта
# Перед запуском скрипта нужно перейти в директорию, в которую будут скачиваться файлы с удаленного сервера.
# В этой же директории нужно разместить файл со списком файлов.
# После запуска скрипта нужно ввести:
#     - протокол и адрес удаленного сервера (https://example.com);
#     - имя файла со списком файлов (example.txt).
#
# Как работает скрипт
# Скрипт проверяет, существует ли файл из списка на локальном сервере.
# Если файла не существует, скрипт проверяет, существует ли директория, в которую нужно скачать файл.
# Если директории не существует, скрипт создает директорию.
# После создания директории, скрипт снова проверяет, существует ли директория.
# Если директория существует, то скрипт проверяет, существует ли файл на удаленном сервере.
# Если файл существует на удаленном сервере, он скачивается в директорию.
# После скачивания, скрипт проверяет, существует ли теперь файл из списка на локальном сервере.

# Уведомления и логирования
# Скрипт выводит уведомление о каждом действии.
# При успешном создании файла выводится уведомление Success.
# Если по какой-то причине создать директорию или файл не удалось, выводится уведомление Error.
# Все уведомления отображаются как в терминале и дублируются в файл логов.

LOGFILE=lostfiledownloader.log
date +%d-%m-%Y\ %H:%M:%S >> $LOGFILE
echo "Logfile: $LOGFILE"
echo "Enter protocol and address of the remote server (https://example.com)"
read WEBSITE # Ввод адреса удаленного сервера
echo "Remote server: $WEBSITE" | tee -a $LOGFILE
echo "Enter data filename (example.txt)"
read FILENAME # Ввод имени файла со списком
echo "Filename: $FILENAME" | tee -a $LOGFILE

echo " " | tee -a $LOGFILE

readarray -t FILENAMES <$FILENAME # Загрузить файл со списком в массив FILENAMES
DIRECTORY=$PWD
echo "Directory: $DIRECTORY" | tee -a $LOGFILE

FILENAMES_COUNTER=0
for FILE in ${FILENAMES[@]}
do  # Для каждого элемента массива FILENAMES
    FILENAMES_COUNTER=$(($FILENAMES_COUNTER+1))
    echo "$FILENAMES_COUNTER / ${#FILENAMES[*]}" | tee -a $LOGFILE
    echo "Checking file: $DIRECTORY$FILE"  | tee -a $LOGFILE
    if [ ! -f $DIRECTORY$FILE ] # Если файла на сервере не существует
    then
        echo "File not exist: $DIRECTORY$FILE"  | tee -a $LOGFILE # Вывести уведомление, что файла на сервере не существует
        FILE_DIRECTORY=$(dirname $DIRECTORY$FILE) # Узнать директорию файла с помощью команды dirname
        echo "Checking directory  $FILE_DIRECTORY" | tee -a $LOGFILE
        if [ ! -d $FILE_DIRECTORY ] # Если директория не существует
        then
            echo "Directory not exist: $FILE_DIRECTORY" | tee -a $LOGFILE
            mkdir -p $FILE_DIRECTORY # Создать директорию с помощью команды mkdir
            if [ -d $FILE_DIRECTORY ] # Если директория существует
            then
                echo "Directory created: $FILE_DIRECTORY" | tee -a $LOGFILE
            fi
        else
            echo "Directory exist: $FILE_DIRECTORY" | tee -a $LOGFILE
        fi
        if [ -d $FILE_DIRECTORY ] # Если директория существует
        then
            if wget --spider $WEBSITE$FILE 2> /dev/null # Если файл существует на удаленном сервере
            then
                echo "Remote file exist: $WEBSITE$FILE" | tee -a $LOGFILE
                echo "Downloading: $WEBSITE$FILE" | tee -a $LOGFILE
                wget -P $FILE_DIRECTORY $WEBSITE$FILE # Скачать файл с удаленного сервера в заданную директорию
                if [ -f $DIRECTORY$FILE ] # Если файл на сервере существует
                then
                    echo "Success! File created: $DIRECTORY$FILE" | tee -a $LOGFILE
                else
                    echo "Error! File did not created!" | tee -a $LOGFILE
                fi
            else
                echo "Error! Remote file not exist: $WEBSITE$FILE" | tee -a $LOGFILE
            fi
        else
            echo "Error! Directory not created: $FILE_DIRECTORY" | tee -a $LOGFILE
        fi
    else
        echo "File exist:  $DIRECTORY$FILE" | tee -a $LOGFILE
    fi
    echo " " | tee -a $LOGFILE
done
echo "Finish!" | tee -a $LOGFILE
echo " " | tee -a $LOGFILE
