# utm4_zabbix_monitor
Мониторинг данных в УТМ 4.0.2 с помощью системы Zabbix 5.2.3

До обновления УТМ 3.0.8 пользовался мониторингом от @msiuka. После обновления систем УТМ 3.0.8, переделал данную систему для работы с УТМ 4.0.2.

Собирает данные:
- Версию УТМ
- FRAR ID
- EGAIS Error
- Количество неотправленных данных
- Дней до окончания GOST и FRAR лицензий
- Действие лицензии

Потребуеться: 
1) PowerShell версии 5 и более. Разрешение на выполнение скриптов в PowerShell - "Set-ExecutionPolicy Unrestricted -Force"
2) Zabbix agent на машине с установленным УТМ 4.
3) Zabbix сервер для отслеживания.

В папку "C:\Program Files\Zabbix Agent\zabbix_agentd.conf.d\" добавляем файл "utm.conf" конфигурации, что бы знал agent что и где включать....
В папке "C:\Program Files\Zabbix Agent\" добавляем файл "utm_zabbix.ps1" скрипта написаного на PowerShell для сбора данных с UTM.
Загрузка шаблона в Zabbix "zbx_export_templates.yaml" 
 
Все еще в процессе доработки, первичный вариант...

