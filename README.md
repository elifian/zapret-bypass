# Обход блокировок РКН

Этот проект помогает обойти блокировки Роскомнадзора (РКН) с использованием утилиты zapret.  
Для начала работы скачайте последний [релиз](https://github.com/elifian/zapret-bypass/releases) и распакуйте архив в отдельную папку.

- **`update_list.bat`** - Обновляет список блокировок РКН для актуальной работы программы (заполняет list.txt).
- **`general_1.bat`** - Запускает обход блокировок в стандартном режиме. 
- **`general_♾️.bat`** - Альтернативный вариант запуска с другими настройками.
## Работа с автозапуском (службы)
- **`service_1.bat`** - Устанавливает программу в автозапуск как службу Windows и запускает её.
- **`service_♾️.bat`** - Альтернативный вариант установки службы с другими параметрами.
- **`service_remove.bat`** - Останавливает службу и удаляет её из автозапуска.
## Файлы конфигурации
- `autohostlist.txt`  
Автоматически добавляет заблокированные домены, если подключение к ним не удалось. Однако этот механизм не всегда может сработать.  
- `list-exclude.txt`  
Позволяет исключить определённые домены из обхода блокировок. (можете дополнять)
- `list.txt`  
Статичный список доменов, заблокированных РКН. Обновляется с помощью `update_list.bat`.  
Также потребляет больше всех оперативной памяти, если нужно сэкономить и вам нет нужны обходить **ВСЕ** блокировки РКН, можете его удалить и создать новый, пустой файл.
- `list-additional.txt`  
Содержит дополнительные домены, такие как Discord, YouTube, Cloudflare ECH. (можете дополнять)
- `list-cloudflare&amazon.txt`  
Содержит список IP cloudflare, amazon.  
- `list-ipset.txt`  
Список IP-адресов, которые необходимо включить в обход. (можете дополнять)
- `list-steam-p2p.txt`  
Обходит блокировку по UDP steam p2p.
## Примечания
- На некоторых сборках Windows программа может не запускаться или не устанавливаться корректно.  
В таком случае запустите cmd от администратора в директории с .bat файлами и пропишите имя+расширение файла для запуска (например, `service_2.bat`)
- Убедитесь, что все файлы из архива находятся в одной папке, путь к которой указан на английском языке (без кириллицы) и не расположен на рабочем столе (например, `C:\zapret-bypass`), для обеспечения стабильной работы.  
- Для пользователей **РОСТЕЛЕКОМ** рекомендуется использовать **general_2.bat** и **service_2.bat**, так как они лучше всего подходят для этого провайдера.
## VirusTotal
Файлы на момент 6.0.0   
[winsw.exe (winsw)](https://www.virustotal.com/gui/file/62c88badcd4a5c3951e01ea54f47a7f04d6c96db2dc32848c275ff0e9df3078d/detection/f-62c88badcd4a5c3951e01ea54f47a7f04d6c96db2dc32848c275ff0e9df3078d-1750086173)  
`62C88BADCD4A5C3951E01EA54F47A7F04D6C96DB2DC32848C275FF0E9DF3078D` SHA256  
[winws.exe (zapret)](https://www.virustotal.com/gui/file/fa3b336cb70e22c3e6f0bb5b92ae7caeda53dab9786efb8e5513ad91a82d0609/detection/f-fa3b336cb70e22c3e6f0bb5b92ae7caeda53dab9786efb8e5513ad91a82d0609-1770654762)  
`FA3B336CB70E22C3E6F0BB5B92AE7CAEDA53DAB9786EFB8E5513AD91A82D0609` SHA256  
[cygwin1.dll (cygwin)](https://www.virustotal.com/gui/file/103104a52e5293ce418944725df19e2bf81ad9269b9a120d71d39028e821499b/detection/f-103104a52e5293ce418944725df19e2bf81ad9269b9a120d71d39028e821499b-1771261911)  
`103104A52E5293CE418944725DF19E2BF81AD9269B9A120D71D39028E821499B` SHA256  
[Monkey64.sys (windivert, но с обходом обнаружения)](https://www.virustotal.com/gui/file/8da085332782708d8767bcace5327a6ec7283c17cfb85e40b03cd2323a90ddc2/detection/f-8da085332782708d8767bcace5327a6ec7283c17cfb85e40b03cd2323a90ddc2-1771588033)  
`8DA085332782708D8767BCACE5327A6EC7283C17CFB85E40B03CD2323A90DDC2` SHA256  
[WinDivert.dll (windivert)](https://www.virustotal.com/gui/file/944368b7a6eb0a97701e152a9171267db66377cc31bde415ab5da22c7a09cc43/detection/f-944368b7a6eb0a97701e152a9171267db66377cc31bde415ab5da22c7a09cc43-1770868236)  
`944368B7A6EB0A97701E152A9171267DB66377CC31BDE415AB5DA22C7A09CC43` SHA256  
## Оригинальные репозитории
[zapret](https://github.com/bol-van/zapret) — основная утилита для обхода блокировок.  
[windivert](https://github.com/basil00/WinDivert) — зависимость для zapret.  
[cygwin](https://cygwin.com/index.html) - зависимость для zapret.  
[winsw](https://github.com/winsw/winsw) — инструмент для работы с windows-службами.
