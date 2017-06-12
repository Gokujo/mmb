Здесь находятся скрипты для сборки базовых образов Docker, которые используются в основе всех образов из проекта `docker-services`. Обратите внимание на то, что архитектура базовых образов – armhf. Скрипты сборки используют `qemu-arm-static` для того, чтобы сделать возможной сборку базовых образов на машинах c архитектурой x86.

## Alpine

Для того чтобы собрать базовый образ на основе [Alpine 3.6](https://alpinelinux.org/posts/Alpine-3.6.2-released.html), запустите скрипт `create_alpine_chroot.sh` с правами суперпользователя. После удачного завершения работы скрипта будет создан образ `cusdeb/alpinev3.6_armhf:latest`.

## Debian

Для того чтобы собрать базовый образ на основе [Debian Jessie](https://debian.org/releases/jessie/index.en.html), запустите скрипт `create_debian_chroot.sh` с правами суперпользователя. После удачного завершения работы скрипта будет создан образ `cusdeb/jessie_armhf:latest`.

## Отличия от других похожих образов с Docker Hub

Базовые образы, полученные посредством `create_alpine_chroot.sh` и `create_debian_chroot.sh`, отличаются от аналогичных образов с [Docker Hub](https://hub.docker.com) в основном только наличием `qemu-user-static` в `/usr/bin`, что упрощает отладку контейнеров, т. к. они могут быть запущены на машинах c архитектурой x86.
