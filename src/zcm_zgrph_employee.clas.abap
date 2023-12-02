CLASS zcm_zgrph_employee DEFINITION PUBLIC
  INHERITING FROM cx_static_check FINAL CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_abap_behv_message .
    INTERFACES if_t100_message .
    INTERFACES if_t100_dyn_msg .

    CONSTANTS:
      BEGIN OF request_cancelled_successfully,
        msgid TYPE symsgid VALUE 'Z_ZGRPH_EMPLOYEE',
        msgno TYPE symsgno VALUE '001',
        attr1 TYPE scx_attrname VALUE 'REQUEST_COMMENT',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF request_cancelled_successfully .

    DATA request_comment TYPE zgrph_comment.

    METHODS constructor
      IMPORTING
        severity  TYPE if_abap_behv_message=>t_severity
        !textid   LIKE if_t100_message=>t100key OPTIONAL
        !previous LIKE previous OPTIONAL
        request_comment TYPE zgrph_comment OPTIONAL .
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
    me->request_comment = request_comment.

  ENDMETHOD.
ENDCLASS.
