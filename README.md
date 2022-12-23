** Fork info **

Apparently, I have become the curator of this code by virtue of having
preserved the last remaining fork of the BigSQL fork of pgadmin3-lts.
Although a limited amount of maintenance work has occurred, there is no
active project leadership or commitments to maintain pgadmin-lts
compatibility with future releases of PostgreSQL.  The master branch is functional
with PostgreSQL 13.  YMMV.

Also, this GitHub repo will not vanish.

-- 
allentc


**# pgAdmin3 LTS by BigSQL README #**

pgAdmin3 has been superseded by pgAdmin4.  This repo exists to preserve
the work as it was left by BigSQL and consolidate whatever maintenance
effort occurs.  Binaries are not provided for any platform; you must build
the application yourself.

Introduction
------------

pgAdmin3 is a popular and feature rich Open Source administration and
development platform for PostgreSQL, the most advanced Open Source database in
the world.

pgAdmin3 is designed to answer the needs of all users, from writing simple 
SQL queries to developing complex databases. The graphical interface supports 
all PostgreSQL features and makes administration easy. The application also 
includes a syntax highlighting SQL editor, a server-side code editor, an 
SQL/batch/shell job scheduling agent, support for the Slony-I replication 
engine and much more. Server connection may be made using TCP/IP or Unix Domain
Sockets (on *nix platforms), and may be SSL encrypted for security. No 
additional drivers are required to communicate with the database server.

pgAdmin3 is Free Software released under the PostgreSQL License.

**# README by Datatrans #**

Code has been changed to adapt PostgreSQL internal changes up to version 13.1:
- No more relhasoids in pg_class.
- No more cache_value, is_cycled, is_called in sequence object (since PostgreSQL 11).
- No more adsrc in pg_attrdef, it should be calculated as pg_catalog.pg_get_expr(adbin, adrelid) instead.
- Declarative Table Partitioning DDL.

If you are too lazy to read [INSTALL](./INSTALL) instructions, then try this for Debian/Ubuntu/Mint:
------------------------
```
# apt-get install libwxgtk3.0-dev wx3.0-headers wxgtk3.0 wx3.0

# apt-get install libssh2-1 libssh2-1-dev libgcrypt20 libgcrypt20-dev libjson-perl libpq-dev #postgresql-13 postgresql-contrib-13 postgresql-client-13
# systemctl restart postgresql || true

$ bash bootstrap
$ ./configure --prefix=/opt/pgadmin3bigsql --with-libgcrypt --with-wx-version=3.0  CFLAGS=-fPIC CXXFLAGS=-fPIC #--with-pgsql=/usr/lib/postgresql/13 --without-sphinx-build
$ make -j8
$ sudo make install
```
