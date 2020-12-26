parser grammar NginxParser;


options {
    tokenVocab = NginxLexer;
}

input: context+;

context: context_name SPACE* context_value;
context_name: LOWER_STRING;
context_value: LEFT_OPENING_BRACE (SPACE|field_group|context|location+)* RIGTH_OPENING_BRACE;

location: location_left_field op=SPACE location_middle_field op=SPACE location_right_field;
location_left_field: LOCATION;
location_middle_field: STRING_WITH_OTHER;
location_right_field: LEFT_OPENING_BRACE (SPACE|field_group)* RIGTH_OPENING_BRACE;


field_group : fg_left op=SPACE fg_right S1_DELIMITER;

fg_left: LOWER_STRING | LOWER_STRING_WITH_UNDER_LINE;
fg_right:  LOWER_STRING | STRING | STRING_WITH_OTHER;