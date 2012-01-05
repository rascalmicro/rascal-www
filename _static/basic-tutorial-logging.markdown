## Basic tutorial: logging data ##

## Logging to a flat file ##
$$code(lang=python)
import logging
logging.basicConfig(filename='/var/log/user.log', format='%(asctime)s %(message)s', datefmt='%d/%m/%Y %H:%M:%S')
logging.warning('This gets logged all the time.')
logging.debug('This only gets logged if you set level=DEBUG.')
$$/code

## Logging to a database ##

$$code(lang=python)
[root@rascal:~]: python
Python 2.6.6 (r266:84292, Oct 25 2011, 15:19:43) 
[GCC 4.3.3] on linux3
Type "help", "copyright", "credits" or "license" for more information.
>>> import sqlite3                                                             
>>> conn = sqlite3.connect('test.db')
>>> c = conn.cursor()
>>> c.execute('''create table stocks
... (date text, trans text, symbol text,
...  qty real, price real)''')
<sqlite3.Cursor object at 0x40576080>
>>> c.execute("""insert into stocks
...           values ('2006-01-05','BUY','RHAT',100,35.14)""")
<sqlite3.Cursor object at 0x40576080>
>>> conn.commit()
>>> c.close()
>>> c = conn.cursor()
>>> c.execute('select * from stocks order by price')
<sqlite3.Cursor object at 0x405760e0>
>>> for row in c:
...     print row
... 
(u'2006-01-05', u'BUY', u'RHAT', 100.0, 35.140000000000001)
>>>
$$/code


[1]: http://docs.python.org/library/time.html#time.strftime
[2]: http://docs.python.org/library/logging.html#logrecord-attributes