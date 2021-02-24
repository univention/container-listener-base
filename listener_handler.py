#!/usr/bin/python2.7
# -*- coding: utf-8 -*-
#
# Univention Listener Converter
#  Listener integration
#
# Copyright 2021 Univention GmbH
#
# https://www.univention.de/
#
# All rights reserved.
#
# The source code of this program is made available
# under the terms of the GNU Affero General Public License version 3
# (GNU AGPL V3) as published by the Free Software Foundation.
#
# Binary versions of this program provided by Univention to you as
# well as other copyrighted, protected or trademarked materials like
# Logos, graphics, fonts, specific documentations and configurations,
# cryptographic keys etc. are subject to a license agreement between
# you and Univention and not subject to the GNU AGPL V3.
#
# In the case you use this program under the terms of the GNU AGPL V3,
# the program is provided in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public
# License with the Debian GNU/Linux or Univention distribution in file
# /usr/share/common-licenses/AGPL-3; if not, see
# <https://www.gnu.org/licenses/>.
#

"""Listener Module Handler Dummy"""

from univention.listener.handler import ListenerModuleHandler


class AppListener(ListenerModuleHandler):
    """Handler class loaded by the univention-directory-listener"""
    def initialize(self):
        """Called by the listener on load"""
        self.logger.info('handler stub initialize')

    def create(self, distinguished_name, new):
        """Called when a LDAP-object has been created"""
        self.logger.info(
            f'handler stub create: dn {distinguished_name} new {new}'
        )

    def modify(self, distinguished_name, old, new, old_dn):
        """Called when a LDAP-object has been changed"""
        self.logger.info(
            f'handler stub modify: dn {distinguished_name} old {old} new {new} old_dn {old_dn}'
        )

    def remove(self, distinguished_name, old):
        """Called when a LDAP-object has been deleted"""
        self.logger.info(
            f'handler stub remove: dn {distinguished_name} old {old}'
        )

    class Configuration(ListenerModuleHandler.Configuration):
        """Handler class loaded by the univention-directory-listener"""
        def get_description(self):
            """Called by the listener to get the handler-description"""
            self.logger.info('handler config stub get_description')
            return 'Dummy listener module'

        def get_ldap_filter(self):
            """Called by the listener to get the handler-LDAP-filter"""
            self.logger.info('handler config stub get_ldap_filter')
            return '(univentionObjectType=<udm-module>)'


# [EOF]
