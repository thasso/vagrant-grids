ncurses-dev:
    pkg:
        - installed

tcl-dev:
    pkg:
        - installed

/tmp/openlava-2.2:
    cmd:
        - run
        - name: "tar xzvf /tmp/openlava-2.2.tar.gz"
        - require:
            - file: /tmp/openlava-2.2.tar.gz
        - unless: "[ -d /tmp/openlava-2.2 ]"
        - cwd: /tmp
    file:
        - managed
        - directory
    file: 
        - managed
        - user: root
        - group: root
        - mode: '0600'
        - name: /tmp/openlava-2.2.tar.gz
        - source: http://www.openlava.org/tarball/openlava-2.2.tar.gz
        - source_hash: md5=bff7b418308d20dc6ab388a2bbaa3e18

install:
    cmd:
        - run
        - name: './configure && make && make install'
        - cwd: /tmp/openlava-2.2
        - unless: "[ -d /opt/openlava-2.2 ]"
        - require:
            - file: /tmp/openlava-2.2
    file:
        - directory
        - name: /opt/openlava-2.2

openlava:
    file:
        - managed
        - name: /etc/init.d/openlava
        - mode: '0755'
        - user: root
        - grou: root
        - source: salt://openlava/openlava
        - require:
            - file: /opt/openlava-2.2
            - file: config_files
            - file: /etc/profile.d/openlava.sh
    service:
        - running
        - require:
            - file: /etc/init.d/openlava
        - watch:
            - file: config_files

/etc/profile.d/openlava.sh:
    file:
        - managed
        - source: salt://openlava/openlava.sh

config_files:
    file.recurse:
        - name: /opt/openlava-2.2/etc
        - source: salt://openlava/etc
        
