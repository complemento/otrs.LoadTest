#!/bin/bash

# Variables ####################################################################################
WEBSERVICE="http://localhost/otrs/nph-genericinterface.pl/Webservice/Otrs/TicketCreate"
USER="myagentuser"
PASSWORD="mypassword"
CUSTOMER_LOGIN="customerlogin"
TYPE="default"
QUEUE="Raw"
STATE="new"
PRIORITY="3 normal"
TEST_FILE="/path/to/my/testfile.png"
FILE_CONTENT_TYPE="image/png"


## these ones you can redefine with -l and -s options
# HOW MANY LOOPS. FOR INFINITY LOOP, USE 0
LOOPS="0"
SLEEP="0"


trap break SIGINT SIGTERM

while getopts ":l:s:h" opt; do
  case $opt in
    l) LOOPS="$OPTARG"
    ;;
    s) SLEEP="$OPTARG"
    ;;
    h) echo ""
        echo "This application requires curl and base64 linux programs"
        echo ""
        echo "Usage: ./otrs.LoadTest.sh [-l 2] [-s 2] [-h]"
        echo ""
        echo "-h    Shows this help message"
        echo "-l    Number of loops"
        echo "-s    Sleep until next loop"
        echo ""
        exit
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

COMMAND='curl "${WEBSERVICE}?UserLogin=${USER}&Password=${PASSWORD}" -H "Content-Type: application/json" -d "{\"Ticket\":{\"Title\":\"REST Create Test\", \"Type\": \"${TYPE}\", \"Queue\":\"${QUEUE}\",\"State\":\"${STATE}\",\"Priority\":\"${PRIORITY}\",\"CustomerUser\":\"${CUSTOMER_LOGIN}\"},\"Article\":{\"Subject\":\"Rest Create Test\",\"Body\":\"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin auctor venenatis sem, a bibendum leo pellentesque et. Sed at tincidunt ex. Sed nec libero vitae justo fermentum viverra. Sed aliquet magna ligula, ac iaculis felis viverra in. Donec vel sapien ullamcorper, consequat arcu quis, commodo nisl. Duis a sodales metus, quis tincidunt ex. Morbi eget elit arcu. Aliquam vel tincidunt lacus, in iaculis risus. Duis dignissim mi dapibus elit sagittis pharetra. Morbi consequat urna sit amet mi porta, nec maximus orci finibus.Praesent cursus enim vel lacinia maximus. Aenean feugiat vulputate elementum. Suspendisse vel lectus dignissim, consequat metus euismod, maximus arcu. Integer aliquam a augue vitae suscipit. Nam vitae ultricies tortor, interdum finibus elit. Mauris non ipsum non tellus porta tempus. Nullam viverra lacus quis semper hendrerit. Aenean at nunc nec arcu maximus imperdiet. Sed vulputate commodo justo sed dictum. Quisque dictum quam quis justo lacinia, sed sagittis tortor laoreet. Nulla vel massa eget ligula venenatis rhoncus sit amet id tortor. Sed lobortis, urna at tincidunt rutrum, nunc purus laoreet ex, ac interdum neque orci id sapien. Morbi finibus massa vel auctor rhoncus. Nullam mauris sapien, laoreet sed erat at, blandit ornare ligula. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. In facilisis purus nisi, id euismod erat ultricies eget. Curabitur malesuada in mi sed consectetur. Etiam ullamcorper ullamcorper augue sit amet sagittis. Suspendisse suscipit interdum lectus, in porttitor lacus iaculis ut. Ut commodo non ex quis ultrices. Aenean at placerat odio. Mauris eu risus ex. Donec tincidunt lacus nec lacus facilisis, sed semper risus volutpat. Phasellus nec mauris sollicitudin, imperdiet erat nec, sagittis nulla. Ut sed elementum tortor. Mauris faucibus aliquam elit. Duis at dui orci. Mauris vel nulla cursus sapien convallis malesuada ut et purus. Donec vitae lacus efficitur, pretium tortor nec, elementum metus. Quisque purus est, mattis in finibus non, tincidunt ut eros. Sed in felis et sapien congue semper sed iaculis quam. Etiam quis nibh erat. Ut placerat, erat sed sodales fermentum, odio tellus venenatis risus, eget accumsan quam neque sodales metus. Curabitur quis congue mi. Curabitur sit amet venenatis enim, maximus commodo massa. Sed condimentum feugiat dictum. Mauris tincidunt consequat ante, sit amet rhoncus ante efficitur congue. Donec a laoreet mauris. Proin tristique sit amet massa ut pharetra. Donec purus dolor, sodales nec lectus eu, porttitor suscipit ipsum. Nullam tempor augue nunc, ut luctus nibh bibendum ac. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Vivamus sollicitudin, leo non euismod finibus, felis orci elementum metus, quis mattis erat libero ut diam.\",\"ContentType\":\"text/plain; charset=utf8\"},\"Attachment\":{\"ContentType\":\"${FILE_CONTENT_TYPE}\",\"Filename\":\"${TEST_FILE##*/}\",\"Content\":\"$(base64 -w 0 ${TEST_FILE})\"}}"  -X POST'

START=$(date +%s)
if [ "0" = "${LOOPS}" ]; then
    while true; do echo ""; eval $COMMAND;  sleep ${SLEEP}; done
    ls -la
else
    ls
    COUNTER=0; while [  $COUNTER -lt ${LOOPS} ]; do  echo ""; eval $COMMAND; sleep ${SLEEP}; let COUNTER=COUNTER+1; done
fi
END=$(date +%s)
echo "";echo ""
echo "Total seconds: $(($END - $START))" 



