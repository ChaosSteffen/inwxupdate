# inwxupdate
Updates your [inwx](https://www.inwx.com)-DNS records with the local IPv6 (or IPv4) address.

Now uses the official [INWX Domrobot client](https://github.com/inwx/ruby-client) for improved reliability and future-proof API access.

## Requirements

- Ruby >= 3.0.0
- Access to INWX account with API access

## How to use it

```
gem install inwxupdate
```

Create a config file (see this repo for example) and place it in one of the following places:

```
/etc/inwxupdate.config.rb
/usr/local/etc/inwxupdate.config.rb
~/inwxupdate.config.rb
./inwxupdate.config.rb
```

Then run:

```
inwxupdate
```

**Bonus level:** Setup a cron-job who does it regularly.

```
# Example Crontab
SHELL=/bin/sh
PATH=/etc:/bin:/sbin:/usr/bin:/usr/sbin
# Order of crontab fields
# minute        hour    mday    month   wday    command
*/5             *       *       *       *       inwxupdate > ~/inwxupdate.hasrun
```

## Recent Updates

- **v0.4.0**: Migrated to official INWX Domrobot gem for improved reliability
- Updated to Ruby >= 3.0.0 for modern compatibility  
- Enhanced IPv6 support in ipify detector
- Updated all dependencies to latest stable versions
