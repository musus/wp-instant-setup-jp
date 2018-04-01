# WordPress Installer on your desktop.

WordPress development environment with PHP built-in web server + WP-CLI.

## Requires

* OSX
* php 5.4 or later
* MySQL
* wget

### Recommend

* [Composer](https://getcomposer.org/)
* [Mailcatcher](http://mailcatcher.me/)

## Uage

```
$ curl https://.../run.sh | bash -s <db-name>
```

or

```
$ ./run.sh <db-name>
```

### Defaults

* db-user: `root`
* db-pass: (empty)
* db-name: `wpdev`

## How to use

```
$ mkdir ~/Desktop/wordpress && cd $_
$ curl https://raw.githubusercontent.com/miya0001/wp-instant-setup/master/run.sh | bash
```

Or

```
$ git clone git@github.com:miya0001/wp-instant-setup.git && cd wp-instant-setup
$ ./run.sh
```


## Default Account

* User: `admin`
* Password: `admin`

## Advanced Tips

```

Then just run:

```
$ wpserve <db-name>
```
