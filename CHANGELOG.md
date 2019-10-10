# CHANGELOG

## 0.1.23

* Added support for **RHEL 8**

## 0.1.22

* dropped descriptions for cracklib facts

## 0.1.21

* Added support for Ubuntu to **pam::unix**

## 0.1.20

* renamed **cracklib** facts to **pam_cracklib**

## 0.1.19

* added support for Ubuntu 16.04 and 18.04 to **pam::cracklib** using libpam-pwquality

## 0.1.18

* Added support for SLES 12.4

## 0.1.17

* Added flag to disable security/limits.conf management: **pam::manage_security_limits**
* Updated medatata for SLES

## 0.1.16

* added ensure to **pam::securetty**
* basic Ubuntu 18.04 support

## 0.1.15

* added ensure to **pam::ttyaudit**

## 0.1.14

* improved CIS support by setting an arbitrary option order

## 0.1.13

* changed default settings for **pam::lockout**

## 0.1.12

* allow empty securetty file

## 0.1.11

* added **pam::securetty**

## 0.1.10

* moved **audit::tty** to **pam::ttyaudit**

## 0.1.9

* updated module dependencies

## 0.1.8

* fixed dependency for **pam::unix**

## 0.1.7

* added remember to **pam::unix**

## 0.1.6

* added **pam::wheel**

## 0.1.5

* added **user_whitelist** to disable account locking for a given set of users

## 0.1.4

*  fixed ubuntu restrictions

## 0.1.3

* **pam::lockout** for centos6 and centos7 implemented using **pam_faillock**

## 0.1.2

* bugfix limits

## 0.1.1

* merged eyp-limits to this module

## 0.1.0

* initial release
