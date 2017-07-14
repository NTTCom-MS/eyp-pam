# pam

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
    * [What pam affects](#what-pam-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with pam](#beginning-with-pam)
4. [Usage](#usage)
5. [Reference](#reference)
5. [Limitations](#limitations)
6. [Development](#development)
    * [TODO](#todo)
    * [Contributing](#contributing)

## Overview

PAM modules, /etc/security/limits.conf and /etc/securetty management

## Module Description

### pam::lockout

CIS compliance using pam_faillock for CentOS 6 and 7:

```
# cat /etc/pam.d/password-auth
auth        required       pam_faillock.so preauth audit silent deny=5 unlock_time=900
auth        include        password-auth-ac
auth        [default=die]  pam_faillock.so authfail audit deny=5 unlock_time=900
auth        sufficient     pam_faillock.so authsucc audit deny=5 unlock_time=900

account     required       pam_faillock.so
account     include        password-auth-ac

password    include        password-auth-ac

session     include        password-auth-ac
```

```
# cat /etc/pam.d/system-auth
auth        required       pam_faillock.so preauth audit silent deny=5 unlock_time=900
auth        include        system-auth-ac
auth        [default=die]  pam_faillock.so authfail audit deny=5 unlock_time=900
auth        sufficient     pam_faillock.so authsucc audit deny=5 unlock_time=900

account     required       pam_faillock.so
account     include        system-auth-ac

password    include        system-auth-ac

session     include        system-auth-ac
```

## Setup

### What pam affects

* /etc/security/limits.conf
* system-auth config (/etc/pam.d)

### Setup Requirements

This module requires pluginsync enabled

### Beginning with pam

#### limits

```puppet
class { "limits": }

limits::limit { "nofile *":
  domain => "*",
  item => 'nofile',
  value => '123456',
}

limits::limit { "nproc *":
  domain => "*",
  item => 'nproc',
  value => '123456',
}
```

This will generate the following entries:

```
* - nofile 123456
* - nproc 123456
```

## Usage

Put the classes, types, and resources for customizing, configuring, and doing
the fancy stuff with your module here.

## Reference

### defines

#### pam::limit

All items support the values -1, unlimited or infinity indicating no limit, except for priority and nice.  

* domain: user, %group or * (means all)
* type: soft, hard or - (means both)
* item: can be one of the following:
 * core - limits the core file size (KB)
 * data - max data size (KB)
 * fsize - maximum filesize (KB)
 * memlock - max locked-in-memory address space (KB)
 * nofile - max number of open files
 * rss - max resident set size (KB)
 * stack - max stack size (KB)
 * cpu - max CPU time (MIN)
 * nproc - max number of processes
 * as - address space limit (KB)
 * maxlogins - max number of logins for this user
 * maxsyslogins - max number of logins on the system
 * priority - the priority to run user process with
 * locks - max number of file locks the user can hold
 * sigpending - max number of pending signals
 * msgqueue - max memory used by POSIX message queues (bytes)
 * nice - max nice priority allowed to raise to values: [-20, 19]
 * rtprio - max realtime priority
 * chroot - change root to directory (Debian-specific)
* value: value for item

## Limitations

This is where you list OS compatibility, version compatibility, etc.

## Development

We are pushing to have acceptance testing in place, so any new feature should
have some test to check both presence and absence of any feature

### TODO

TODO list

### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
