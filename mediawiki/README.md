Здесь находится все необходимое для сборки образа Docker-контейнера с вики-движком [MediaWiki](https://www.mediawiki.org/wiki/MediaWiki) 1.27. Контейнер получится самодостаточным, т. е. в нем будет как [Nginx](https://nginx.org), так и [PHP-FPM](http://php-fpm.org), управляемые [Supervisor](http://supervisord.org)'ом.

## Зависимости

1. [Соберите](https://github.com/tolstoyevsky/cusdeb-services/tree/master/mysql) образ Docker-контейнера с MySQL и запустите его.
2. Если вы хотите использовать расширение [VisualEditor](https://mediawiki.org/wiki/Extension:VisualEditor), то [соберите](https://github.com/tolstoyevsky/cusdeb-services/tree/master/parsoid) образ Docker-контейнера с [Parsoid](https://mediawiki.org/wiki/Parsoid) и запустите его.

## Подготовка к запуску и запуск MediaWiki

1. Сначала необходимо запустить скрипт `prepare.sh` с правами суперпользователя. Он создаст в `/srv` директорию `mediawiki` с двумя поддиректориями с нужными правами.

2. Затем собрать образ
```
$ docker build --force-rm -t mediawiki .
```

3. После этого создать базу (см. подробности [здесь](https://www.mediawiki.org/wiki/Manual:Installing_MediaWiki#Installation_continued))
```
$ docker run -it --rm --network=host mediawiki mysql -u root -h 127.0.0.1 -p
mysql> CREATE DATABASE knowledge_base;
```
где `knowledge_base` – имя целевой базы данных

4. Потом создать [таблицы](https://phabricator.wikimedia.org/diffusion/MW/browse/master/maintenance/tables.sql)
```
$ docker run -it --rm --network=host mediawiki sh -c 'mysql -u root -h 127.0.0.1 -p knowledge_base < /var/www/w/maintenance/tables.sql'
```

5. И, наконец, запустить контейнер
```
$ docker-compose up -d
```

## Конфигурация

`docker-compose.yml` позволяет указать, будет ли вики приватной или нет, настроить подключение к БД, а также многое другое. Далее представлено описание всех параметров.

| Параметр | Описание |
| --- | --- |
| WG_SITENAME             | Название вики. |
| WG_META_NAMESPACE       | [Пространство имен](https://mediawiki.org/wiki/Manual:Namespace/ru) проекта. |
| WG_PROTOCOL             | Протокол, который используется для доступа к вики. Возможные значения: `http` или `https`. |
| WG_SERVER               | Домен или IP-адрес вики. |
| WG_PASSWORD_SENDER      | Адрес электронной почты, с которого будут приходить письма с восстановлением пароля. |
| WG_DB_SERVER            | Адрес хоста СУБД. |
| WG_DB_NAME              | Имя базы данных. |
| WG_DB_USER              | Имя пользователя базы данных. |
| WG_DB_PASSWORD          | Пароль для доступа к базе данных. |
| ALLOW_ACCOUNT_CREATION  | Дать посетителям возможность создавать учетные записи. Возможные значения: `true` или `false`. |
| ALLOW_ACCOUNT_EDITING   | Дать пользователям возможность редактировать свои учетные записи. Возможные значения: `true` или `false`. |
| ALLOW_ANONYMOUS_READING | Пароль для доступа к базе данных. Возможные значения: `true` или `false`. Если используется `false`, то вики является **приватной**. |
| ALLOW_ANONYMOUS_EDITING | Пароль для доступа к базе данных. Возможные значения: `true` или `false`. |
| PARSOID_HOST            | Домен или IP-адрес машины, на которой запущен Parsoid (по умолчанию закомментирован). |
| PARSOID_PORT            | Порт, который слушает Parsoid (по умолчанию закомментирован). |
| PARSOID_PROTOCOL        | Протокол, который используется для доступа к Parsoid (по умолчанию закомментирован). Возможные значения: `http` или `https`. |

Обратите внимание на то, что разкомментирование параметров `PARSOID_HOST`, `PARSOID_PORT` и `PARSOID_PROTOCOL` включает расширение [VisualEditor](https://www.mediawiki.org/wiki/Extension:VisualEditor). По умолчанию эти параметры закомментированы и, соответственно, расширение выключено.
