#!/bin/sh

supervisor_laravel_queue(){
local ETC=/etc/supervisor/conf.d

[ -d $ETC ] || mkdir -p $ETC
[ -f $ETC/laravel-worker.conf ] && return 0
 echo "
[program:laravel-worker]
process_name=%(program_name)s_%(process_num)02d
command=php /home/wwwroot/laravel/go3c/laravel-5-boilerplate-master/artisan queue:work sqs --sleep=3 --tries=3
autostart=true
autorestart=true
user=forge
numprocs=8
redirect_stderr=true
stdout_logfile=/home/wwwroot/laravel/go3c/laravel-5-boilerplate-master/worker.log
" > $ETC/laravel-worker.conf
}

supervisor(){
  which supervisorctl || yum install -y supervisor.noarch
  supervisor_laravel_queue
}

$@
