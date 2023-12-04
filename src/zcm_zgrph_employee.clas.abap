CLASS zcm_zgrph_employee DEFINITION PUBLIC
  INHERITING FROM cx_static_check FINAL CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_abap_behv_message .
    INTERFACES if_t100_message .
    INTERFACES if_t100_dyn_msg .

    CONSTANTS:
      BEGIN OF test_message,
        msgid TYPE symsgid VALUE 'Z_ZGRPH_EMPLOYEE',
        msgno TYPE symsgno VALUE '001',
        attr1 TYPE scx_attrname VALUE 'SURENAME',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF test_message .

    DATA surename TYPE zgrph_employeesurname.

    METHODS constructor
      IMPORTING
        severity  TYPE if_abap_behv_message=>t_severity
        !textid   LIKE if_t100_message=>t100key OPTIONAL
        !previous LIKE previous OPTIONAL
        surename  TYPE zgrph_employeesurname OPTIONAL .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcm_zgrph_employee IMPLEMENTATION.
  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor( previous = previous ).

    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.

    if_abap_behv_message~m_severity = severity.
    me->surename = surename.

  ENDMETHOD.
ENDCLASS.
