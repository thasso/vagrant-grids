#!/bin/bash
#
# Initialize and configure SGE

# make the sgemaster a submit node
qconf -as sgemaster

if `qconf -sql | grep default.q -q`; then
    qconf -Mq /tmp/default.q
else
    qconf -Aq /tmp/default.q
fi

