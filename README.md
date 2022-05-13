# Для проверки работы вам потребуется установить:
- Ansible 2.9.6
- Oracle VirtualBox 6.0
- Vagrant Vagrant 2.2.19

Если по команде vagrant up из основной директории проекта выдает ошибку образа, требуется скачать и установить образ, аналогичный Centos 7 -  https://app.vagrantup.com/centos/boxes/7
Также трубется заменить название образа, которое вы указали при загрузке (команда vagrant box add --name ИМЯ_ОБРАЗА URL or Address to Image) в файле Vagrantfile проекта.

      Vagrant.configure("2") do |config|
         config.vm.box = "ИМЯ_ОБРАЗА"

------------------------------------------------------------

# Для проверки работы вам потребуется установить:
- Ansible 2.9.6
- Oracle VirtualBox 6.0
- Vagrant Vagrant 2.2.19

Если по команде vagrant up из основной директории проекта выдает ошибку образа, требуется скачать и установить образ, аналогичный Centos 7 -  https://app.vagrantup.com/centos/boxes/7
Также трубется заменить название образа, которое вы указали при загрузке (команда vagrant box add --name ИМЯ_ОБРАЗА URL or Address to Image) в файле Vagrantfile проекта.

      Vagrant.configure("2") do |config|
         config.vm.box = "ИМЯ_ОБРАЗА"

------------------------------------------------------------

# Дано:
- Поднять три виртуалки
- Объединить их разными vlan
1. Поднять OSPF между машинами на базе Quagga
2. Изобразить ассиметричный роутинг
3. Сделать один из линков "дорогим", но что бы при этом роутинг был симметричным

Формат сдачи:
Vagrantfile + ansible

# Решение: 
Выполним запуск стенда:

      $ vagrant up
Результатом будет 3 сервера с настроенным ассиметричным роутингом

![Иллюстрация к проекту](https://github.com/RaibeartRuadh/myospf/blob/main/diagram.png?raw=true)

Залогинимся на сервере 1
        
      $ vagran ssh server1

Получим данные по сетевым интерфейсам, таблице маршрутизации и маршруту до 10.30.0.1 (server2)
    
      $ ip a | grep 'inet '
      $ ip r
      $ tracepath tracepath 10.30.0.1

![Иллюстрация к проекту](https://github.com/RaibeartRuadh/myospf/blob/main/pic1.png?raw=true)

Повтоярем аналогичные действия на server2
Наш роутинг ассиметричный.

![Иллюстрация к проекту](https://github.com/RaibeartRuadh/myospf/blob/main/pic2.png?raw=true)

Чтобы сделать роутинг симметричным, а один из линков "дорогим", на нужно поменять стоимость интерфейсов
Переходим на server2 и, используя консоль "зебры", вносим изменения

![Иллюстрация к проекту](https://github.com/RaibeartRuadh/myospf/blob/main/pic3.png?raw=true)

Проверяем на server2 маршрут до 10.30.0.1

      $ tracepath tracepath 10.30.0.1
Видим, что линк стал дорогим и симметричным.


Материалы:
1. https://www.opennet.ru/man.shtml?topic=vtysh&category=1&russian=2
2. https://www.tux.in.ua/articles/2182
3. https://www.opennet.ru/man.shtml?topic=tracepath&category=8&russian=0

