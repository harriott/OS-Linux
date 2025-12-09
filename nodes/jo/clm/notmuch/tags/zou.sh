#!/bin/bash
# vim: set et tw=0:

# $clMail/notmuch/tags/zou.sh

# reset my notmuch tags
# ---------------------

# check:
#  notmuch dump
#  notmuch search tag:zou | wc -l

# clear tags:
# n otmuch tag -zou -- "*"

notmuch tag +zou -- 'folder:/zou\/.*/ and not tag:zou' # add zou tags to all
notmuch tag -inbox -- 'folder:/zou\/[^I]/ and tag:inbox' # remove unneeded inbox tags

# individual folder tags:
notmuch tag +2015_19 -- folder:zou/2015-19 and not tag:2015_19
notmuch tag +2020_22 -- folder:zou/2020-22 and not tag:2020_22
notmuch tag +2023_24 -- folder:zou/2023-24 and not tag:2023_24
notmuch tag +archive -- folder:zou/Archives and not tag:archive
notmuch tag +trash -- folder:zou/Trash and not tag:trash
notmuch tag +drafts -- folder:zou/Drafts and not tag:drafts
notmuch tag +junk -- folder:zou/Junk and not tag:junk
notmuch tag +sent -- folder:zou/Sent and not tag:sent
notmuch tag +waiting -- folder:zou/Waiting and not tag:waiting
# $maild/zou

