# inwxupdate
Updates your [inwx](https://www.inwx.com)-DNS records with the local IPv6 address.

## How to use it
```
git clone https://github.com/ChaosSteffen/inwxupdate.git
cd inwxupdate
cp config.rb.example config.rb
vi config.rb
ruby inwxupdate.rb
```
**Bonus level:** Setup a cron-job who does it regularly.

```
# Example Crontab
SHELL=/usr/local/bin/zsh
PATH=/etc:/bin:/sbin:/usr/bin:/usr/sbin
# Order of crontab fields
# minute        hour    mday    month   wday    command
*/5             *       *       *       *       /usr/local/bin/ruby /home/username/inwxupdate/inwxupdate.rb > /home/username/inwxupdate.hasrun
```
