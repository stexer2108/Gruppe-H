CLASS zcm_zgrph_employee DEFINITION PUBLIC
  INHERITING FROM cx_static_check FINAL CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_abap_behv_message .
    INTERFACES if_t100_message .
    INTERFACES if_t100_dyn_msg .

    CONSTANTS:
      BEGIN OF request_applied_successfully,
        msgid TYPE symsgid VALUE 'Z_ZGRPH_EMPLOYEE',
        msgno TYPE symsgno VALUE '001',
        attr1 TYPE scx_attrname VALUE 'COMMENT',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF request_applied_successfully .

    DATA comment TYPE zgrph_comment.


    CONSTANTS:
      BEGIN OF request_approved_successfully,
        msgid TYPE symsgid VALUE 'Z_ZGRPH_EMPLOYEE',
        msgno TYPE symsgno VALUE '002',
        attr1 TYPE scx_attrname VALUE 'COMMENT',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF request_approved_successfully .

    CONSTANTS:
      BEGIN OF request_rejected,
        msgid TYPE symsgid VALUE 'Z_ZGRPH_EMPLOYEE',
        msgno TYPE symsgno VALUE '003',
        attr1 TYPE scx_attrname VALUE 'COMMENT',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF request_rejected .

    CONSTANTS:
      BEGIN OF request_cancelled_succesfully,
        msgid TYPE symsgid VALUE 'Z_ZGRPH_EMPLOYEE',
        msgno TYPE symsgno VALUE '004',
        attr1 TYPE scx_attrname VALUE 'COMMENT',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF request_cancelled_succesfully .

    CONSTANTS:
      BEGIN OF approver_must_exist,
        msgid TYPE symsgid VALUE 'Z_ZGRPH_EMPLOYEE',
        msgno TYPE symsgno VALUE '005',
        attr1 TYPE scx_attrname VALUE 'COMMENT',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF approver_must_exist .

    CONSTANTS:
      BEGIN OF endDate_after_startDate,
        msgid TYPE symsgid VALUE 'Z_ZGRPH_EMPLOYEE',
        msgno TYPE symsgno VALUE '006',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF endDate_after_startDate .

    CONSTANTS:
      BEGIN OF date_in_the_past,
        msgid TYPE symsgid VALUE 'Z_ZGRPH_EMPLOYEE',
        msgno TYPE symsgno VALUE '007',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF date_in_the_past .

   CONSTANTS:
      BEGIN OF days_not_enought,
        msgid TYPE symsgid VALUE 'Z_ZGRPH_EMPLOYEE',
        msgno TYPE symsgno VALUE '008',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF days_not_enought .

   CONSTANTS:
      BEGIN OF request_already_approved,
        msgid TYPE symsgid VALUE 'Z_ZGRPH_EMPLOYEE',
        msgno TYPE symsgno VALUE '009',
        attr1 TYPE scx_attrname VALUE 'COMMENT',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF request_already_approved .

   METHODS constructor
      IMPORTING
        severity  TYPE if_abap_behv_message=>t_severity
        !textid   LIKE if_t100_message=>t100key OPTIONAL
        !previous LIKE previous OPTIONAL
        comment  TYPE zgrph_comment OPTIONAL .
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
    me->comment = comment.

  ENDMETHOD.
ENDCLASS.
