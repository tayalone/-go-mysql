# Command

## Install dkp
```
dpkg -i /app/mysql-community-client-plugins_8.3.0-1debian11_amd64.deb

dpkg -i /app/mysql-connector-odbc_8.3.0-1debian11_amd64.deb
 ```

 ## position
 ```
 find / -name "libmyodbc8a.so" 2>/dev/null

/usr/lib/x86_64-linux-gnu/odbc/libmyodbc8a.so

find / -name "libmyodbc8w.so" 2>/dev/null

/usr/lib/x86_64-linux-gnu/odbc/libmyodbc8w.so

 ```