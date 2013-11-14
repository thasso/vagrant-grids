gridengine:
    pkg.installed:
        - pkgs:
            - gridengine-master
            - gridengine-exec
            - gridengine-client

gridengine-master:
    require:
        - pkg: gridengine
    service:
        - running
        - watch:
            - file: /etc/gridengine/bootstrap
            - file: /etc/gridengine/configuration

gridengine-exec:
    require:
        - pkg: gridengine
    service:
        - running

initialize:
    require:
        - file: /tmp/default.q
        - pkg: gridengine
    cmd.script:
        - source: salt://sge/init_queues.sh
        - mode: 0755

/etc/gridengine/bootstrap:
    file.managed:
        - source: salt://sge/bootstrap
        - require:
            - pkg: gridengine

/etc/gridengine/configuration:
    file.managed:
        - source: salt://sge/configuration
        - require:
            - pkg: gridengine


/tmp/default.q:
    file.managed:
        - source: salt://sge/default.q
