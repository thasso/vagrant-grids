torque-server:
    pkg:
        - installed
        - require: 
            - file: /etc/hosts
    service:
        - running
        - watch:
            - file: /var/spool/torque/server_name
            - file: /var/spool/torque/server_priv/nodes

torque-scheduler:
    pkg:
        - installed
    service:
        - running
        - watch:
            - file: /var/spool/torque/server_name
            - file: /var/spool/torque/server_priv/nodes

torque-mom:
    pkg:
        - installed
    service:
        - running
        - watch:
            - file: /var/spool/torque/mom_priv/config

/var/spool/torque/server_name:
    file.managed:
        - source: salt://pbs/config
        - require:
            - pkg: torque-server

/var/spool/torque/mom_priv/config:
    file.managed:
        - source: salt://pbs/config
        - require:
            - pkg: torque-mom

/var/spool/torque/server_priv/nodes:
    file.managed:
        - source: salt://pbs/config
        - require:
            - pkg: torque-server

/var/spool/torque/server_priv/acl_svr/acl_hosts:
    file.managed:
        - source: salt://pbs/config
        - require:
            - pkg: torque-server

/etc/hosts:
    file.managed:
        - source: salt://pbs/hosts

init_queues:
    cmd.script:
        - source: salt://pbs/init_queue.sh
        - mode: 0755 
