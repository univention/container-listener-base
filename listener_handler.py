#!/usr/bin/python3
# -*- coding: utf-8 -*-
#
# Univention Listener Converter
#  Listener integration
#
# SPDX-License-Identifier: AGPL-3.0-only
# SPDX-FileCopyrightText: 2021-2025 Univention GmbH

from univention.listener.handler import ListenerModuleHandler

name = 'dummy_handler'


class ListenerModuleTemplate(ListenerModuleHandler):
    def initialize(self):
        self.logger.info('handler stub initialize')

    def create(self, dn, new):
        self.logger.info('[ create ] dn: %r', dn)

    def modify(self, dn, old, new, old_dn):
        self.logger.info('[ modify ] dn: %r', dn)
        if old_dn:
            self.logger.debug('it is (also) a move! old_dn: %r', old_dn)
        self.logger.debug('changed attributes: %r', self.diff(old, new))

    def remove(self, dn, old):
        self.logger.info('[ remove ] dn: %r', dn)

    class Configuration(ListenerModuleHandler.Configuration):
        name = name
        description = 'dummy listener handler description'
        ldap_filter = '(objectClass=*)'
