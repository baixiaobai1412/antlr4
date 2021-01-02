parser grammar NginxParser;
options {
    tokenVocab = NginxLexer;
}

input: context input
     |EOF;

context:field_group
       |events
       |http
       ;

events:EVENTS SPACE* events_right_field;
events_left:USE
           |WORKER_CONNECTIONS
           ;
events_right:right+;
events_group:events_left op=SPACE events_right delimiter;
events_right_field:LEFT_OPENING_BRACE
                   (SPACE|events_group)+
                   RIGTH_OPENING_BRACE ;

http:HTTP SPACE* http_right_field;
http_left:INCLUDE|DEFAULT_TYPE|ACCESS_LOG|SERVER_NAMES_HASH_BUCKET_SIZE
         |SERVER_NAME_IN_REDIRECT|CLIENT_HEADER_BUFFER_SIZE|LARGE_CLIENT_HEADER_BUFFERS
         |SENDFILE|TCP_NOPUSH|KEEPALIVE_TIMEOUT|CLIENT_HEADER_TIMEOUT|CLIENT_BODY_TIMEOUT
         |SEND_TIMEOUT|GZIP|GZIP_MIN_LENGTH|GZIP_BUFFERS|GZIP_HTTP_VERSION|GZIP_COMP_LEVEL
         |GZIP_TYPES|GZIP_VARY|PROXY_REDIRECT|PROXY_SET_HEADER|CLIENT_MAX_BODY_SIZE|CLIENT_BODY_BUFFER_SIZE
         |PROXY_CONNECT_TIMEOUT|PROXY_SEND_TIMEOUT|PROXY_READ_TIMEOUT|PROXY_BUFFER_SIZE|PROXY_BUFFERS
         |PROXY_BUSY_BUFFERS_SIZE|PROXY_TEMP_FILE_WRITE_SIZE|PROXY_NEXT_UPSTREAM|PROXY_MAX_TEMP_FILE_SIZE|INDEX
         ;
http_format:LOG_FORMAT op=SPACE http_right op=SPACE right_plus delimiter;
http_right:right;
http_group:http_left (op=SPACE http_right)+ delimiter;
http_right_field:LEFT_OPENING_BRACE (SPACE|http_group|http_format|server)+ RIGTH_OPENING_BRACE;

server:SERVER SPACE* server_right_field;
server_left:LISTEN|SERVER_NAME|ROOT|DEFAULT_TYPE|ACCESS_LOG|AUTOINDEX|AUTOINDEX_LOCALTIME|CHARSET;
server_right:right;
server_group:server_left (op=SPACE server_right)+ delimiter;
server_right_field:LEFT_OPENING_BRACE (SPACE|server_group|location)+ RIGTH_OPENING_BRACE;

location: location_left_field
          op=SPACE location_middle_field
          op=SPACE location_right_field;

location_left_field: LOCATION;
location_middle_field: STRING_WITH_OTHER;
location_right_field: LEFT_OPENING_BRACE
                    (SPACE|location_field_group)+
                    RIGTH_OPENING_BRACE;
location_left:ROOT;
location_field_group:location_left (op=SPACE right)+ delimiter;

right_plus:QUOTES (SPACE|right_plus_content)+ QUOTES ;
right_plus_content:LOWER_STRING_WITH_UNDER_LINE_DOLLAR_QUOTES
                     |MINUS
                     |LEFT_BRACKETS LOWER_STRING_WITH_UNDER_LINE_DOLLAR_QUOTES RIGTH_BRACKETS
                     |DOUBLE_QUOTES LOWER_STRING_WITH_UNDER_LINE_DOLLAR_QUOTES DOUBLE_QUOTES
                     ;

right
        :LOWER_STRING //小写
        |STRING //大小写字符串
        |LOWER_STRING_WITH_UNDER_LINE //带下划线的小写
        |LOWER_STRING_WITH_UNDER_LINE_DOLLAR_QUOTES // $ 引号 
        |STRING_WITH_OTHER //剩下所有可能性
        ;

fg_left
       :USER
       |WORKER_PROCESSES
       |ERROR_LOG
       |PID
       |WORKER_RLIMIT_NOFILE
       ;

fg_right:right;
field_group :fg_left (op=SPACE fg_right)+ delimiter;
delimiter:SPACE* DELIMITER SPACE*;
