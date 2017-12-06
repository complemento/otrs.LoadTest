# otrs.LoadTest
A simple Load test for OTRS. Creates ticket in some queue and measure how many seconds it takes.

## Installation
You need to create a OTRS Web Service

Download otrs.LoadTest.sh  to your server or a linux machine

```wget https://raw.githubusercontent.com/complemento/otrs.LoadTest/master/otrs.LoadTest.sh```

Give it execution permission 

```chmod +x otrs.LoadTest.sh```

## Configuration

Edit the parameters inside it

```vim otrs.LoadTest.sh```

| Variable | Description |
| ------ | ------ |
| WEBSERVICE | Web Service ending point |
| USER | Agent user name with write permission on the queue |
| PASSWORD | Agent password |
| CUSTOMER_LOGIN | Customer login for who the ticket will be create (we need one) |
| TYPE | Ticket type |
| QUEUE | Ticket Queue |
| STATE | Ticket state |
| PRIORITY | Ticket Priority |
| TEST_FILE | A local file which will be attached to the ticket. Use small files |
| FILE_CONTENT_TYPE | File content type |

## Usage

```./otrs.LoadTest.sh [-l 2] [-s 2] [-h]```

-h    Shows this help message

-l    Number of loops

-s    Sleep until next loop

