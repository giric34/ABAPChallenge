CLASS zcl_abap_ch DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
   INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_abap_ch IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    out->write('Hello Worlds !!').

  ENDMETHOD.
ENDCLASS.
