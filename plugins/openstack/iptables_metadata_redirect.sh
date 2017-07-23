#!/bin/bash

# Copyright (C) 2017   Robin Cernin (rcernin@redhat.com)

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# we can run this against fs snapshot or live system

if [ "x$CITELLUS_LIVE" = "x1" ];  then

  if  rpm -qa | grep -q "tripleo-heat-templates" && rpm -qa | grep -q \
  "python-tripleoclient"
  then
    if iptables -t nat -vnL | grep -q "REDIRECT.*169.254.169.254" ; then
      exit 0
    else
      exit 1
    fi
  else
    exit 2
  fi
fi

if [ "x$CITELLUS_LIVE" = "x0" ];  then

  if [ ! -f "${CITELLUS_ROOT}/sos_commands/networking/iptables_-t_nat_-nvL" ]; then
    echo "file /sos_commands/networking/iptables_-t_nat_-nvL not found." >&2
    exit 2
  fi
  if grep -q "REDIRECT.*169.254.169.254" "${CITELLUS_ROOT}/sos_commands/networking/iptables_-t_nat_-nvL" ; then
    exit 0
  else
    exit 1
  fi
fi
